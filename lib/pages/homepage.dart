import 'package:flutter/material.dart';
import 'package:recipe_ventures/controllers/test.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        // child: Text('upload Image'),
        child: GestureDetector(
            onTap: () {
              TestManager().getTest();
            },
            child: Text('upload Image')),
      ),
    );
  }
}
