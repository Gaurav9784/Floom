import 'package:firebase_auth/firebase_auth.dart';
import 'package:floom/screens/profilescreen.dart';
import 'package:floom/screens/videoconferencescreen.dart';
import 'package:floom/variables.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageOptions = [
    VideoConferenceScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: myStyle(17, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: myStyle(17, Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.video_call,
                size: 32,
              ),
              label: "Video Call"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 32,
              ),
              label: "Profile"),
        ],
      ),
      body: pageOptions[page],
    );
  }
}
