import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.info_circle),
            onPressed: () {},
          ),
        ],
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.add_rounded),
          title: Text('New meeting'),
          onTap: () {/* Implement your action */},
        ),
        ListTile(
          leading: Icon(Icons.add_rounded),
          title: Text('Join'),
          onTap: () {/* Implement your action */},
        ),
        ListTile(
          leading: Icon(Icons.schedule_rounded),
          title: Text('Schedule'),
          onTap: () {/* Implement your action */},
        ),
        ListTile(
          leading: Icon(Icons.screen_share_rounded),
          title: Text('Share screen'),
          onTap: () {/* Implement your action */},
        ),
        // Add more items...
      ],
    );
  }
}
