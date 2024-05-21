import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/riverpod/providers.dart';
import 'package:zoom/screens/login_screen.dart';
import 'package:zoom/screens/sign_in_screen.dart';
import 'package:zoom/screens/sign_up_screen.dart';
import 'package:zoom/screens/team_chat_screen.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/error.dart';
import 'package:zoom/widgets/main_bottom_navigation.dart';
import 'screens/join_screen.dart';
import 'screens/meetings_screen.dart';
import 'screens/new_meeting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '../models/user.dart' as custom_user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authStateProvider);
    return MaterialApp(
      title: 'Zoom Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          splashColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1072ED))
              .copyWith(background: tertiaryWhite)),
      home: authenticationState.when(
        data: (data) {
          if (data != null) {
            // Delay setting the user state
            Future.microtask(() {
              ref.read(userProvider.notifier).setUser(
                    custom_user.User(
                      id: data.uid,
                      email: data.email!,
                      name: data.displayName!,
                      photoURL: data.photoURL!,
                    ),
                  );
            });
            return const MainBottomNavigation();
          }
          return const LoginScreen();
        },
        error: (error, stackTrace) => ErrorScreen(
          errorText: error.toString(),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/sign_in': (context) => const SignInScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/meetings': (context) => const MeetingScreen(),
        '/team_chat': (context) => TeamChatScreen(),
        '/new_meeting': (context) => const NewMeetingScreen(),
        '/join': (context) => const JoinScreen(),
      },
    );
  }
}
