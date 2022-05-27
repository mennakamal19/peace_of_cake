import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:peace_of_cake/modules/interview_screens/video_agora_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({Key? key}) : super(key: key);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {

  late int _remoteUid = 0;
  late RtcEngine _engine;


  @override
  void initState() {
    super.initState();
    initForAgora();
  }
  @override
  void dispose() {
    super.dispose();
    _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 100,
              child: Center(
                child: _renderLocalPreview(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingActionButton(onPressed: ()
              {
                Navigator.of(context).pop(true);
              },
                child: Icon(Icons.call_end_rounded,color: Colors.white),
                backgroundColor: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> initForAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(AgoraManager.appId);
    await _engine.enableVideo();
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print('$uid successfully joined channel: $channel ');
      },
      userJoined: (int uid, int elapsed) {
        print('remote user $uid joined channel');
        setState(() {
          _remoteUid = uid; // volunteer id bdl remote
        });
      },
      userOffline: (int uid, UserOfflineReason reason) {
        print('remote user $uid left channel');
        setState(() {
          _remoteUid = 0;
          Navigator.of(context).pop(true);
        });
      },
    ));
    // enable video

    await _engine.joinChannel(AgoraManager.token, AgoraManager.channelName, null, 0);
  }


// current user video
  Widget _renderLocalPreview() {
    print('where the user ');
    return RtcLocalView.SurfaceView();
  }

// remote user video
  Widget _remoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid,channelId: AgoraManager.channelName);// volnteer id
    } else {
      return Stack(
        children: [
          Image(
            image: NetworkImage('https://ic.encrypted-tbn0.gstatcom/images?q=tbn:ANd9GcR2W8hAHLsSrqWBsAba_fgFEveSWgcIMQ9-7g&usqp=CAU'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Text('Calling...',style: TextStyle(color: Colors.white,fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
  }
}
