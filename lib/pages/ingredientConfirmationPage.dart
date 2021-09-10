import 'package:flutter/material.dart';
import 'package:recipe_ventures/pages/store.dart';
import 'dart:io';

class IngredientConfirmationPage extends StatefulWidget {
  final List ingredientList;
  final File image;
  IngredientConfirmationPage(this.ingredientList, this.image);

  @override
  _IngredientConfirmationPageState createState() =>
      _IngredientConfirmationPageState();
}

class _IngredientConfirmationPageState
    extends State<IngredientConfirmationPage> {
  List<Widget> _generateList(ingredientList) {
    List<Widget> widgetList = [];
    int i;
    for (i = 0; i < ingredientList.length; i++) {
      widgetList.add(Text(ingredientList[i]));
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ingredient Confirmation',
            style: Theme.of(context).textTheme.headline6),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: AspectRatio(
                aspectRatio: 2 / 1.3,
                child: Image.file(
                  widget.image,
                  width: 100,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: _generateList(widget
                  .ingredientList), // <<<<< Note this change for the return type
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                // Send to store
                print('add to store');
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Store()),
                          );
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(170, 36),
                  primary: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
