import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

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
            icon: const Icon(
              CupertinoIcons.info_circle,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color(0xFF37384C),
      ),
      body: Center(
        child: _getWidgetOption(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0
                  ? CupertinoIcons.video_camera_solid
                  : CupertinoIcons.video_camera,
              size: 26,
            ),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? CupertinoIcons.bubble_left_bubble_right_fill
                  : CupertinoIcons.bubble_left_bubble_right,
              size: 26,
            ),
            label: 'Team Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 2
                    ? CupertinoIcons.mail_solid
                    : CupertinoIcons.mail,
                size: 26),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3
                    ? Icons.calendar_today_rounded
                    : Icons.calendar_today_outlined,
                size: 26),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4
                  ? Icons.more_horiz
                  : Icons.more_horiz_outlined,
              size: 26,
            ),
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
    return Column(mainAxisSize: MainAxisSize.max, children: [
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
                Container(
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
                const SizedBox(
                  height: 6,
                ),
                const Text('New Meeting',
                    style: TextStyle(
                      fontSize: 12,
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
                    CupertinoIcons.plus_square_fill,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text('Join',
                    style: TextStyle(
                      fontSize: 12,
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
                      fontSize: 12,
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
                      fontSize: 12,
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
    ]);
  }
}
