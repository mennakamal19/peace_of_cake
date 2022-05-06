import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peace_of_cake/modules/drawer/job_alert/confirm_job_alert.dart';

class AddJobAlert extends StatefulWidget {


  @override
  _AddJobAlertState createState() => _AddJobAlertState();
}

class _AddJobAlertState extends State<AddJobAlert> {
  late String jobTitle, jobLocation, jobCategory, carerLevel, Alert ;
  late String searchKey;
  static const job_titles =
  [
    "Flutter Developer",
    "Call center",
    "PHP Developer",
    "UI / UX Designer"
  ];
  static const job_category =
  [
    "IT/Software Development",
    "Business and Management",
    "Human Resources",
    "Engineering",
    "Media and Design",
    "Project Management",
    "Languages",
    "Healthcare and Medical",
    "Law",
    "Customer Service and Support"
  ];
  static const job_location =
  [
    "All",
    "Nasr City",
    "Heliopolis",
    "Maadi",
    "New Cairo",
    "Dokki",
    "6th of October",
    "Sheraton",
    "Smouha",
  ];
  static const career_level =
  [
    "All",
    "Student",
    "Entry Level",
    "Experienced",
    "Manager"
  ];
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(onPressed: ()
        {
          Navigator.pop(context);
        },
            icon: Tooltip(
                message: 'back',
                child: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 18,))),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(child: InkWell( onTap: ()=> saveJobAlertInData(jobTitle,jobLocation,jobCategory,carerLevel,Alert),
              child: Text('Add',style: TextStyle(color: Theme.of(context).accentColor,fontSize: 16),
              ),
            )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_active_outlined,color: Theme.of(context).accentColor,size: 35,
                  ),
                  SizedBox(height: 8,),
                  Text('Create a Job Alert',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 15,),
                  Text('Don\'t miss out on job opportunities! Receive\njob alerts for opportunities that suit your needs via email',textAlign: TextAlign.center,),
                ],
              ),
              SizedBox(height: 15,),
              Text('Job title',style: TextStyle(fontWeight: FontWeight.bold),),
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return job_titles.where((word) => word
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (word){
                  print(word);
                  setState(() {
                    jobTitle = word.toString();
                  });
                },
                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      hintText: 'Ex. Human Research',
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                      suffixIcon: Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,),
                      border: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12,),
              Text('Job location',style: TextStyle(fontWeight: FontWeight.bold),),
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return job_location.where((word) => word
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (word){
                  print(word);
                  setState(() {
                    jobLocation = word.toString();
                  });
                },
                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      hintText: 'all cities',
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                      suffixIcon: Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,),
                      border: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12,),
              Text('Job category',style: TextStyle(fontWeight: FontWeight.bold),),
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return job_category.where((word) => word
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (word){
                  print(word);
                  setState(() {
                    jobCategory = word.toString();
                  });
                },
                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      hintText: 'select job category',
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                      suffixIcon: Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,),
                      border: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12,),
              Text('Career Level',style: TextStyle(fontWeight: FontWeight.bold),),
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return career_level.where((word) => word
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (word){
                  print(word);
                  setState(() {
                    carerLevel = word.toString();
                  });
                },
                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      hintText: 'select Carer level',
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                      suffixIcon: Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,),
                      border: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              Text('Alert frequency',style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                children: <Widget>[
                  Radio(value: 1,
                      groupValue: _value,
                      onChanged: ( int? value){
                        setState(() {
                          _value = value!;
                          Alert = 'Daily';
                        });
                      }),
                  SizedBox(width: 10,),
                  Text('Daily')
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(value: 2,
                      groupValue: _value,
                      onChanged: (int? value)
                      {
                        setState(() {
                          _value = value!;
                          Alert = 'Weekly';
                        });
                      }),
                  SizedBox(width: 10,),
                  Text('Weekly')
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(value: 3,
                      groupValue: _value,
                      onChanged: (int? value){
                        setState(() {
                          _value = value!;
                          Alert = 'Monthly';
                        });
                      }),
                  SizedBox(width: 10,),
                  Text('Monthly')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  saveJobAlertInData(String jobTitle, String jobLocation, String jobCategory, String carerLevel, String alert)
  {
    CollectionReference jobs = FirebaseFirestore.instance.collection('JobAlerts');
    jobs..doc(FirebaseAuth.instance.currentUser!.uid.toString()).set(
        {
          'job_title':jobTitle,
          'job_location':jobLocation,
          'id':FirebaseAuth.instance.currentUser!.uid.toString(),
          'career_level':carerLevel,
          'job_category':jobCategory,
          'alert_frequency':alert,
        }).then((value)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SetJobAlert()));

    }).catchError((e)
    {
      Fluttertoast.showToast(msg:e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
    });
  }
}
