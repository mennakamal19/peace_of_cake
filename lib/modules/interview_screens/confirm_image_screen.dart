import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';


class CameraViewPage extends StatefulWidget {
  String receiverId,ocr_text;
  late File path;
  CameraViewPage({required this.path,required this.receiverId,required this.ocr_text});
  @override
  _CameraViewPageState createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraViewPage> {
  late final receiverId = widget.receiverId;
  late final ocr_text = widget.ocr_text;
  late String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                widget.path,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        maxLines: 6,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add Caption....",
                          prefixIcon: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.white,
                            size: 27,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: IconButton(icon:Icon(Icons.check, color: Colors.white,
                        size: 27,),
                        onPressed: () { uploadImage();},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  uploadImage()
  {
    print(widget.path.path);
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chats/${Uri.file(widget.path.toString()).pathSegments.last}')
        .putFile(widget.path).then((image) {
      image.ref.getDownloadURL().then((image)
      async {
        print(image);
        await SharedPreferences.getInstance().then((value) {
          print(image);
          id = value.getString('userID')!;
          FirebaseFirestore.instance
              .collection('Users')
              .doc(id)
              .collection('Chats')
              .doc(receiverId)
              .collection('message')
              .add({
            'body': image,
            'date_time': DateTime.now().toString(),
            'sender_id': id,
            'received_id':receiverId,
            'type':'image'
          }).then((value) {}).catchError((error)
          {
            print(error.toString());
          });

        });

        await SharedPreferences.getInstance().then((value) {
          print(image);
          id = value.getString('userID')!;
          FirebaseFirestore.instance
              .collection('Users')
              .doc(id)
              .collection('Chats')
              .doc(receiverId)
              .collection('message')
              .add({
            'body': ocr_text,
            'date_time': DateTime.now().toString(),
            'sender_id': id,
            'received_id':receiverId,
            'type':'text'
          }).then((value)
          {
            Navigator.pop(context);
          }).catchError((error)
          {
            print(error.toString());
          });

        });
      });
    });
  }
}
