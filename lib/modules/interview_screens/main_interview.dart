import 'dart:core';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peace_of_cake/modules/interview_screens/confirm_image_screen.dart';
import 'package:peace_of_cake/modules/interview_screens/videocall_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Chat extends StatefulWidget {
  late QueryDocumentSnapshot list;

  Chat({required this.list});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late String id;
  late final receiverId = widget.list['company_id'];
  late String dateTime;
  List messages = [];
  late var message = TextEditingController();
  int messageBodyLength = 0;

  // for voice typing
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";

  // send image
  late File selectedimage;
  var picker = ImagePicker();
  var pickedFile;

  // for voice note
  final recorder = FlutterSoundRecorder();
  late AudioPlayer _audioPlayer;
  late String path;
  bool isRecorderReady = false;
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    getMessage();
    _speech = stt.SpeechToText();
    initRecorder();
    _isPlaying = false;
    _audioPlayer = AudioPlayer();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
        debugLogging: true
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            // _text = val.recognizedWords;
            // message.text = _text;
            // messageBodyLength = 1;
            if(val.hasConfidenceRating && val.confidence >0)
            {
              print('whyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
              _text = val.recognizedWords;
              message.text = _text;
              messageBodyLength = 1;
            }
          }),
        );
      }
    } else {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Row(
            children: <Widget>[
              CircleAvatar(
                  backgroundImage: widget.list['company_image'].length != 0
                      ? NetworkImage(widget.list['company_image'])
                      : NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQtYyNP9njaEeggRjQ5MjX2PrJy1OHkN_o-FA&usqp=CAU')),
              SizedBox(
                width: 12,
              ),
              Text(
                widget.list["company_name"],
                style: TextStyle(color: Colors.black, fontSize: 18),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => VideoCall())),
                        icon: Icon(Icons.call,
                            color: Theme.of(context).colorScheme.secondary)),
                    //SizedBox(width: 15),
                    IconButton(
                        onPressed: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => VideoCall())),
                        icon: Icon(Icons.videocam,
                            size: 26, color: Theme.of(context).colorScheme.secondary)),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: messages.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (messages[index]['sender_id'] == id)
                          return otherMessage(messages, index);
                        return yourMessage(messages, index);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: message,
                          style: TextStyle(decoration: TextDecoration.none),
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.attach_file_rounded),
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomsheet());
                              },
                            ),
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Type a message',
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).colorScheme.secondary)),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              messageBodyLength = value.length;
                            });
                          },
                        ),
                      ),
                      messageBodyLength > 0?
                      IconButton(
                          icon: Icon(Icons.near_me_rounded,
                              color: Theme.of(context).colorScheme.secondary),
                          onPressed: () =>
                              sendMessage(receiverId, message.text)):
                      Row(
                        children: [
                          FloatingActionButton(
                            onPressed: (){_listen();},
                            child: Icon(Icons.record_voice_over_sharp),
                            mini: true,
                            backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                          ),
                          IconButton(
                              onPressed: ()async
                              {
                                if(recorder.isRecording)
                                {
                                  await stop();
                                }
                                else
                                {
                                  await record();
                                }
                                setState(() {

                                });
                              },
                              icon:Icon(recorder.isRecording?Icons.stop: Icons.mic)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }

  //company message
  Widget yourMessage(messages, int index) => Padding(
    padding: const EdgeInsets.only(
        top: 8.0, bottom: 8.0, right: 50.0, left: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(messages[index]['body']),
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(12.0),
                  bottomStart: Radius.circular(12.0),
                  topEnd: Radius.circular(12.0),
                ))),
      ],
    ),
  );

  //my message
  Widget otherMessage(messages, int index) {
    if (messages[index]['type'] == 'audio') {
      return Padding(
        padding: EdgeInsets.only(
            top: 8,
            left: ((messages[index]['sender_id'] == id) ? 64 : 10),
            right: ((messages[index]['sender_id'] == id) ? 10 : 64)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: (messages[index]['sender_id'] == id)
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.white30,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(12.0),
                bottomStart: Radius.circular(12.0),
                topStart: Radius.circular(12.0),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(_isPlaying ? Icons.cancel : Icons.play_arrow),
                onPressed: () async {
                  Directory directory =
                  await getApplicationDocumentsDirectory();
                  String receivedFilePath =
                      directory.path + '/' + messages[index]['body'];
                  path = receivedFilePath;
                  _onPlayButtonPressed();
                },
              ),
              Text(
                'Audio',
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, right: 8.0, left: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: messages[index]['type'] == 'image'.toString()
                      ? Image.network(
                    messages[index]['body'],
                    width: 220,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                      : Text(
                    messages[index]['body'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: HexColor("87a5cb"),
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(12.0),
                      bottomStart: Radius.circular(12.0),
                      topStart: Radius.circular(12.0),
                    ))),
          ],
        ),
      );
    }
  }

  Widget bottomsheet() => Padding(
      padding: const EdgeInsets.only(bottom: 50, left: 8, right: 8),
      child: Container(
        height: 230,
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        bottomsheetdetails(Icons.insert_drive_file,
                            Colors.indigo, "Document", () {}),
                        SizedBox(width: 40),
                        bottomsheetdetails(
                            Icons.camera_alt, Colors.pink, "Camera", () {}),
                        SizedBox(width: 40),
                        bottomsheetdetails(Icons.insert_photo_outlined,
                            Colors.purple, "Gallery", () async {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              // if (pickedFile != null) {
                              //   selectedimage = File(pickedFile.path);
                              //   setState(() async {
                              //     final textDetector = GoogleMlKit.vision.faceDetector();
                              //     final inputImage = InputImage.fromFilePath(selectedimage);
                              //     RecognizedText recognizedText = await textDetector.processImage(selectedimage);
                              //     await textDetector.close();
                              //     String result = '';
                              //     for(TextBlock block in recognizedText.blocks)
                              //     {
                              //       for(TextLine line in block.lines)
                              //       {
                              //         result = result + line.text +"\n";
                              //       }
                              //       setState(() {
                              //
                              //       });
                              //     }
                              //     Navigator.pop(context);
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (ctx) => CameraViewPage(
                              //               path: selectedimage,
                              //               receiverId: receiverId,
                              //               ocr_text: result,
                              //             )));
                              //
                              //   });
                              // } else
                              //   print('no image selected!');

                          }),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        bottomsheetdetails(
                            Icons.person, Colors.blue, "Contact", () {}),
                        SizedBox(width: 40),
                        bottomsheetdetails(Icons.location_on_rounded,
                            Colors.green, "Location", () {}),
                        SizedBox(width: 40),
                        bottomsheetdetails(
                            Icons.headset, Colors.orange, "Audio", () {}),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ));

  Widget bottomsheetdetails(
      IconData icon, Color color, String name, Function()? tap) =>
      InkWell(
        onTap: tap,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                icon,
                size: 29,
                color: Colors.white,
              ),
              radius: 30,
              backgroundColor: color,
            ),
            Text(name)
          ],
        ),
      );

  sendMessage(receiverId, String text) async {
    message..text = '';
    await SharedPreferences.getInstance().then((value) {
      id = value.getString('userID')!;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .collection('Chats')
          .doc(receiverId)
          .collection('message')
          .add({
        'body': text,
        'date_time': DateTime.now().toString(),
        'sender_id': id,
        'received_id': receiverId,
        'type': 'text'
      })
          .then((value) {})
          .catchError((error) {});
      setState(() {
        messageBodyLength = 0;
      });

      FirebaseFirestore.instance
          .collection('Companies')
          .doc(receiverId)
          .collection('Chats')
          .doc(id)
          .collection('message')
          .add({
        'body': text,
        'date_time': DateTime.now().toString(),
        'sender_id': id,
        'received_id': receiverId,
        'type': 'text'
      })
          .then((value) {})
          .catchError((error) {});
    });
  }

  getMessage() async {
    await SharedPreferences.getInstance().then((value) {
      id = value.getString('userID')!;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .collection('Chats')
          .doc(receiverId)
          .collection('message')
          .orderBy('date_time')
          .snapshots()
          .listen((value) {
        messages = value.docs;
        setState(() {});
      });
    });
  }


  // function for voice note
  Future initRecorder() async
  {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted)
    {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    //  recorder.setSubscriptionDuration(
    //  const Duration(microseconds: 500)
    // );
  }

  Future record() async
  {
    if (!isRecorderReady) return;
    Directory directory = await getApplicationDocumentsDirectory();
    String filepath = directory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
    await recorder.startRecorder(toFile: filepath).then((value) => filepath = '');
    print('file path of record function is  : $filepath');
  }

  Future stop() async
  {
    if (!isRecorderReady) return;
    String stop_path = (await recorder.stopRecorder())!;
    print('11111111111');
    final audioFile = File(stop_path);
    path = stop_path;
    setState(() {

    });
    await _uploadToFirebase();
    print('Recorded audio of stop function is  : $audioFile');
    print('Recorded audio of stop function is  : $stop_path');

  }

  Future<void> _uploadToFirebase() async
  {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    try {
      await firebaseStorage
          .ref('upload-voice-firebase')
          .child(
          path.substring(path.lastIndexOf('/'), path.length))
          .putFile(File(path));

      sendAudioMsg(path.substring(
          path.lastIndexOf('/') + 1, path.length));
      //widget.onUploadComplete(); bdl deh el mafrood na7ooot el voice fe el cloud database
    } catch (error) {
      print('Error occured while uplaoding to Firebase ${error.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occured while uplaoding'),
        ),
      );
    }
  }

  sendAudioMsg(String audioMsg) async
  {
    if (audioMsg.isNotEmpty) {
      var ref = FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .collection('Chats')
          .doc(receiverId)
          .collection('message')
          .doc();
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(ref, {
          "sender_id": id,
          "received_id": receiverId,
          "date_time": DateTime.now().toString(),
          "body": audioMsg,
          "type": 'audio'
        });
      });
    } else {
      print("Hello");
    }
  }

  void _onPlayButtonPressed()
  {
    if (!_isPlaying) {
      _isPlaying = true;

      _audioPlayer.play(path, isLocal: true);
      _audioPlayer.onPlayerCompletion.listen((duration) {
        setState(() {
          _isPlaying = false;
        });
      });
    } else {
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    }
    // set state here
    setState(() {
      Icon(Icons.cancel );
    });
  }

  // the end

}
