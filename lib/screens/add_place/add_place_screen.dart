import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:flutter_complete_guide/screens/add_place/widgets/image_input.dart';
import 'package:flutter_complete_guide/screens/add_place/widgets/location_input.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName = "/add-place";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
  File _selectedImage;
  LatLng _selectedLatLng;

  void _onSelectImage(File selectedImage) {
    _selectedImage = selectedImage;
    print(_selectedImage);
  }

  void _onSelectLocation(LatLng latLng) {
    _selectedLatLng = latLng;
    print(latLng);
  }

  void _addPlace() {
    if(_titleController.text.isEmpty ||
        _selectedImage == null ||
        _selectedLatLng == null
    ) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _selectedImage,
      _selectedLatLng
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: "Title"),
                    ),
                    SizedBox(height: 10,),
                    ImageInput(onSelect: _onSelectImage),
                    SizedBox(height: 10,),
                    LocationInput(onSelect: _onSelectLocation)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _addPlace,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            style: ElevatedButtonTheme.of(context).style.copyWith(
              elevation: MaterialStatePropertyAll(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
          )
        ],
      ),
    );
  }
}

