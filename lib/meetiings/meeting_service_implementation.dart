import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom/authentication/auth_service_implementation.dart';
import 'package:zoom/meetiings/meeting_service.dart';

class MeetingServiceImplementation implements MeetingService {
  final AuthServiceImplementation _authServiceImplementation =
      AuthServiceImplementation();

  final JitsiMeet jitsiMeet = JitsiMeet();

  @override
  void createMeeting(String roomName, bool isAudioOn, bool isVideoOn) async {
    try {
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": !isAudioOn,
          "startWithVideoMuted": !isVideoOn,
          "enableNoAudioDetection": true,
        },
        featureFlags: {
          "welcomepage.enabled": false,
          "unsaferoomwarning.enabled": false,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: _authServiceImplementation.user.displayName,
          email: _authServiceImplementation.user.email,
          avatar: _authServiceImplementation.user.photoURL,
        ),
      );

      await jitsiMeet.join(options);
    } catch (e) {
      print("Error starting meeting: $e");
      throw e;
    }
  }
}
