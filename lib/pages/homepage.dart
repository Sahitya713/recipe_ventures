import 'package:flutter/material.dart';
import 'package:recipe_ventures/controllers/test.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome', style: Theme.of(context).textTheme.headline6),
      ),
      body: Center(
        // child: Text('upload Image'),
        child: GestureDetector(
            onTap: () {
              TestManager().getTest();
            },
            child: Text('upload Image', style: Theme.of(context).textTheme.bodyText2)),
      ),
    );
  }
}
