import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ventures/pages/navBar.dart';
import 'package:recipe_ventures/pages/welcomepage.dart';
import 'package:recipe_ventures/utils/globals.dart' as globals;

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    // String uid = globals.currUserId;
    if (user == null) {
      return WelcomePage();
    } else {
      return Navbar();
    }

    return Container();
  }
}
