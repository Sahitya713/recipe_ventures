import 'package:flutter/material.dart';
import 'package:recipe_ventures/controllers/authenticationController.dart';
import 'package:recipe_ventures/pages/signuppage.dart';
import 'package:recipe_ventures/pages/navBar.dart';

class LoginPage extends StatelessWidget {
  @override

  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Login", style: Theme.of(context).textTheme.headline4),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Login to your account",
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Text('Email Address', style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: 5),
                      TextField(
                        controller: myEmailController,
                        decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]),),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
                        obscureText: false
                      ),

                      Text('Password', style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: 5),
                      TextField(
                          controller: myPasswordController,
                          decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]),),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
                          obscureText: true
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        print("Login pressed");
                        final loginBoolean = await AuthenticationController()
                            .signInWithEmailAndPassword(
                            myEmailController.text.trim(),
                            myPasswordController.text.trim());
                        if (loginBoolean == true) {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => Navbar()));
                        }
                        else if (loginBoolean == false)
                          {showDialog(context:context,
                              builder: (BuildContext context)
                              {return AlertDialog(title: Text("Failed to log in. Please try again"),
                                  titleTextStyle: Theme.of(context).textTheme.subtitle1);
                              });
                          }
                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("Login",
                          style: Theme.of(context).textTheme.button),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    TextButton(
                        child: Text("Sign Up",
                            style: Theme.of(context).textTheme.button),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        }),
                  ],
                ),

                /*Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.fitHeight
                    ),

                  ),
                )*/
              ],
            ))
          ],
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false}) {
  final myController = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: myController,
        obscureText: obscureText,
        decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]),),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
