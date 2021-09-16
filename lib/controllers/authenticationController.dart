import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_ventures/controllers/userController.dart';

class AuthenticationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User getCurrUserFromFirebase() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {

      try {UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result.user.uid.isNotEmpty)
        print('Successful Login. User ID: ' + result.user.uid);
      return true;}

        catch (error){
        print(error.toString());
        print('Login Failed.');
        return false;


        }


    /*catch (error) {
      print(error.toString());
      return null;
    }*/
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
      String displayName, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await user.sendEmailVerification();

      // create a new doc for the user with new id
      String createUser =
          await UserController().createUser(displayName, email, user.uid);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
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
