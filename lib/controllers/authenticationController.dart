import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return "success";
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "success";
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await user.sendEmailVerification();
      // create a new doc for the user with new id
      return user;
      // return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      print("trying to sign out");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
