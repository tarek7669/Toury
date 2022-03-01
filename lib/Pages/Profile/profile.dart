import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Models/user_model.dart';
import 'package:project_toury/Pages/Profile/components/body.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  dynamic myUsername;
  dynamic myPhone;
  dynamic myCountry;
  dynamic myCountryCode;

  UserModel user = new UserModel();
  bool is_fetched = false;

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null
        ? Center(child: Text("SIGN IN TO CONTINUE"))
        :profileBody();
  }
}
