// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Meetings',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: const Color(0xFF37384C),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.info_circle,
                color: Colors.white, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            width: double.infinity,
            height: 106,
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/new_meeting'),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFF7432),
                            borderRadius: BorderRadius.circular(19)),
                        child: const Icon(
                          CupertinoIcons.video_camera_solid,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text('New Meeting',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6E6E6E),
                        ))
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/join'),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1072ED),
                            borderRadius: BorderRadius.circular(19)),
                        child: const Icon(
                          CupertinoIcons.plus_square_fill,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text('Join',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6E6E6E),
                        ))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: const Color(0xFF1072ED),
                          borderRadius: BorderRadius.circular(19)),
                      child: const Icon(
                        Icons.calendar_today_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text('Schedule',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6E6E6E),
                        ))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: const Color(0xFF1072ED),
                          borderRadius: BorderRadius.circular(19)),
                      child: const Icon(
                        CupertinoIcons.arrow_up_square_fill,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text('Share screen',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6E6E6E),
                        ))
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/calendar_big_icon.png',
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'No Upcoming Meetings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'The scheduled meetings will be listed here',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6E6E6E)),
                  )
                ]),
          )
        ]),
      ),
    );
  }
}
