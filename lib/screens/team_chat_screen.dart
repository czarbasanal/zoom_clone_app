// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Team Chat',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: const Color(0xFF37384C),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.add, color: Colors.white, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
            child: CupertinoTextField(
              placeholder: 'Search',
              placeholderStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color(0xFF6E6E6E),
              ),
              prefix: Padding(
                padding: const EdgeInsets.fromLTRB(9.0, 6.0, 1.0, 6.0),
                child: Icon(
                  CupertinoIcons.search,
                  color: Color(0xFF6e7681),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFf1f0f5),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Container(
            height: 120.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                CupertinoIconButton(
                    icon: CupertinoIcons.star_fill, label: 'Starred'),
                CupertinoIconButton(
                    icon: CupertinoIcons.folder_fill, label: 'Folders'),
                CupertinoIconButton(icon: CupertinoIcons.at, label: 'Mentions'),
                CupertinoIconButton(
                    icon: CupertinoIcons.arrow_up_right_square_fill,
                    label: 'Drafts & S...'),
                CupertinoIconButton(
                    icon: CupertinoIcons.bookmark_fill, label: 'Bookmarks'),
                CupertinoIconButton(
                    icon: CupertinoIcons.news_solid, label: 'Files'),
                CupertinoIconButton(
                    icon: CupertinoIcons.alarm_fill, label: 'Reminders'),
                CupertinoIconButton(
                    icon: CupertinoIcons.person_add_solid,
                    label: 'Contact R...'),
                CupertinoIconButton(
                    icon: CupertinoIcons.gear_solid, label: 'Customize'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    "Messages"),
                Icon(CupertinoIcons.line_horizontal_3_decrease),
              ],
            ),
          ),
          Container(
            height: 50,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Czar Jay Basanal (you)'),
                  leading: CircleAvatar(),
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(width: 200, height: 200, "assets/startChatting.png"),
          SizedBox(
            height: 20,
          ),
          Text("Find People and start chatting!"),
          SizedBox(
            height: 50,
          ),
          Center(
            child: CupertinoButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.create, color: CupertinoColors.white),
                  SizedBox(width: 10),
                  Text(
                    'Start new chat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                ],
              ),
              color: CupertinoColors.activeBlue,
              onPressed: () {
                // TODO: Handle button press
              },
            ),
          )
        ],
      ),
    );
  }

  Widget CupertinoIconButton({required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xFFf1f0f5),
            ),
            child: Icon(
              icon,
              size: 35,
              color: Color(0xFF6e7681),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF6e7681),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
