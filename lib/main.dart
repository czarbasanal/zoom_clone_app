import 'package:flutter/material.dart';
import 'package:zoom_clone_app/screens/new_meeting_screen.dart';
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
      home: NewMeetingScreen(),
    );
  }
}
