import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom/authentication/auth_service_implementation.dart';
import 'package:zoom/meetiings/meeting_service_implementation.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  bool _isVideoOn = false;
  bool _isAudioOn = false;

  final AuthServiceImplementation authServiceImplementation =
      AuthServiceImplementation();
  late final TextEditingController idController;
  late final TextEditingController nameController;
  final MeetingServiceImplementation meetingServiceImplementation =
      MeetingServiceImplementation();

  @override
  void initState() {
    idController = TextEditingController();
    nameController =
        TextEditingController(text: authServiceImplementation.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();

    super.dispose();
  }

  joinMeeting() {
    meetingServiceImplementation.createMeeting(
      idController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.15),
        scrolledUnderElevation: 0,
        title: const Text('Join a meeting',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              CupertinoIcons.chevron_left,
              size: 30,
            ),
            color: const Color(0xFF1072ED),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 0.75,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.25),
                  ),
                ],
              ),
              child: TextField(
                  controller: idController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: 'Meeting ID',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6E6E6E),
                      ),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(height: 24),
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 0.75,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.25),
                  ),
                ],
              ),
              child: TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6E6E6E),
                      ),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: TextButton(
                  onPressed: () {
                    joinMeeting();
                  },
                  style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 0),
                      backgroundColor: const Color(0XFF1072ED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.all(14)),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                  'If you received an invitation link, tap on the link to join the meeting',
                  style: TextStyle(color: Color(0XFF6E6E6E))),
            ),
            const SizedBox(
              height: 36,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 6),
                  child: Text('Join options',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0XFF6E6E6E),
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 0.75,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.25),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Don\'t Connect To Audio'),
                    trailing: CupertinoSwitch(
                      value: _isAudioOn,
                      onChanged: (bool value) {
                        setState(() {
                          _isAudioOn = value;
                        });
                      },
                      activeColor: CupertinoColors.activeGreen,
                    ),
                    tileColor: Colors.white,
                  ),
                  Divider(
                    height: 0,
                    indent: 17,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  ListTile(
                    title: const Text('Turn Off My Video'),
                    subtitleTextStyle:
                        const TextStyle(color: Color(0xFF6E6E6E)),
                    trailing: CupertinoSwitch(
                      value: _isVideoOn,
                      onChanged: (bool value) {
                        setState(() {
                          _isVideoOn = value;
                        });
                      },
                      activeColor: CupertinoColors.activeGreen,
                    ),
                    tileColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
