import 'package:flutter/material.dart';

class Store extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headline6),
      ),
      body: Center(
        child: Text('Store', style: Theme.of(context).textTheme.bodyText2),
      ),
    );
  }
}
