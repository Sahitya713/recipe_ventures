import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourites', style: Theme.of(context).textTheme.headline6),
      ),
      body: Center(
        child: Text('Favourites', style: Theme.of(context).textTheme.bodyText2),
      ),
    );
  }
}
