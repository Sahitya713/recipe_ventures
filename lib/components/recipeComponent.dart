import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ventures/pages/recipedetails.dart';

class RecipeComponent extends StatefulWidget {
  int recipeID;
  String recipeName;

  RecipeComponent({
    @required this.recipeID,
    @required this.recipeName,
  });

  @override
  _RecipeComponentState createState() => _RecipeComponentState();
}

class _RecipeComponentState extends State<RecipeComponent> {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child:
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeDetails(recipeID: widget.recipeID)),
              );
            },
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.recipeName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        )
      ]
    );
  }
}