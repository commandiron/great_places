import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:flutter_complete_guide/screens/add_place/add_place_screen.dart';
import 'package:flutter_complete_guide/screens/place_detail/place_detail_screen.dart';
import 'package:flutter_complete_guide/screens/places_list/places_list_screen.dart';
import 'package:provider/provider.dart';

import 'screens/map/map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
              primary: Colors.indigo,
              primaryContainer: Colors.amber,
              onPrimaryContainer: Colors.black,
              onSurface: Colors.red
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber),
                foregroundColor: MaterialStatePropertyAll(Colors.black),
              )
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        home: PlacesListScreen(),
        routes : {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
        }
      ),
    );
  }
}
