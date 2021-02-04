// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

import '../variables.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: GradientColors.blue),
            ),
            child: Center(
              child: Image.asset(
                "images/logo.png",
                height: 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.50),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: usernamecontroller,
                      style: myStyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Username",
                        hintStyle: myStyle(20, Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: emailcontroller,
                      style: myStyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                        hintStyle: myStyle(20, Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: passwordcontroller,
                      style: myStyle(18, Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Password(MIN 6 Characters)",
                        hintStyle: myStyle(15, Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailcontroller.text,
                                password: passwordcontroller.text)
                            .then(
                              (signeduser) =>
                                  usercollection.doc(signeduser.user.uid).set(
                                {
                                  'username': usernamecontroller.text,
                                  'email': emailcontroller.text,
                                  'password': passwordcontroller.text,
                                  'uid': signeduser.user.uid,
                                },
                              ),
                            );
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                        var snackbar = SnackBar(
                          content: Text(
                            e.toString(),
                            style: myStyle(20),
                          ),
                        );
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.pink),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN UP",
                          style: myStyle(25, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
