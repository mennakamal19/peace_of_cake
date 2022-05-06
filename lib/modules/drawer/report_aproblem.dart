import 'package:flutter/material.dart';

class ReportAProblem extends StatefulWidget {


  @override
  _ReportAProblemState createState() => _ReportAProblemState();
}

class _ReportAProblemState extends State<ReportAProblem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 18,), onPressed: ()=> Navigator.pop(context),),
          actions: [
            Center(child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(onTap: ()
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('we will concern with your problem, and send feedback as soon as we can, Thank you.'),
                    ));
              },
                  child: Text('Post',style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold,fontSize: 16),)),
            ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget> [
                Center(child: Image.asset('images/save.PNG',width: 80,height: 80,)),
                SizedBox(height: 10,),
                Center(child: Text('Report a problem', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,)),
                SizedBox(height: 8,),
                Text('We are ready to solve any problem you have or any hard situation you faced,\nJust contact with us.',style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),
                SizedBox(height: 8,),
                Divider(),
                SizedBox(height: 8,),
                Row(
                  children:<Widget> [
                    CircleAvatar(backgroundImage: NetworkImage('https://www.seekpng.com/png/detail/1010-10108361_person-icon-circle.png',),
                      radius: 25,
                    ),
                    SizedBox(width: 12,),
                    Text('User Name', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),

                  ],
                ),
                SizedBox(height: 8,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'What is the problem ...',
                    border: UnderlineInputBorder(),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}