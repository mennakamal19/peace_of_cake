import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationDetails extends StatefulWidget {
  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  String app1 = '11 Sep 2021 at 8Am';
  String app2 = '12 Sep 2021 at 8Am';
  String app3 = '13 Sep 2021 at 10Am';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 18,), onPressed: () =>Navigator.pop(context),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Text('Schedule\nThe Interview',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
            Center(child: Image.asset('images/notification.PNG',width: 100,height: 100,)),
            SizedBox(height: 12,),
            Text('This letter is to inform you that we have received your application for the job for'+'jobtitle'+'post in our company and hence we would like to appoint you\n\nIf you still interested in our company, please be in the scheduled time for interview and while doing so, please don\'t forget to prepare your original documents along with experience letter, recommendation letters and references.'),
            SizedBox(height: 16,),
            Text('Thank you.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child:
                TextButton(onPressed: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                              return Container(
                                  height: 350,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset('images/notifi.PNG',width: 80,height: 90,),
                                        Text(app1,style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 12),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Theme.of(context).colorScheme.secondary,
                                          ),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: TextButton(
                                            onPressed: (){
                                              setState(() {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('scheduled successfully, Good Luck with it.'),
                                                    )
                                                );
                                              });
                                            },
                                            child: Text('Accept',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Colors.grey[200],
                                          ),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: TextButton(
                                            onPressed: (){
                                              setState(() {
                                                if(app1 ==app3)
                                                {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('we will scheduled another Appointment, and notify you. Thank you'),
                                                      )
                                                  );
                                                }
                                                app1 = app2;
                                                app2 = app3;
                                              });
                                            },
                                            child: Text('Change',
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              );
                            });
                      });
                },
                  child: Text('Select Interview Appointment',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget actionbutton() =>CupertinoActionSheet(
    title: Image.asset('images/notifi.PNG'),
    message: Text(app1,style: TextStyle(fontSize: 17,color: Colors.black),),
    actions: [
      CupertinoActionSheetAction(onPressed: () {
        setState(() {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('scheduled successfully, Good Luck with it.'),
              )
          );
        });
      },
        child: Text('Accept'),isDefaultAction: true,),
      CupertinoActionSheetAction(onPressed: () {
        setState(() {
          app1 = app2;
        });
      },
        child: Text('Change'),isDefaultAction: true,),
    ],
    cancelButton: CupertinoActionSheetAction(onPressed: () {
      Navigator.pop(context);
    },
      child: Text('Cancel '),

    ),
  );
}
