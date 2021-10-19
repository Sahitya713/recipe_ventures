import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:recipe_ventures/components/recipeComponent.dart';
import 'package:recipe_ventures/controllers/favouritesController.dart';
import 'package:recipe_ventures/controllers/recipeController.dart';
import 'package:recipe_ventures/data/appUser.dart';
import 'package:recipe_ventures/data/recipe.dart';
import 'package:html/parser.dart';

import '../main.dart';

class RecipeDetails extends StatefulWidget {
  int recipeID;
  String recipeName;

  RecipeDetails({@required this.recipeID, @required this.recipeName});

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  RecipeController rc = RecipeController();
  FavouritesController fc = FavouritesController();
  var result;
  bool addedTofav = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _addFavConfirmation(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Press ok to add this recipe to your favourites!",
                style: Theme.of(context).textTheme.bodyText2),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      child: Text('cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  MaterialButton(
                      child: Text('ok'),
                      onPressed: () {
                        fc.addFavourite(
                            widget.recipeID, widget.recipeName, user.uid);
                        setState(() {
                          addedTofav = true;
                        });
                        // setState(() {
                        //   _visibilityTag = false;
                        // });
                        Navigator.pop(context);
                      }),
                ],
              )
            ],
          );
        });
  }

  _buildInstructions(String instructions) {
    var doc = parse(instructions);
    var elements = doc.getElementsByTagName('li');
    return ListView.builder(
        shrinkWrap: true,
        itemCount: elements.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Flexible(
              child: Text(
                (index + 1).toString() + '. ' + elements[index].text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ]));
        });
  }

  Widget _getRecipesList(String recipeID) {
    return FutureBuilder(
        future: rc.getRecipe(recipeID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: SingleChildScrollView(
                    child: new Column(
              children: [
                new Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(snapshot.data.title,
                        style: Theme.of(context).textTheme.headline4)),
                SizedBox(
                  height: 10,
                ),
                new Container(
                  padding: EdgeInsets.all(16.0),
                  child: Image.network(snapshot.data.image),
                ),
                SizedBox(
                  height: 10,
                ),
                new Container(
                    child: Text("Ingredients Needed",
                        style: Theme.of(context).textTheme.headline5)),
                SizedBox(
                  height: 10,
                ),
                new Column(
                  children: <Widget>[
                    for (var ingredient in snapshot.data.ingredients)
                      ListTile(
                        leading: Icon(Icons.fiber_manual_record),
                        title: new Text(
                          ingredient,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                new Container(
                    child: Text("Instructions",
                        style: Theme.of(context).textTheme.headline5)),
                new Column(children: [
                  _buildInstructions(snapshot.data.instructions),
                ]),
                SizedBox(
                  height: 10,
                ),
              ],
            )));
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Recipe Details',
                style: Theme.of(context).textTheme.headline6),
            actions: [
              IconButton(
                icon: Icon(
                  addedTofav ? Icons.favorite : Icons.favorite_border,
                  color: addedTofav ? Colors.red[700] : null,
                  size: 30,
                ),
                onPressed: () {
                  _addFavConfirmation(context);
                },
              )
            ]),
        body: _getRecipesList(widget.recipeID.toString()));
  }
}
