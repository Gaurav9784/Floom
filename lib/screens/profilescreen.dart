import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floom/screens/introauthscreen.dart';
import 'package:floom/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  bool dataIsThere = false;
  TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  editUsername() async {
    usercollection.doc(FirebaseAuth.instance.currentUser.uid).update(
      {'username': usernameController.text},
    );
    setState(() {
      username = usernameController.text;
      Navigator.pop(context);
    });
  }

  openProfileDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: usernameController,
                    style: myStyle(18, Colors.black),
                    decoration: InputDecoration(
                        labelStyle: myStyle(17, Colors.grey),
                        labelText: "Update Username"),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: editUsername,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: GradientColors.cherry),
                    ),
                    child: Center(
                      child: Text(
                        "Update Profile",
                        style: myStyle(17, Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getData() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
      dataIsThere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: dataIsThere == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 64,
                    top: MediaQuery.of(context).size.height / 3.8,
                  ),
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://th.bing.com/th/id/Re99f84f060d1b2cff9d9dcabab0e97bc?rik=h78Caz2EUTwx4A&riu=http%3a%2f%2fwww.marismith.com%2fwp-content%2fuploads%2f2014%2f07%2ffacebook-profile-blank-face.jpeg&ehk=7hcnnD0O4b5mikqWI07MBmjOWGeuNIs0UqadlVaeYss%3d&risl=&pid=ImgRaw'),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text(
                        username,
                        style: myStyle(40, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: openProfileDialog,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.cherry),
                          ),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: myStyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IntroAuthScreen(),
                              ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: GradientColors.facebookMessenger),
                          ),
                          child: Center(
                            child: Text(
                              "Log Out",
                              style: myStyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
