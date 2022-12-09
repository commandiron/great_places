import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;

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
              onPressed: () {},
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text("Select on Map"),
            )
          ],
        )
      ],
    );
  }
}
