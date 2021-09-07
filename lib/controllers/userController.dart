import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_ventures/controllers/authenticationController.dart';

class UserController {
  final String uid;

  UserController({this.uid});

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  AuthenticationController authController = AuthenticationController();

  Future<String> createUser(
      String displayName, String email, String uid) async {
    try {
      Map<String, dynamic> data = {};
      data['displayName'] = displayName;
      data['email'] = email;
      await users.doc(uid).set(data);
      return "success";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
