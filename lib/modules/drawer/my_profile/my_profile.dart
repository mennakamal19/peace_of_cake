import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peace_of_cake/modules/drawer/my_profile/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Map userdata = Map<String, dynamic>();
  late String id;
  bool _switchValue=true;
  var phoneNumberController = TextEditingController();
  String _ifcv = "";

  @override
  void initState()
  {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 18,), onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body:userdata.length !=0?
        SingleChildScrollView
          (
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150.0),bottomRight: Radius.circular(60.0),
                        )
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children:<Widget> [
                        SizedBox(width: 35,),
                        CircleAvatar(
                            radius: 32.0,
                            backgroundImage: //userdata['image'].length != null? NetworkImage(userdata['image']):
                            NetworkImage('https://www.seekpng.com/png/detail/1010-10108361_person-icon-circle.pnghttps://www.seekpng.com/png/detail/1010-10108361_person-icon-circle.png')
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          userdata['user_name'],
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        _ifcv.isNotEmpty?Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white
                          ),
                          child: TextButton(onPressed: ()
                          async {
                            String downloadURL = await firebase_storage.FirebaseStorage.instance
                                .ref('playground/some-file.pdf')
                                .getDownloadURL();
                            print(downloadURL);
                            //PDFDocument doc = await PDFDocument.fromURL(downloadURL);
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDF(doc)));  //Notice the Push Route once this is done.
                          },
                              child: Text(
                                'View your CV',style: TextStyle(color: Colors.black),
                              )
                          ),
                        ):Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white
                          ),
                          child: TextButton(onPressed: ()
                          async {
                           // final path = await FlutterDocumentPicker.openDocument();
                           // print(path);
                           // File file = File(path);
                           // firebase_storage.UploadTask task = await uploadFile(file);
                            String downloadURL = await firebase_storage.FirebaseStorage.instance
                                .ref('playground/some-file.pdf')
                                .getDownloadURL();
                            print(downloadURL);
                           // PDFDocument doc = await PDFDocument.fromURL(downloadURL);
                            setState(() {
                              _ifcv = "true";
                              Fluttertoast.showToast(msg:'Your CV is Uploading', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
                            });
                            setState(() {

                            });
                          },
                              child:Text(
                                'Upload your CV',style: TextStyle(color: Colors.black),
                              )
                          ),
                        ),
                        SizedBox(height: 16,),
                        userdata['phone_number'].length !=0?Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white
                          ),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget> [
                              Text('Phone Number: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              Flexible(child: Text(userdata['phone_number'],style: TextStyle(fontSize: 13))),
                            ],),
                        ):TextField(
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
                        SizedBox(height: 16,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white
                          ),
                          child: userdata['basic_comm_way'].length !=0?Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children:<Widget> [
                                Text('Basic communication way: ',style: TextStyle(fontWeight: FontWeight.bold)),
                                Flexible(child: Text(userdata['basic_comm_way'],style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold))),
                              ],),
                          ):
                          TextButton(onPressed: ()
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
                        SizedBox(height: 16,),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(child: Text('OCR',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  Transform.scale(
                                    transformHitTests: false,
                                    scale: .7,
                                    child: CupertinoSwitch(
                                      activeColor: Theme.of(context).accentColor,
                                      value: _switchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _switchValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        SizedBox(height: 16,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white
                          ),
                          child: TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>EditProfile()));
                          },
                              child: Text(
                                'Edit profile',style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator())
    );
  }
  getUserData() async
  {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await SharedPreferences.getInstance().then((value)
    {
      id = value.getString('userID')!;
      users.doc(id).get().then((value)
      {
        userdata = value.data() as Map<String, dynamic>;
        setState(() {

        });
      }).catchError((e)
      {
        print('-------> error ${e.toString()}');
      });
    });
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

    users.doc(id).update({
      field_name: value.toString(),
    }).then((value)
    {
      setState(() {
        getUserData();
      });
    }).catchError((error)
    {
      print(error.toString());
    });
  }
}
