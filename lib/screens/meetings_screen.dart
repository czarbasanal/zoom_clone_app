import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.info_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color(0xFF37384C),
      ),
      body: Center(
        child: _getWidgetOption(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0
                ? CupertinoIcons.video_camera_solid
                : CupertinoIcons.video_camera),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? CupertinoIcons.chat_bubble_2_fill
                : CupertinoIcons.chat_bubble_2),
            label: 'Team Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2
                ? CupertinoIcons.mail_solid
                : CupertinoIcons.mail),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3
                ? Icons.calendar_today
                : Icons.calendar_today_outlined),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 4
                ? Icons.more_horiz
                : Icons.more_horiz_outlined),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 12,
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 1,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getWidgetOption(int index) {
    switch (index) {
      case 0:
        return MeetingsScreen();
      case 1:
        return Text('Team Chat');
      case 2:
        return Text('Mail');
      case 3:
        return Text('Calendar');
      case 4:
        return Text('More');
      default:
        return Text('Error');
    }
  }
}

class MeetingsScreen extends StatelessWidget {
  const MeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        height: 130,
        padding: EdgeInsets.all(20),
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
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFF7432),
                      borderRadius: BorderRadius.circular(22)),
                  child: const Icon(
                    CupertinoIcons.video_camera_solid,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('New Meeting',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6E6E6E),
                    ))
              ],
            )
          ],
        ),
      )
    ]);
  }
}
