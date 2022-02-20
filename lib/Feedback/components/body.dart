import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Services/auth_services.dart';
import '../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
  }

  dynamic myUsername;
  dynamic myPhone;

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth = FirebaseAuth.instance;

    final TextEditingController feedbackController = new TextEditingController();
    final TextEditingController placesController = new TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Container(
      child: Container(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                // height: 10,
              ),
              controller: feedbackController,
              decoration: InputDecoration(
                  hintText: "Enter Feedback"
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(
                // height: 10,
              ),
              controller: placesController,
              decoration: InputDecoration(
                  hintText: "Enter Places Idea"
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                FlatButton(
                  minWidth: size.width * 0.4,
                  height: 50,
                  color: kPrimaryColor,
                  onPressed: () async {
                    AuthService().sendFeedback(
                      myUsername,
                      myPhone,
                      feedbackController.text,
                      placesController.text,
                    )
                        .then((value){
                      if (value == "Done") {
                        Navigator.pop(context);
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.1,),
                FlatButton(
                  minWidth: size.width * 0.4,
                  height: 50,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: kPrimaryColor,)
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myUsername = ds['Username'];
        myPhone = ds['Phone'];
        print(myUsername);
        print(myPhone);
      }).catchError((e) {
        print(e);
      });
  }
}
