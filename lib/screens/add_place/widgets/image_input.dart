import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {

  final Function onSelect;

  ImageInput({this.onSelect});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File _storedImage;


  Future<void>_takePicture() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600
    );
    if(imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy("${appDir.path}/${fileName}");
    widget.onSelect(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 160,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          child: _storedImage != null
            ? Image.file(
              _storedImage,
              fit: BoxFit.cover,
              width: double.infinity,
            )
            : Text("No Image Taken"),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              _takePicture();
            },
            icon: Icon(Icons.camera),
            label: Text("Take Picture"),
          ),
        )
      ],
    );
  }
}
