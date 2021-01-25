

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/Page/widget/my_text_field..dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading=false;
  UserCredential userCredential;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController number = new TextEditingController();
  TextEditingController address = new TextEditingController();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future sendData() async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      await FirebaseFirestore.instance.collection('userData').doc(userCredential.user.uid).set({

        'id':userCredential.user.uid,
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'number': number.text,
        'address': address.text,
      });

      globalKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Successful",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      Navigator.of(context).pop();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        globalKey.currentState.showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        globalKey.currentState.showSnackBar(
            SnackBar(content: Text('The account already exists for that email.')));

      }
    } catch (e) {
      globalKey.currentState.showSnackBar(
      SnackBar(content: Text(e)));

      setState(() {
        isLoading=false;
      });
    }
    setState(() {
      isLoading=false;
    });

  }

  void validation() {
    if (name.text.trim().isEmpty) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "name is empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (email.text.trim().isEmpty) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "name is empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (password.text.trim().isEmpty) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "name is empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (number.text.trim().isEmpty) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "name is empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (address.text.trim().isEmpty) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "name is empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    else{
      setState(() {
        isLoading=true;
      });
      sendData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  MyTextField(
                    name: "Name",
                    iconData: Icons.person,
                    obscureText: false,
                    controller: name,
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                    name: "password",
                    iconData: Icons.lock,
                    obscureText: true,
                    controller: password,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    name: "Number",
                    iconData: Icons.phone,
                    obscureText: false,
                    controller: number,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    name: "Address",
                    iconData: Icons.location_on,
                    obscureText: false,
                    controller: address,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              isLoading? CircularProgressIndicator():Container(
                height: 50,
                width: 300,
                child: MaterialButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    validation();
                    sendData();
                  },
                  child: Text(
                    "Registration",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
