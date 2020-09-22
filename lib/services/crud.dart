import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class crudMethods{
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser()!= null){
      return true;
    }else{
      return false;
    }
  }

  Future<void>addData(customerData) async{
    if(isLoggedIn()){
      Firestore.instance.collection('testcrud').add(customerData).catchError((e){
        print(e);
      });
    }
    else{
      print('You need to be logged in');
    }

  }



  getData() async {return await Firestore.instance.collection('testcrud').getDocuments();}
  }

