import 'package:flutter/material.dart';
import 'package:peace_of_cake/modules/notification_screens/nofification_details_screen.dart';
class Notifications extends StatefulWidget {

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 18,), onPressed: () =>Navigator.pop(context),),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Notifications',style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,idx) => NotificationItem(),
                    separatorBuilder: (context,idx) => Divider(),
                    itemCount: 2
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget NotificationItem()=> InkWell(
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>NotificationDetails())),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0)
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: 50.0,
          height: 50.0,
          child: Image.network('https://dneegypt.nyc3.digitaloceanspaces.com/2020/06/640.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Text('Orange',style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 16
              ),),
              Text('you got a response about your application for fluttre developer click to see all deatails.. Good Luck',style: TextStyle(
                  color: Colors.grey,fontSize: 14
              ),),
            ],),
        ),
        SizedBox(width: 2,),
        Text('23 min',style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,fontSize: 12
        ),),
      ],),
  );
}
