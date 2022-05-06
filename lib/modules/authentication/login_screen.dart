import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peace_of_cake/models/home.dart';
import 'package:peace_of_cake/modules/authentication/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _loginform = GlobalKey<FormState>();
  bool _secureText=true;
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
                  Image.asset('images/logo.jpg',width: 40,height: 40,),
                  SizedBox(height: 10,),
                  SizedBox(height: 120,),
                  Form(
                    key: _loginform,
                    child: Column(
                      children:<Widget> [
                        TextFormField(
                            controller: emailController,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                hintText: 'Enter Email',hintStyle: TextStyle(color: Colors.grey[400]),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: Icon(Icons.person_outline_rounded,color: Colors.teal,size: 20),
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
                                return "please enter your email";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 50.0,),
                        TextFormField(
                            controller: passwordController,
                            cursorColor: Colors.green,
                            obscureText: _secureText,
                            decoration: InputDecoration(
                                hintText: 'Enter Password',hintStyle: TextStyle(color: Colors.grey[400]),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(12.0),
                                suffixIcon: IconButton(

                                  onPressed: ()
                                  {
                                    setState(() {
                                      _secureText=!_secureText;
                                    });
                                  },
                                  icon: Tooltip(message: 'read your password',
                                      child: Icon(_secureText? Icons.visibility_off:Icons.visibility)),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "please enter your password";
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 25,),
                        GestureDetector(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CreateAccount()));
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Text('Forget Password?',style: TextStyle(
                                color: Colors.grey[400]
                            ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
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
                                if(_loginform.currentState!.validate())
                                {
                                  FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text
                                  ).then((value)
                                  async{
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('userID', value.user!.uid);
                                    //print("11111111111111111111111111111");
                                    //print(await FirebaseAuth.instance.currentUser!.getIdToken()) ;
                                    //print("11111111111111111111111111111");
                                    setState(()
                                    {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Home()));
                                    });
                                  }).catchError((e)
                                  {
                                    Fluttertoast.showToast(msg:e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
                                  });
                                }
                              },
                                  child: Text('Sign in >',style: TextStyle(color: Colors.white),))),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Do not have an account?',style: TextStyle(
                            color: Colors.grey
                        ),
                        ),
                        SizedBox(width: 4.0),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CreateAccount()));
                          },
                          child: Text('Sign up',style: TextStyle(
                              color: Colors.teal
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
