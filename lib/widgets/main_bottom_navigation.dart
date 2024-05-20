import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom/screens/meetings_screen.dart';
import 'package:zoom/screens/team_chat_screen.dart';

class MainBottomNavigation extends StatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  State<MainBottomNavigation> createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {
  late int selectedIndex = 0;

  final List<Widget> pages = [
    const MeetingScreen(),
    TeamChatScreen(),
    const Text('This is a Mail Screen'),
    const Text('This is a Calendar Screen'),
    const Text('More')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: pages[selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          useLegacyColorScheme: false,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          selectedFontSize: 12,
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 0
                    ? CupertinoIcons.video_camera_solid
                    : CupertinoIcons.video_camera,
                size: 26,
              ),
              label: 'Meetings',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 1
                    ? CupertinoIcons.bubble_left_bubble_right_fill
                    : CupertinoIcons.bubble_left_bubble_right,
                size: 26,
              ),
              label: 'Team Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 2
                      ? CupertinoIcons.mail_solid
                      : CupertinoIcons.mail,
                  size: 26),
              label: 'Mail',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 3
                      ? Icons.calendar_today_rounded
                      : Icons.calendar_today_outlined,
                  size: 26),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 4
                    ? Icons.more_horiz
                    : Icons.more_horiz_outlined,
                size: 26,
              ),
              label: 'More',
            ),
          ],
        ));
  }
}
