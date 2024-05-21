import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/authentication/auth_service_implementation.dart';
import 'package:zoom/meetiings/meeting_service_implementation.dart';
import 'package:zoom/riverpod/providers.dart';

class NewMeetingScreen extends StatefulHookConsumerWidget {
  const NewMeetingScreen({super.key});

  @override
  _NewMeetingScreenState createState() => _NewMeetingScreenState();
}

class _NewMeetingScreenState extends ConsumerState<NewMeetingScreen> {
  bool isPMI = false;
  String pmi = '';

  final MeetingServiceImplementation _meetingServiceImplementation =
      MeetingServiceImplementation();
  final AuthServiceImplementation _authServiceImplementation =
      AuthServiceImplementation();

  @override
  void initState() {
    super.initState();
    _retrievePMIFromFirestore();
  }

  void _retrievePMIFromFirestore() async {
    String userId = _authServiceImplementation.user.uid;
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('UserCollection')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        setState(() {
          pmi = snapshot.get('pmi') ?? '';
        });
      } else {
        print('No PMI found for user');
      }
    } catch (e) {
      print("Error retrieving PMI: $e");
      // Handle error if necessary
    }
  }

  void createNewMeeting() async {
    var random = Random();
    String roomName;

    if (isPMI) {
      roomName = pmi;
    } else {
      roomName = (random.nextInt(10000000) + 10000000).toString();
    }

    bool isVideoOn = ref.read(videoOnProvider);
    bool isAudioOn = ref.read(audioOnProvider);

    _meetingServiceImplementation.createMeeting(roomName, isAudioOn, isVideoOn);
  }

  @override
  Widget build(BuildContext context) {
    final isVideoOn = ref.watch(videoOnProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.15),
        title: const Text('Start a meeting',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        leading: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('Cancel',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1072ED))),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        leadingWidth: 85,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
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
                  title: const Text('Video on'),
                  trailing: CupertinoSwitch(
                    value: isVideoOn,
                    onChanged: (bool value) {
                      ref.read(videoOnProvider.notifier).state = value;
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
                  title: const Text('Use personal meeting ID (PMI)'),
                  subtitle: Text(pmi),
                  subtitleTextStyle: const TextStyle(color: Color(0xFF6E6E6E)),
                  trailing: CupertinoSwitch(
                    value: isPMI,
                    onChanged: (bool value) {
                      setState(() {
                        isPMI = value;
                      });
                    },
                    activeColor: CupertinoColors.activeGreen,
                  ),
                  tileColor: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextButton(
                onPressed: () {
                  createNewMeeting();
                },
                style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 0),
                    backgroundColor: const Color(0XFF1072ED),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(14)),
                child: const Text(
                  'Start a meeting',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
