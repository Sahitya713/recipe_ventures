import 'package:flutter/material.dart';

import '../main.dart';

class RecipeDetails extends StatefulWidget{
  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recipe Details', style: Theme.of(context).textTheme.headline6),
      )
    );
  }
}