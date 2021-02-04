import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floom/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  bool isAudioMuted = false;
  bool isVideoMuted = false;
  TextEditingController roomcontroller = TextEditingController();
  String username = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
    });
  }

  joinMeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      if (Platform.isAndroid) {
        featureFlag.callIntegrationEnabled = false;
      } else if (Platform.isIOS) {
        featureFlag.pipEnabled = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomcontroller.text
        ..userDisplayName =
            namecontroller.text == "" ? username : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlag = featureFlag;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Room Code :",
                style: myStyle(20),
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                appContext: context,
                controller: roomcontroller,
                length: 6,
                onChanged: (value) {},
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                ),
                animationDuration: const Duration(milliseconds: 300),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: namecontroller,
                style: myStyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: myStyle(15),
                  labelText: "Leave(If you want your username)",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value;
                  });
                },
                title: Text(
                  "Video Muted",
                  style: myStyle(20, Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  "Audio Muted",
                  style: myStyle(20, Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Ofcourse, You can customize your settings in the meeting",
                style: myStyle(15),
                textAlign: TextAlign.center,
              ),
              Divider(
                thickness: 2,
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  return joinMeeting();
                },
                child: Container(
                  height: 64,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger),
                  ),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style: myStyle(20, Colors.white),
                    ),
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
