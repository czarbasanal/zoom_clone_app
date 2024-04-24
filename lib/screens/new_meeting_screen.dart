import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMeetingScreen extends StatefulWidget {
  const NewMeetingScreen({super.key});

  @override
  _NewMeetingScreenState createState() => _NewMeetingScreenState();
}

class _NewMeetingScreenState extends State<NewMeetingScreen> {
  bool _isVideoOn = false;
  bool _isPMI = false;

  @override
  Widget build(BuildContext context) {
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
                Divider(
                  height: 0,
                  indent: 17,
                  color: Colors.grey.withOpacity(0.2),
                ),
                ListTile(
                  title: const Text('Use personal meeting ID (PMI)'),
                  subtitle: const Text('286 541 3061'),
                  subtitleTextStyle: const TextStyle(color: Color(0xFF6E6E6E)),
                  trailing: CupertinoSwitch(
                    value: _isPMI,
                    onChanged: (bool value) {
                      setState(() {
                        _isPMI = value;
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
                onPressed: () {},
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
