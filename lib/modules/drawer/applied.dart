import 'package:flutter/material.dart';

class Application extends StatefulWidget {

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(icon: Tooltip(message: 'back',
            child: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 18,)), onPressed: () =>Navigator.pop(context),),
        title: Text('Applications',style: TextStyle(
            color: Colors.black,fontSize: 18
        ),),
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context,idx) => appliedItem(),
                separatorBuilder: (context,idx) => Divider(),
                itemCount: 1
            ),
          ),
        ),
      ),
    );
  }
  Widget appliedItem() => InkWell(
    onTap: ()
    {
      //Navigator.push(context, MaterialPageRoute(builder: (ctx)=>JobDetails()));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
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
                    child: Image.network('https://dneegypt.nyc3.digitaloceanspaces.com/2020/06/640.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // CircleAvatar(backgroundImage: NetworkImage('https://arborus.org/wp-content/uploads/2021/03/orange-logo.png',),),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget> [
                        Text('Flutter developer',style: TextStyle(
                            color: Theme.of(context).accentColor,fontWeight: FontWeight.bold,fontSize: 16
                        ),),
                        Text('Orange',style: TextStyle(
                            color: Colors.black,fontSize: 16
                        ),),
                        Text('Nasr city - cairo ',style: TextStyle(
                            color: Colors.grey,fontSize: 14
                        ),),
                        Text('Full-time',style: TextStyle(
                            color: Colors.grey,fontSize: 14
                        ),),
                        SizedBox(height: 2,)
                      ],),
                  ),
                  Text('28 days',style: TextStyle(
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
                        border:Border.all(color: Theme.of(context).accentColor
                        )
                    ),
                    child: TextButton(onPressed: (){},
                        child: Text('Applied',style: TextStyle(color: Colors.black),))),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
