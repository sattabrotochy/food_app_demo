import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/Page/signup_page.dart';

import 'widget/my_text_field..dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  UserCredential userCredential;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  GlobalKey<ScaffoldState> globalKeyLogin = GlobalKey<ScaffoldState>();

  Future userValidation() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        globalKeyLogin.currentState.showSnackBar(SnackBar(
          content: Text(
            "No user found for that email.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'wrong-password') {
        globalKeyLogin.currentState.showSnackBar(SnackBar(
          content: Text(
            "Wrong password provided for that user.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      globalKeyLogin.currentState.showSnackBar(SnackBar(
        content: Text(
          e,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));

      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void ValidationLogin() {
    if (email.text.trim().isEmpty) {
      globalKeyLogin.currentState.showSnackBar(SnackBar(
        content: Text(
          "email is empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (password.text.trim().isEmpty) {
      globalKeyLogin.currentState.showSnackBar(SnackBar(
        content: Text(
          "password is empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    } else {
      setState(() {
        isLoading = true;
      });
      userValidation();
      globalKeyLogin.currentState.showSnackBar(SnackBar(
        content: Text(
          "Successful",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKeyLogin,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('FooD'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 160),
              child: Text(
                'Log In',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            Column(
              children: [
                MyTextField(
                  name: "Email",
                  iconData: Icons.email,
                  obscureText: false,
                  controller: email,
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  name: "Password",
                  iconData: Icons.lock,
                  obscureText: true,
                  controller: password,
                ),
              ],
            ),
            isLoading
                ? CircularProgressIndicator()
                : Container(
                    height: 60,
                    width: 300,
                    child: MaterialButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        ValidationLogin();
                      },
                      child: Text(
                        "login",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Users?",
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    "Register now",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
