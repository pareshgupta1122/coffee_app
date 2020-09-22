import 'package:brew_coffee_app/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'services/user.dart';
class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}
class _ResetPageState extends State<ResetPage> {
  String _email;

  static final _formKey = GlobalKey<FormState>();
  bool _passwordObscured;
  @override
  void initState(){
    _passwordObscured=true;
  }
  Widget build(BuildContext context) {
    final pHeight=MediaQuery.of(context).size.height;
    final pWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: pWidth*double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.white70,

                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Padding(padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Reset',style: TextStyle(color: Colors.white,fontSize: 40.0)),
                  SizedBox(height: 20.0,),
                  Text('Your Password',style: TextStyle(color: Colors.white,fontSize: 20.0)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),

                  child: SingleChildScrollView(
                    child: Form(
                      child:Column(
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          TextFormField(

                            decoration: InputDecoration(hintText: 'Email',
                              prefixIcon:Icon(Icons.email),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),

                                borderSide: BorderSide(width: 2.0,color: Colors.black),

                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                  )
                              ),

                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(!EmailValidator.validate(value)){
                                return'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value)=>_email=value,
                          ),

                          SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: 400,

                            child: RaisedButton(
                                color: Colors.black,

                                child: Text('Sign Up',style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0)
                                ),

                                elevation: 10,
                                onPressed: ()  async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    FirebaseAuth mAuth = FirebaseAuth.instance;
                                    await mAuth.sendPasswordResetEmail(email: _email);
                                  }
                                }),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}