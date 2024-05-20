import 'package:flutter/material.dart';
import 'package:zoom/screens/join_screen.dart';
import 'package:zoom/screens/login_screen.dart';
import 'package:zoom/screens/new_meeting_screen.dart';
import 'screens/meetings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoom Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1072ED)),
        useMaterial3: true,
        splashColor: Colors.transparent,
      ),
      home: LoginScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => MeetingScreen());
          case '/new_meeting':
            //final args = settings.arguments as SecondPageArguments;
            return MaterialPageRoute(
              builder: (context) => NewMeetingScreen(),
            );
          case '/join':
            //final args = settings.arguments as SecondPageArguments;
            return MaterialPageRoute(
              builder: (context) => JoinScreen(),
            );
          default:
          //return MaterialPageRoute(builder: (context) => UndefinedPage(name: settings.name));
        }
      },
    );
  }
}
