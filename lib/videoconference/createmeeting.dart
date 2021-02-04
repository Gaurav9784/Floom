import 'package:floom/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:uuid/uuid.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = "";
  createCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Create a code for your meeting",
              textAlign: TextAlign.center,
              style: myStyle(20),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Code: ",
                style: myStyle(30),
              ),
              Text(
                code,
                style: myStyle(30, Colors.purple),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: createCode,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: GradientColors.facebookMessenger),
              ),
              child: Center(
                child: Text(
                  "Create Code",
                  style: myStyle(20, Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
