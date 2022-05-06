import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peace_of_cake/models/home.dart';
import 'package:peace_of_cake/modules/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late String image;
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var canfirmpasswordController = TextEditingController();
  final _create_acc_form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children:<Widget> [
            Image(
              image: AssetImage('images/login_screen.png'),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                children:<Widget> [
                  SizedBox(height: 40,),
                  Image.asset('images/logo.jpg',width: 40,height: 50,),
                  SizedBox(height: 10,),
                  SizedBox(height: 60,),
                  Form(
                    key: _create_acc_form,
                    child: Column(
                      children:<Widget> [
                        TextFormField(
                            controller: usernameController,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                hintText: 'Enter User name',hintStyle: TextStyle(color: Colors.grey[400]),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: Icon(Icons.person_outline_rounded,color: Colors.teal,size: 20,),
                                contentPadding: EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "please enter your username";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                            controller: emailController,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                hintText: 'Enter Email',hintStyle: TextStyle(color: Colors.grey[400]),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: Icon(Icons.mail,color: Colors.teal,size: 20,),
                                contentPadding: EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "please enter your Email";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                            controller: passwordController,
                            cursorColor: Colors.green,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Enter Password',hintStyle: TextStyle(color: Colors.grey[400]),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(12.0),
                                suffixIcon: Icon(Icons.visibility,color: Colors.teal,size: 20,),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            validator: (value){
                              if(value!.length<8)
                              {
                                return "please enter Strong password contain 8 characters";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                            controller: canfirmpasswordController,
                            cursorColor: Colors.green,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Confirm Password',hintStyle: TextStyle(color: Colors.grey[400]),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            keyboardType: TextInputType.visiblePassword, /////////??
                            validator: (value){
                              if(passwordController.text != value)
                              {
                                return "please enter matched password";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 25,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.green,
                                    ]
                                ),
                              ),
                              child: TextButton(onPressed: ()
                              {
                                if(_create_acc_form.currentState!.validate())
                                {
                                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ).then((value)
                                  async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('userID', value.user!.uid);
                                    setState(()
                                    async {
                                      var token = await FirebaseAuth.instance.currentUser!.getIdToken();
                                      addUsers(usernameController.text,emailController.text,value.user!.uid,token);
                                    });
                                  }).catchError((e)
                                  {
                                    Fluttertoast.showToast(msg:e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
                                  });
                                }
                              },
                                  child: Text('Sign Up >',style: TextStyle(color: Colors.white),))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(
                              color: Colors.green,
                            )
                        ),
                        SizedBox(width: 5,),
                        Text("OR",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        Expanded(
                            child: Divider(
                              color: Colors.greenAccent,
                            )
                        ),
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget> [
                      ShaderMask(
                        shaderCallback: (bounds) => RadialGradient( colors: [Colors.blue, Colors.greenAccent],
                          tileMode: TileMode.mirror,
                          radius: 0.5,
                        ).createShader(bounds),
                        child: IconButton(onPressed: (){},
                            icon: Icon(Icons.email,color: Colors.white,size: 30,)),
                      ),
                      ShaderMask(
                        shaderCallback: (bounds) => RadialGradient( colors: [Colors.blue, Colors.greenAccent],
                          tileMode: TileMode.mirror,
                          radius: 0.5,
                        ).createShader(bounds),
                        child: IconButton(onPressed: (){},
                            icon: Icon(Icons.facebook,color: Colors.white,size: 30,)),
                      ),
                    ],),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Do already have an account?',style: TextStyle(
                          color: Colors.grey
                      ),
                      ),
                      SizedBox(width: 4.0),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Login()));
                        },
                        child: Text('Login',style: TextStyle(
                            color: Colors.teal
                        ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void addUsers(username, email,String uid, token)
  {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users..doc(uid).set(
        {
          'user_name':username,
          'email':email,
          'id':uid,
          'image':image = '',
          'c.v':'',
          'phone_number':'',
          'basic_comm_way':'',
          'token':token,
        }).then((value)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Home()));

    }).catchError((e)
    {
      Fluttertoast.showToast(msg:e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
    });
  }
}
