import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final id = DateTime.now().toString();
    _items.add(
      Place(
        id: id,
        title: title,
        location: null,
        image: image
      )
    );
    notifyListeners();
    DBHelper.insert(
      "great_places",
      {
        "id" : id,
        "title" : title,
        "image" : image.path
      }
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("great_places");
    _items = dataList.map(
      (place) => Place(
        id: place["id"],
        title: place["title"],
        location: null,
        image: File(place["image"])
      )
    ).toList();
    notifyListeners();
  }
}