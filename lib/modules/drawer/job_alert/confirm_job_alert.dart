import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_of_cake/modules/drawer/job_alert/add_job_alert.dart';

class SetJobAlert extends StatefulWidget {


  @override
  _SetJobAlertState createState() => _SetJobAlertState();
}

class _SetJobAlertState extends State<SetJobAlert> {
  int _currentvalue = 2;
  late Map alerts = Map<String, dynamic>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getjobsAlert();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Tooltip(message: 'Add job alert',
          child: FloatingActionButton(
            onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddJobAlert())),
            child: Icon(Icons.add),
            backgroundColor:Theme.of(context).accentColor,
          ),
        ),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(onPressed: (){Navigator.pop(context);},
              icon: Tooltip(message: 'back',
                  child: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 18,))),
        ),
        body: alerts.length !=0? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(alerts['job_title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                  SizedBox(height: 10,),
                  Divider(indent: 40,
                    endIndent: 40,color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Row(children:<Widget> [
                          Expanded(child: Text('Location',style: TextStyle(fontWeight: FontWeight.bold))),
                          Text(alerts['job_location'],style: TextStyle(fontWeight: FontWeight.bold)),
                        ],),
                        SizedBox(height: 8,),
                        Row(children:<Widget> [
                          Expanded(child: Text('Alert frequency',style: TextStyle(fontWeight: FontWeight.bold))),
                          Text(alerts['alert_frequency'],style: TextStyle(fontWeight: FontWeight.bold)),
                        ],),
                        SizedBox(height: 8,),
                        Row(children:<Widget> [
                          Expanded(child: Text('Results',style: TextStyle(fontWeight: FontWeight.bold))),
                          Container(
                              height: 30,
                              width: 75,
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                                  color: Theme.of(context).accentColor
                              ),
                              child: TextButton(onPressed: (){},
                                  child: Text('Show',style: TextStyle(color: Colors.white),))),
                        ],),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) :Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Center(
              child: Text('Add Job Alert',style: TextStyle(fontSize: 16,color: Theme.of(context).accentColor),
              ),
            ),
          ],
        )
    );
  }
  // widget if user don't have job alert in database
  Widget createJobAlert()=>SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
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
          SizedBox(height: 8,),
          GestureDetector(
            onTap: (){},
            child: Row(children:<Widget> [
              Expanded(child: Text('Ex. Human Resources',style: TextStyle(color: Colors.grey),)),
              Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,)
            ],),
          ),
          Divider(),
          SizedBox(height: 8,),
          Text('Job location',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          Row(children:<Widget> [
            Expanded(child: Text('all cities',style: TextStyle(color: Colors.grey),)),
            Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,)
          ],),
          Divider(),
          SizedBox(height: 8,),
          Text('Job category',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          Row(children:<Widget> [
            Expanded(child: Text('select job category',style: TextStyle(color: Colors.grey),)),
            Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,)
          ],),
          Divider(),
          SizedBox(height: 8,),
          Text('Career Level',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          Row(children:<Widget> [
            Expanded(child: Text('select Carer level',style: TextStyle(color: Colors.grey),)),
            Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey,)
          ],),
          Divider(),
          SizedBox(height: 8,),
          Text('Alert frequency',style: TextStyle(fontWeight: FontWeight.bold),),
          Row(
            children: <Widget>[
              Radio(value: 1, groupValue: _currentvalue, onChanged: (int? val){
                setState(() {
                  //_currentvalue = val;
                });
              }),
              SizedBox(width: 10,),
              Text('Daily')
            ],
          ),
          Row(
            children: <Widget>[
              Radio(value: 2, groupValue: _currentvalue, onChanged: (int? value)
              {
                setState(() {
                  //_currentvalue = value;
                });
              }),
              SizedBox(width: 10,),
              Text('Weekly')
            ],
          ),
          Row(
            children: <Widget>[
              Radio(value: 3, groupValue: _currentvalue, onChanged: (int? value){
                setState(() {
                  //_currentvalue = value;
                });
              }),
              SizedBox(width: 10,),
              Text('Monthly')
            ],
          ),
          Row(
            children: <Widget>[
              Radio(value: 4,activeColor: Theme.of(context).accentColor, groupValue: _currentvalue, onChanged: (int? value){
                setState(() {
                  //_currentvalue = value;
                });
              }),
              SizedBox(width: 10,),
              Text('None')
            ],
          )

        ],
      ),
    ),
  );

// widget if user have job alert in database
  Widget savedJobAlert(alert)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(alert['job_title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
            SizedBox(height: 10,),
            Divider(indent: 40,
              endIndent: 40,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Row(children:<Widget> [
                    Expanded(child: Text('Location',style: TextStyle(fontWeight: FontWeight.bold))),
                    Text(alert['job_location'],style: TextStyle(fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 8,),
                  Row(children:<Widget> [
                    Expanded(child: Text('Alert frequency',style: TextStyle(fontWeight: FontWeight.bold))),
                    Text(alert['alert_frequency'],style: TextStyle(fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 8,),
                  Row(children:<Widget> [
                    Expanded(child: Text('Results',style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        height: 30,
                        width: 75,
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).accentColor
                        ),
                        child: TextButton(onPressed: (){},
                            child: Text('Show',style: TextStyle(color: Colors.white),))),
                  ],),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  getjobsAlert()
  {
    FirebaseFirestore.instance
        .collection('JobAlerts')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get().then((value)
    {
      alerts = value.data() as Map<String, dynamic>;
      setState(() {

      });
    });
  }
}