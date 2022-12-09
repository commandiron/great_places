import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../add_place/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
          ? Center(child: CircularProgressIndicator(),)
          : Consumer<GreatPlaces>(
            child: Center(child: Text("Got no places yet, start adding some!"),),
            builder: (context, greatPlaces, child) => greatPlaces.items.length <= 0
              ? child
              : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[index].image),
                  ),
                  title: Text(greatPlaces.items[index].title),
                  onTap: () {
                    // Go to detail page...
                  },
                ),
              ),
          ),
        )
    );
  }
}
