import 'package:flutter/material.dart';
import 'package:zoom/screens/login_screen.dart';
import 'package:zoom/screens/sign_in_screen.dart';
import 'package:zoom/screens/sign_up_screen.dart';
import 'package:zoom/screens/team_chat_screen.dart';
import 'package:zoom/utils/colors.dart';
import 'screens/join_screen.dart';
import 'screens/meetings_screen.dart';
import 'screens/new_meeting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          useMaterial3: true,
          splashColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1072ED))
              .copyWith(background: tertiaryWhite)),
      home: LoginScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => LoginScreen());

          case '/sign_in':
            return MaterialPageRoute(builder: (context) => SignInScreen());

          case '/sign_up':
            return MaterialPageRoute(builder: (context) => SignUpScreen());

          case '/meetings':
            return MaterialPageRoute(builder: (context) => MeetingScreen());

          case '/team_chat':
            //final args = settings.arguments as SecondPageArguments;
            return MaterialPageRoute(
              builder: (context) => TeamChatScreen(),
            );

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
