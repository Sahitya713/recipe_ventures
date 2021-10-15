import 'package:flutter/material.dart';
import 'package:recipe_ventures/components/recipeComponent.dart';
import 'package:recipe_ventures/controllers/recipeController.dart';
import 'package:recipe_ventures/data/recipe.dart';

import '../main.dart';

class RecipeDetails extends StatefulWidget{
  int recipeID;

  RecipeDetails({
    @required this.recipeID,
  });

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {

  RecipeController rc = RecipeController();
  var result;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getRecipesList(String recipeID)  {
    return FutureBuilder(
        future: rc.getRecipe(recipeID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: new Column(
                  children: [
                    new Container(
                        child: Text(snapshot.data.title, style: Theme.of(context).textTheme.headline6)
                    ),
                    SizedBox(height: 10,),
                    new Container(
                      child: Image.network(snapshot.data.image),
                    ),
                    SizedBox(height: 10,),
                    new Container(
                      child: Text("Ingredients Needed", style: Theme.of(context).textTheme.headline6)
                    ),
                    SizedBox(height: 10,),
                    new Container(
                      child: Text(snapshot.data.ingredients.toString())
                    ),
                    SizedBox(height: 10,),
                    new Container(
                      child: Text("Instructions", style: Theme.of(context).textTheme.headline6)
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(snapshot.data.instructions),
                    ),
                    SizedBox(height: 10,),
                  ],
                )
              )
            );
          }
          return Container();
        });

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recipe Details', style: Theme.of(context).textTheme.headline6),
      ),
      body: _getRecipesList(widget.recipeID.toString())
      );
  }
}