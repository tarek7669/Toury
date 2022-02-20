import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  var uid;

  DatabaseService({this.uid});

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //Collection Reference
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  final CollectionReference feedbackCollection =
  FirebaseFirestore.instance.collection('feedback');

  final CollectionReference paidToursCollection =
  FirebaseFirestore.instance.collection('paidTours');

  Future updatePaidTours(List <String> WantToPayTour) async{
    bool exist = false;
    try {
      await FirebaseFirestore.instance.collection('paidTours').doc(uid).get().then((doc) {
        exist = doc.exists;
      });
      debugPrint(exist.toString());
      if(exist){
        await paidToursCollection
            .doc(uid)
            .update({
          "paidTours": FieldValue.arrayUnion(WantToPayTour),
        });
      } else {
       await paidToursCollection.doc(uid).set({
          'paidTours': WantToPayTour,
        });
      }
      return exist;
    } catch (e) {
      // If any error
      debugPrint(exist.toString());
      return false;
    }
  }

  Future updateUserData(String username, String phone, String isoCode, String codeCountry) async{
    return await userCollection.doc(uid).set({
      'Username': username,
      'Phone': phone,
      'ISOCode': isoCode,
      'CountryCode': codeCountry,
    });
  }

  // Future updateUserTours(String username, String phone, String isoCode, String codeCountry, List<String> WantToPayTour) async{
  //   return await userCollection.doc(uid).update({
  //     'Username': username,
  //     'Phone': phone,
  //     'ISOCode': isoCode,
  //     'CountryCode': codeCountry,
  //     'paidTours': FieldValue.arrayUnion(WantToPayTour)
  //   });
  // }

  Future updateFeedback(String username, String phone, String feedback, String place) async{
    return await feedbackCollection.doc(uid).set({
      'Username': username,
      'Phone': phone,
      'Feedback': feedback,
      'NewPlaces': place,
    });
  }

}