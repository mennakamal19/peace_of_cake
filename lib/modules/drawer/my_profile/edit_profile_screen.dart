import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peace_of_cake/modules/drawer/my_profile/my_profile.dart';

class EditProfile extends StatefulWidget {


  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).accentColor,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 18,), onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )
              ),
              child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children:<Widget> [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white
                        ),
                        child: TextButton(onPressed: ()
                        async {
                        //  final path = await FlutterDocumentPicker.openDocument();
                          //print(path);
                         // File file = File(path);
                         // firebase_storage.UploadTask task = await uploadFile(file);
                          String downloadURL = await firebase_storage.FirebaseStorage.instance
                              .ref('playground/some-file.pdf')
                              .getDownloadURL();
                          print(downloadURL);
                        //  PDFDocument doc = await PDFDocument.fromURL(downloadURL);
                          setState(() {
                            Fluttertoast.showToast(msg:'Your CV is Uploading', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
                          });
                        },
                            child: Text(
                              'upload new CV',style: TextStyle(color: Colors.black),
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: phoneNumberController,
                        cursorColor:Theme.of(context).accentColor,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Add phone number',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                        onSubmitted: (val)
                        {
                          userCompleteData('phone_number',val);
                        },
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white
                        ),
                        child:TextButton(onPressed: ()
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)), //this right here
                                  child: Container(
                                    height: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset("images/question.PNG",width: 70,height: 80,),
                                          Text('Hold an your first interview will depend on the way you choose',textAlign: TextAlign.center,),
                                          SizedBox(height: 8,),
                                          SizedBox(
                                            width: 280.0,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                userCompleteData('basic_comm_way','Chat');
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text(
                                                "Chat",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  side:BorderSide(width: 1.0, color: Theme.of(context).accentColor)
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 280.0,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                userCompleteData('basic_comm_way','Voice Call');
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text(
                                                "Voice Call",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  side:BorderSide(width: 1.0, color: Theme.of(context).accentColor)
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 280.0,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                userCompleteData('basic_comm_way','Video Call');
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text(
                                                "Video Call",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  side:BorderSide(width: 1.0, color: Theme.of(context).accentColor)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                            child: Text(
                              'Choose communication way',style: TextStyle(color: Colors.black),
                            )),
                      ),
                      Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:
                        TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Profile()));},
                          child: Text('Update',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<firebase_storage.UploadTask> uploadFile(File file) async {

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/some-file.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    userCompleteData('c.v',Future.value(uploadTask).toString());
    return Future.value(uploadTask);
  }
  userCompleteData(String field_name, String value)
  {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    users.doc(FirebaseAuth.instance.currentUser!.uid.toString()).update({
      field_name: value.toString(),
    }).then((value)
    {
      setState(() {
      });
    }).catchError((error)
    {
      print(error.toString());
    });
  }
}
