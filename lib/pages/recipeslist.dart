import 'package:flutter/material.dart';
import 'package:recipe_ventures/pages/recipedetails.dart';

import '../main.dart';

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recipes Recommendation', style: Theme.of(context).textTheme.headline6),
      ),
      body: // can use a list view builder to iterate and display
      Column(
        children: [
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeDetails()),
              );
            },
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Recipe 1',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeDetails()),
              );
            },
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Recipe 2',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );


  }
}
