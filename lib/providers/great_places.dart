import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String title, File image, LatLng latLng) async {
    final address = await LocationHelper.getPlaceAddress(latLng.latitude, latLng.longitude);
    final id = DateTime.now().toString();
    _items.add(
      Place(
        id: id,
        title: title,
        location: PlaceLocation(
          latitude: latLng.latitude,
          longitude: latLng.longitude,
          address: address
        ),
        image: image
      )
    );
    notifyListeners();
    DBHelper.insert(
      "great_places",
      {
        "id" : id,
        "title" : title,
        "image" : image.path,
        "loc_lat" : latLng.latitude,
        "loc_lng" : latLng.longitude,
        "address" : address
      }
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("great_places");
    _items = dataList.map(
      (place) => Place(
        id: place["id"],
        title: place["title"],
        location: PlaceLocation(
          latitude: place["loc_lat"],
          longitude: place["loc_lng"],
          address: place["address"]
        ),
        image: File(place["image"])
      )
    ).toList();
    notifyListeners();
  }
}