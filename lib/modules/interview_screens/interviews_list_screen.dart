import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peace_of_cake/modules/interview_screens/main_interview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterviewsList extends StatefulWidget {

  @override
  _InterviewsListState createState() => _InterviewsListState();
}

class _InterviewsListState extends State<InterviewsList> {
  late String user_id;
  List company_data =[];
  late String company_id;
  @override
  void initState() {
    super.initState();
    getMyInterviewsList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.secondary,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,), onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Interviews',style: TextStyle(color: Colors.white,fontSize: 25),),
          ),
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
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,idx) => interviewItem(company_data[idx]),
                    separatorBuilder: (context,idx) => Divider(),
                    itemCount: company_data.length
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget interviewItem (company_data) => InkWell(
    onTap: ()
    {
      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Chat(list: company_data,)));

    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(backgroundImage:company_data['company_image'].length != 0? NetworkImage(company_data['company_image']):
        NetworkImage('https://t3.ftcdn.net/jpg/03/37/59/20/360_F_337592002_YkOFpDt6Bm2dPBu1xv2ijVNI18CfKdoj.jpg')
        ),
        SizedBox(width: 12,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Text(company_data['job_title'],style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 16
              ),),
              Text(company_data['company_name'],style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 16
              ),),
              Text('you got a response ',style: TextStyle(
                  color: Colors.grey,fontSize: 14
              ),),
            ],),
        ),
        Text('23 min',style: TextStyle(
            color: Colors.grey,fontSize: 12
        ),),
      ],),
  );

  getMyInterviewsList()
  async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await SharedPreferences.getInstance().then((value)
    {
      user_id = value.getString('userID')!;
      users.doc(user_id).collection('Chats').snapshots().listen((value)
      {
        company_data = value.docs;
        setState(()
        {
        });

      });
    }).catchError((e)
    {
      print('-------> error ${e.toString()}');
    });
  }
}
