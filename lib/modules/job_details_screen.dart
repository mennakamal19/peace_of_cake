import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_of_cake/models/home.dart';

class JobDetails extends StatefulWidget {
  final QueryDocumentSnapshot list;
  JobDetails({required this.list});
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  List<String> job_description_list = [];
  List<String> job_requirements_list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    job_description_list = List.from(widget.list['job_description']);
    job_requirements_list = List.from(widget.list['job_requirements']);
    print(job_description_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 18,), onPressed: () { Navigator.pop(context); },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget> [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 75.0,
                  height: 68.0,
                  child: Image.network(widget.list['company_image'],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10,),
                Text(widget.list['job_title'],style: TextStyle(
                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 19
                ),),
                SizedBox(height: 6),
                Text(widget.list['company_name'],style: TextStyle(
                    color: Theme.of(context).accentColor,fontSize: 16
                ),),
                SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_rounded,size: 14,),
                    SizedBox(width: 3,),
                    Text(widget.list['area_location'] +', '+ widget.list['city_location'],style: TextStyle(
                        color: Colors.grey,fontSize: 14
                    ),),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time_rounded,size: 12,),
                    SizedBox(width: 3,),
                    Text(widget.list['job_type'],style: TextStyle(
                        color: Colors.grey,fontSize: 14
                    ),),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16.0)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:
                      TextButton(onPressed: ()
                      {

                      },
                          child: Icon(Icons.bookmark_border_rounded,color: Theme.of(context).accentColor,)
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:
                        TextButton(onPressed: (){setState(() {
                          confirmApplying();
                        });},
                          child: Text('Apply',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(indent: 80,endIndent: 80,color: Colors.grey,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget> [
                              Text('Experience Needed: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              Flexible(child: Text(widget.list['experience_needed'],style: TextStyle(fontSize: 13))),
                            ],),
                        ),
                        elevation: 2,
                        shadowColor: Colors.grey[50],
                      ),
                      SizedBox(height: 5,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children:<Widget> [
                            Text('Career Level: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.list['carrer_level'],style: TextStyle(fontSize: 13)),
                          ],),
                        ),
                        elevation: 2,
                        shadowColor: Colors.grey[50],
                      ),
                      SizedBox(height: 5,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget> [
                              Text('Education Level: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              Flexible(child: Text(widget.list['education_level'],style: TextStyle(fontSize: 13))),
                            ],),
                        ),
                        elevation: 2,
                        shadowColor: Colors.grey[50],
                      ),
                      SizedBox(height: 5,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children:<Widget> [
                            Text('Salary: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.list['salary'],style: TextStyle(fontSize: 13)),
                          ],),
                        ),
                        elevation: 2,
                        shadowColor: Colors.grey[50],
                      ),
                      SizedBox(height: 5,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children:<Widget> [
                            Text('Job Categories: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.list['job_type'],style: TextStyle(fontSize: 13)),
                          ],),
                        ),
                        elevation: 6,
                        shadowColor: Colors.grey[50],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                Divider(indent: 80,endIndent: 80,color: Colors.grey,),
                SizedBox(height: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Job Description',style: TextStyle(
                        fontSize: 15,fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                      itemCount: job_description_list.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>jobdata(job_description_list[index]),
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    SizedBox(height: 15,),
                    Text('Job requerments',style: TextStyle(
                        fontSize: 15,fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                      itemCount: job_requirements_list.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>jobdata(job_requirements_list[index]),
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
  confirmApplying()
  {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget> [
                Image.network('https://www.iconninja.com/files/989/602/415/yes-circle-mark-check-correct-tick-success-icon.png'),
                Text('Thank you\nyour application will sent to company with your data',textAlign:TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 18,color: Theme.of(context).accentColor,
                ),),
                SizedBox(height: 15,),
                Text('wishing to you all luck.',textAlign:TextAlign.center,style: TextStyle(
                    fontSize: 14,color: Colors.grey
                ),),
                Spacer(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Theme.of(context).accentColor,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Home()));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Applied successfully, Good Luck with it.'),
                          ));
                    },
                    child: Text('Confirm',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Theme.of(context).accentColor,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          )
      ),
    );
  }
  Widget jobdata(String job_description_list)
  {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 7),
          Flexible(
            child: Text(job_description_list
            ),
          ),
        ],
      ),
    );
  }
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int _currentvalue = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.6,
        child: Container(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget> [
                Text('Job Type'),
                Row(
                  children: <Widget>[
                    Radio(value: 1, groupValue: _currentvalue, onChanged: (int? val){
                      setState(() {
                        //_currentvalue = val;
                      });
                    }),
                    SizedBox(width: 10,),
                    Text('Full Time')
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
                    Text('Part Time')
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
                    Text('Work from home')
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 4, groupValue: _currentvalue, onChanged: (int? value){
                      setState(() {
                        //_currentvalue = value;
                      });
                    }),
                    SizedBox(width: 10,),
                    Text('Freelance')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
