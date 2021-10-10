import 'dart:core';
import 'package:flutter/material.dart';
import 'package:recipe_ventures/data/favRecipe.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final List<FavRecipe> items = [
    FavRecipe(title: 'Mapo Tofu', id: '1'),
    FavRecipe(title: 'Grandma\'s Homemade Cookies', id: '2'),
    FavRecipe(title: 'Pork Cutlet', id: '3'),
  ];
  final bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourites', style: Theme.of(context).textTheme.headline6),
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          String title = items[index].getTitle();
          FavRecipe fav = items[index];
          bool isSaved = items.contains(fav);

          return ListTile(
              title: Text(title),
              trailing: IconButton(
                icon: Icon(
                  isSaved ? Icons.favorite : Icons.favorite_border,
                  color: isSaved ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    if (isSaved) {
                      // use when recipe page is up
                      // deleteFavourite(String favRecipeID);
                      items.remove(fav);
                    } else {
                      items.add(fav);
                    }
                  });
                },
              ));
        },
      ),
    );
  }
}
