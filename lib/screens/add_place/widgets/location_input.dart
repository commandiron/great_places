import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';
import 'package:flutter_complete_guide/helpers/permission_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../map/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelect;

  LocationInput({this.onSelect});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    try{
      final locData = await Location().getLocation();
      final latLng = LatLng(locData.latitude, locData.longitude);

      _showPreview(latLng);
      widget.onSelect(latLng);

    }catch(e){
      final permissionStatus = await PermissionHelper.getLocationPermissionStatus();
      if(permissionStatus.isDenied) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please allow location permission."))
        );
      }
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLatLng = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      )
    );
    if(selectedLatLng == null) {
      return;
    }

    _showPreview(selectedLatLng);
    widget.onSelect(selectedLatLng);
  }

  void _showPreview(LatLng latLng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: latLng.latitude,
        longitude: latLng.longitude
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          child: _previewImageUrl == null
            ? Text("No Location Chosen", textAlign: TextAlign.center,)
            : Image.network(_previewImageUrl, fit: BoxFit.cover,)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton.icon(
              onPressed: () {
                _getCurrentUserLocation();
              },
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text("Select on Map"),
            )
          ],
        )
      ],
    );
  }
}
