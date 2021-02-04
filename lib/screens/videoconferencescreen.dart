import 'package:floom/variables.dart';
import 'package:floom/videoconference/createmeeting.dart';
import 'package:floom/videoconference/joinmeeting.dart';
import 'package:flutter/material.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  buildTab(String name) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: 150,
      height: 50,
      child: Center(
        child: Text(
          name,
          style: myStyle(15, Colors.black, FontWeight.w700),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text(
          "FLOOM",
          style: myStyle(20, Colors.white, FontWeight.w700),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildTab("Join Meetings"),
            buildTab("Create Meetings"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeeting(),
          CreateMeeting(),
        ],
      ),
    );
  }
}
