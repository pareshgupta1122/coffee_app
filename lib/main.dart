import 'dart:async';

import 'package:brew_coffee_app/homepage.dart';
import 'package:brew_coffee_app/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getflutter/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen() ,
    );

  }}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer( Duration(seconds: 5),(){
      FirebaseAuth.instance.currentUser().then((user)
      {
        if(user==null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
        }
        else{
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
        }
      });

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
            fit:StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors:[ Colors.white,
                 Colors.white,
                    Colors.black,
                  ],

                )),

              ),
              Column(
                mainAxisAlignment:MainAxisAlignment.start,
                children:<Widget>[
                  Expanded(

                      flex:1,
                      child:Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children:<Widget>[





                            Image(

                              image:AssetImage('android/images/coffee.png'),
                              height: 250.0,
                            ),

                          ]
                      )
                  ),
                  Expanded(
                    flex:1,
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: <Widget>[
                        GFLoader(
                          loaderColorThree: Colors.white,
                          type:GFLoaderType.ios,
                        ),
                        Padding(
                          padding:EdgeInsets.only(top:20.0),
                        ),
                        Center(
                          child: Text(" WELCOME TO BREW COFFEE ",style:GoogleFonts.cabin(
                              color:Colors.white,fontSize:23.0,fontWeight:FontWeight.bold),
                          ),
                        )
                      ],),
                  )

                ],
              )
            ] )

    );



  }
}