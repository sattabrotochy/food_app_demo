import 'package:flutter/material.dart';
import 'package:food_app_demo/Page/signup_page.dart';

import 'login_page.dart';

class WelComePage extends StatelessWidget {
  var imageUrlIcon =
      'https://www.logopik.com/wp-content/uploads/edd/2018/07/Restaurant-Logo-Vector-Design.png';

  @override
  Widget build(BuildContext context) {

    void loginPage()
    {

      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));

    }

    void singUpPage()
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));

    }


    Widget button(String name, Color color, Color textColors,String pageRout) {
      return Container(
        height: 55,
        width: 300,
        child: MaterialButton(
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.green, width: 2)),
          onPressed: () {
            String pages="page1";

            if(pageRout==pages)
              {
                loginPage();
              }else{
              singUpPage();
            }


          },
          child: Text(
            name,
            style: TextStyle(fontSize: 20, color: textColors),
          ),
        ),
      );
    }



    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Image.network(imageUrlIcon),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Welcome to LALAL',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Column(
                      children: [
                        Text('Order food from our lalal restaurants '),
                        Text('My restaurants is very goog'),
                      ],
                    ),
                    button('Login', Colors.green, Colors.white,'page1'),
                    button('SingUp', Colors.white, Colors.green,'page2'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
