import 'package:brew_coffee_app/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'services/Crud.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Coffee Time'),


          actions: <Widget>[
            RaisedButton(
child: Text('Add Order'),
              color: Colors.white,
              onPressed: (){
  addDialog(context);
              },
            )

          ],

        ),
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(

            children: <Widget>[
              StreamBuilder(
                  stream: Firestore.instance.collection('testcrud').snapshots(),
                  builder: _CoffeeList

              ),
              Container(
                width: 400,
                alignment: Alignment.bottomCenter,
                child: RaisedButton(

                  child:Text('Sign out'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.black,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
                  },),
              ),
              SizedBox(height: 10.0),


            ],
          ),
        )
    );
  }

  Widget _CoffeeList(BuildContext context,
      AsyncSnapshot<QuerySnapshot>snapshot) {
    if (snapshot.hasData) {
      return Expanded(
        child: SizedBox(
          height:200.0,
          child: ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              DocumentSnapshot testcrud = snapshot.data.documents[i];
              return ListTile(
                title: Text(testcrud.data['CustomerName']??''),
                subtitle: Text(testcrud.data['thing']??''),

              );
            },
          ),
        ),
      );
    }
    else {
      return Text('Loading ....Please wait');
    }
  }



  QuerySnapshot testcrud;
  String CustomerName;
  String thing;
  crudMethods crudObj = new crudMethods();



  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add details', style: TextStyle(fontSize: 15.0)),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter Your Name'),
                  onChanged: (value) {
                    this.CustomerName = value;
                  },
                ),
                SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter what type of Coffee you want'),
                  onChanged: (value) {
                    this.thing = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  Map <String, dynamic> customerData = {
                    'CustomerName': this.CustomerName,
                    'thing': this.thing
                  };
                  crudObj.addData(customerData).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },

              )
            ],
          );
        });
  }



  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Done', style: TextStyle(fontSize: 15.0)),
              content: Text('NOW, Please wait'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Alright'),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]
          );
        });

  }
}





