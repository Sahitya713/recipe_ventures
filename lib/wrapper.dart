import 'package:flutter/material.dart';
import 'package:recipe_ventures/pages/navBar.dart';
import 'package:recipe_ventures/pages/welcomepage.dart';
import 'package:recipe_ventures/utils/globals.dart' as globals;

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid = globals.currUserId;
    if (uid == null) {
      return WelcomePage();
    } else {
      return Navbar();
    }

    return Container();
  }
}
