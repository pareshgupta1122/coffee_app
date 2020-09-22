import 'package:brew_coffee_app/homepage.dart';
import 'package:brew_coffee_app/resetpassword.dart';
import 'package:brew_coffee_app/signpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
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
                Text('Login',style: TextStyle(color: Colors.white,fontSize: 40.0)),
                SizedBox(height: 20.0,),
                Text('To Brew Coffee',style: TextStyle(color: Colors.white,fontSize: 20.0)),
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
                     key: _formKey,
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
                     SizedBox(height: 24.0),
                     TextFormField(
                       decoration: InputDecoration(hintText: 'Password',
                         prefixIcon:Icon(Icons.lock),
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
                         suffixIcon: IconButton(
                           icon: Icon(
                             _passwordObscured?Icons.visibility_off:Icons.visibility,

                           ),
                           onPressed: (){
                             setState(() {
                               _passwordObscured=!_passwordObscured;
                             });
                           },
                         ),
                       ),
                       validator: (value){
                         if(value.isEmpty){
                           return 'Invalid Password';
                         }
                         return null;
                       },
                       onSaved: (value)=>_password=value,
                       obscureText: _passwordObscured,
                     ),
                         SizedBox(height: 16.0),
                         InkWell(
                           child: Center(
                             child: Text('Forgot Password?',
                                 style:TextStyle(
                                     color:Colors.grey,
                                     fontWeight: FontWeight.bold
                                 )),
                           ),
                           onTap: () {
                             Navigator.of(context)
                                 .pushReplacement(MaterialPageRoute(builder: (context)=>ResetPage()));
                           },
                         ),
                         SizedBox(height: 20),
                         Container(
                           height: 50,
                             width: 400,

                           child: RaisedButton(
color: Colors.black,

                               child: Text('Login',style: TextStyle(
                                 fontSize: 15.0,
color: Colors.white,
                               ),),
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(40.0)
                               ),

                               elevation: 10,
                               onPressed: () {
                                 if (_formKey.currentState.validate()) {
                                   _formKey.currentState.save();
                                   FirebaseAuth.instance
                                       .signInWithEmailAndPassword(
                                       email: _email, password: _password)
                                       .then((AuthResult) async {
                                     FirebaseUser user =
                                     await FirebaseAuth.instance.currentUser();
                                     if (user.isEmailVerified) {
                                       Navigator.of(context)
                                           .pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                                     }
                                   }).catchError((e) {
    switch(e.code){
    case "ERROR_WRONG_PASSWORD":
    Alert(
    context: context,
    type: AlertType.error,
    title: "Wrong Password",
    desc:'Please enter a valid password',
    buttons: [
    DialogButton(
    child: Text(
    "Ok",
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    onPressed: () => Navigator.pop(context),
    width: 120,
    )
    ],
    ).show();
    break;
    case "ERROR_USER_NOT_FOUND":
    Alert(
    context: context,
    type: AlertType.error,
    title: "User Not Found",
    desc: "Please try again",
    buttons: [
    DialogButton(
    child: Text(
    "Ok",
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    onPressed: () => Navigator.pop(context),
    width: 120,
    )
    ],
    ).show();
    break;
                                   }});
                                 }
                               }),
                         ),
                         SizedBox(height: 15.0),

                         Column(

                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[

                             Text('Don\'t have an account?'),
                             SizedBox(
                                 width:20.0
                             ),
                             RaisedButton(

                               color: Colors.black,
                                 child: Center(
                                   child: Text('SignUp',
                                       style:TextStyle(
                                           color:Colors.white,
                                           fontWeight: FontWeight.bold
                                       ) ),
                                 ),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(40.0)
                                 ),
                                 onPressed: () {
                                   Navigator.of(context)
                                       .pushReplacement(MaterialPageRoute(builder: (context)=>SigninPage()));
                                 }),
                           ],
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