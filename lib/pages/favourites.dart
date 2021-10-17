import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ventures/controllers/favouritesController.dart';
import 'package:recipe_ventures/data/favRecipe.dart';
import 'package:recipe_ventures/utils/globals.dart' as globals;

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  FavouritesController fc = FavouritesController();
  @override
  Widget build(BuildContext context) {
    // TODO: add comments to the favorites page.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourites', style: Theme.of(context).textTheme.headline6),
      ),
      body: StreamBuilder(
        stream: FavRecipe.getFavRecipes(globals.currUserId),
        builder: (context, AsyncSnapshot<List<FavRecipe>> snapshot) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    FavRecipe favorites = snapshot.data[index];

                    return ListTile(
                      leading: IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            setState(() => {fc.deleteFavourite(favorites.id)});
                          }),
                      title: Text(snapshot.data[index].title),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //            )); //to recipe page
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
