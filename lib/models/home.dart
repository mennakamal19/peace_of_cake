import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_of_cake/modules/authentication/login_screen.dart';
import 'package:peace_of_cake/modules/drawer/applied.dart';
import 'package:peace_of_cake/modules/drawer/job_alert/confirm_job_alert.dart';
import 'package:peace_of_cake/modules/drawer/my_profile/my_profile.dart';
import 'package:peace_of_cake/modules/drawer/my_saved_items.dart';
import 'package:peace_of_cake/modules/drawer/report_aproblem.dart';
import 'package:peace_of_cake/modules/drawer/setting.dart';
import 'package:peace_of_cake/modules/interview_screens/interviews_list_screen.dart';
import 'package:peace_of_cake/modules/job_details_screen.dart';
import 'package:peace_of_cake/modules/notification_screens/notification_list_screen.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List latestJob = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobsData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        //leading: IconButton(icon: Icon(Icons.list,color: Colors.black,), onPressed: () => Scaffold.of(context).openDrawer()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(icon: Icon(Icons.notifications_active,color: Theme.of(context).colorScheme.secondary),
              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications())),
            ),
          )
        ],),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(
                bottomRight:Radius.circular(70.0),
                bottomLeft:Radius.circular(0.0),),
                color: Colors.teal,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage('images/backgroundhome.jpg'),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomToggleBtn()),
                      SizedBox(height: 15,),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child:
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)
                        ),
                      ),
                      child: Row(children:<Widget> [
                        Icon(Icons.search),
                        SizedBox(width: 12,),
                        Text('Search by job title or skills',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        )
                      ],),
                    ),
                  //  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SearchDeatils())),
                  ),
                  SizedBox(height: 25,),
                  Text('Categories',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 12,),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children:
                    [
                      category_name('IT/Software Development'),
                      category_name('Business and Management'),
                      category_name('Human Resources'),
                      category_name('Engineering'),
                      category_name('Media and Design'),
                      category_name('Project Management'),
                      category_name('Languages'),
                      category_name('Healthcare and Medical'),
                      category_name('Law'),
                      category_name('Customer Service and Support'),
                      category_name('Travel and Tourism'),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Divider(),
                  Text('Latest jobs',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(height: 10,),
                  ListView.separated(
                    itemCount: latestJob.length,
                    padding: EdgeInsets.all(0.0),
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,idx) => jobItem(latestJob[idx],idx),
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,idx) => Divider(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  getJobsData()
  {
    CollectionReference jobs = FirebaseFirestore.instance.collection('Jobs');
    jobs.snapshots().listen((value)
    {
      latestJob = value.docs;
      setState(()
      {
      });
    });
  }

  Widget jobItem(latestJob, int idx) => InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx)=>JobDetails(list: latestJob))),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0)
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget> [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 65.0,
                  height: 60.0,
                  child: latestJob['company_image'].length != 0? Image.network(latestJob['company_image']):
                  Image.network('https://t3.ftcdn.net/jpg/03/37/59/20/360_F_337592002_YkOFpDt6Bm2dPBu1xv2ijVNI18CfKdoj.jpg',fit: BoxFit.cover,),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget> [
                      Text(latestJob['job_title'],style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 16
                      ),),
                      Text(latestJob['company_name'],style: TextStyle(
                          color: Colors.black,fontSize: 16
                      ),),
                      Text(latestJob['area_location']+","+latestJob['city_location'],style: TextStyle(
                          color: Colors.grey,fontSize: 14
                      ),),
                      Text(latestJob['job_type'],style: TextStyle(
                          color: Colors.grey,fontSize: 14
                      ),),
                      SizedBox(height: 2,)
                    ],),
                ),
                Text(latestJob['date'],style: TextStyle(
                    color: Colors.grey
                ),)
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 35,
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                      color: Theme.of(context).colorScheme.secondary
                  ),
                  child: TextButton(onPressed: (){},
                      child: Text('Apply',style: TextStyle(color: Colors.white),))),
            )
          ],
        ),
      ),
    ),
  );
  // widget for the categories
  Widget category_name(String name) => Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child:   TextButton(
      onPressed: () {  },
      child: Text(name,
        style: TextStyle(
          fontFamily: '',
          color: Colors.black,
          fontSize: 10.0,
        ),
      ),
    ),
  );
}

// all drawer details
class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            DrawerHeader(decoration:BoxDecoration(color: Theme.of(context).colorScheme.secondary),
              child: Column(children:<Widget> [
                CircleAvatar(backgroundImage: NetworkImage('https://www.seekpng.com/png/detail/1010-10108361_person-icon-circle.png',),
                  radius: 35,
                ),
                SizedBox(height: 12),
                Text('Username',style: TextStyle(color: Colors.white,fontSize: 16),),
                SizedBox(height: 8),
                InkWell(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Profile())),
                    child: Text('View profile',style: TextStyle(color: Colors.white)))
              ],
              ),
            ),
            ListTile(title: Text('Set Jop Alert'),
              leading: Icon(Icons.add_alert),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SetJobAlert())),
            ),
            ListTile(title: Text('Application'),
              leading: Icon(Icons.note_rounded),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Application())),
            ),

            ListTile(title: Text('Saved'),
              leading: Icon(Icons.favorite),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Saved())),
            ),
            Divider(),
            ListTile(title: Text('Report a problem'),
              leading: Icon(Icons.note_add_outlined),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReportAProblem())),
            ),
            ListTile(title: Text('Setting'
            ),
              leading: Icon(Icons.settings),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Setting())),
            ),
            ListTile(title: Text('Log out'
            ),
              leading: Icon(Icons.logout),
              onTap: () => FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Login()))),

            )],
        ),
      ),
    );
  }
}


// custom toggle button
class CustomToggleBtn extends StatefulWidget {

  @override
  _CustomToggleBtnState createState() => _CustomToggleBtnState();
}
const double width = 200.0;
const double height = 25.0;
const double jobsearchAlign = -1;
const double interviewAlign = 1;
const Color selectedColor = Colors.black;
const Color normalColor = Colors.black54;

class _CustomToggleBtnState extends State<CustomToggleBtn> {

  late double xAlign;
  late Color jobColor;
  late Color interviewColor;

  @override
  void initState() {
    super.initState();
    xAlign = jobsearchAlign;
    jobColor = selectedColor;
    interviewColor = normalColor;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: Duration(milliseconds: 300),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = jobsearchAlign;
                jobColor = selectedColor;
                interviewColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Job Search',
                  style: TextStyle(
                      color: jobColor,
                      fontWeight: FontWeight.bold,fontSize: 12
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>InterviewsList()));

              });
            },
            child: Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Interviews',
                  style: TextStyle(
                      color: interviewColor,
                      fontWeight: FontWeight.bold,fontSize: 12
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

