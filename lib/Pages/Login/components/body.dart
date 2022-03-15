import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:project_toury/Components/UserSharedPreferences.dart';
import 'package:project_toury/Components/bottomNavigationBar.dart';
import 'package:project_toury/Services/Navigations.dart';
import 'package:project_toury/Services/auth_services.dart';
import 'package:project_toury/Services/database.dart';
import 'package:project_toury/constants.dart';
import 'package:project_toury/Pages/Login/components/background.dart';
import 'package:provider/provider.dart';
import 'package:project_toury/Models/user_model.dart';

class Body extends StatefulWidget{
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController usernameController = new TextEditingController();

  String phoneNumber = '';
  String username = '';
  String isoCode = '';
  String codeCountry = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   'Toury',
            //   style: TextStyle(
            //     fontSize: 40,
            //     color: kPrimaryColor,
            //   )
            // ),
            Container(
              child: Image.asset("assets/Logo/1024.png"),
              width: size.width * 0.5,
              height: size.height * 0.5,
            ),
            SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    'Please Fill These Info',
                    style: TextStyle(
                      fontSize: 15,
                      color: kPrimaryColor,
                    )
                ),
              ],
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    validator: (val) => val!.isEmpty ? 'Enter A Username' : null,
                    controller: usernameController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        hintText: "Username",
                        prefixIcon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        )
                    ),
                    onChanged: (user) {
                      print(user);
                      username = user;
                    },
                  ),
                  SizedBox(height: 20),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                    dropDownArrowColor: kPrimaryColor,
                    onChanged: (phone) {
                      setState(() {
                        controller: phone.completeNumber;
                        phoneNumber = phone.completeNumber;
                        isoCode = phone.countryISOCode;
                        codeCountry = phone.countryCode;
                      });
                      print(phoneNumber);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 16,
            ),
            FlatButton(
              minWidth: size.width * 0.7,
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(usernameController.text, phoneNumber, isoCode, codeCountry)));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Fill All Fields')));
                }
              },
              child: Text("SEND OTP"),
              color: kPrimaryColor,
              textColor: Colors.white,
            ),
          ]
        ),
      )
    );
  }
}


enum AuthStatus { unknown, notLoggedIn, loggedIn }
class OTPScreen extends StatefulWidget {
  final String username;
  final String phone;
  final String isoCode;
  final String codeCountry;
  OTPScreen(this.username, this.phone, this.isoCode, this.codeCountry);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with ChangeNotifier{
  String _verificationCode = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel userInfo = new UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);


    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('Verifying Phone Number...Please Wait'),
            SizedBox(height: 20),
            Text("Enter The Code Manually If It is Taking Too Long."),
            SizedBox(height: 15),
            PinEntryTextField(
              fields: 6,
              showFieldAsBox: true,
              onSubmit: (String pin) async{
                try{
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: _verificationCode, smsCode: pin);

                  await _auth.signInWithCredential(phoneAuthCredential);
                  await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                      .updateUserData(widget.username, widget.phone, widget.isoCode, widget.codeCountry);

                  //SHARED PREFERENCES
                  await UserSharedPreferences.setUsername(widget.username);
                  await UserSharedPreferences.setPhoneNumber(widget.phone);

                  //USER MODEL
                  userInfo.setUID(FirebaseAuth.instance.currentUser!.uid);
                  userInfo.setUsername(widget.username);
                  userInfo.setPhone(widget.phone);

                  // await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  //     .updateUserData(widget.username, widget.phone, widget.isoCode, widget.codeCountry).then((value) async{
                  //   await _fetchPaidTours();
                  // }).then((value) async{
                  //       await DatabaseService().updatePaidTours(WantToPayTour);
                  // });
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationBar()), (route) => false);
                } catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cannot Complete Login...Please Try Again')));
                }
                //SAVE DATA TO DATABASE
              },
            ),
          ],
        ),
      )
    );
  }
  // _verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: widget.phone,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //                 .updateUserData(widget.username, widget.phone, widget.isoCode, widget.codeCountry);
  //             // await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //             //   .updateUserData(widget.username, widget.phone, widget.isoCode, widget.codeCountry).then((value) async{
  //             //   await _fetchPaidTours();
  //             // }).then((value) async{
  //             //   await DatabaseService().updatePaidTours(WantToPayTour);
  //             // });
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => NavigationBar()),
  //                     (route) => false);
  //             print(FirebaseAuth.instance.currentUser!.uid);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //         Navigator.pop(context);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Cannot Complete Login...Please Try Again')));
  //       },
  //       codeSent: (String verficationID, int? resendToken) {
  //         setState(() {
  //           _verificationCode = verficationID;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         setState(() {
  //           _verificationCode = verificationID;
  //         });
  //       },
  //       timeout: Duration(seconds: 60));
  // }

  _verifyPhone() async {

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .updateUserData(widget.username, widget.phone, widget.isoCode, widget.codeCountry);
              // await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              //   .updateUserData(widget.username, widget.phone, widget.isoCode, widget.codeCountry).then((value) async{
              //   await _fetchPaidTours();
              // }).then((value) async{
              //   await DatabaseService().updatePaidTours(WantToPayTour);
              // });

              notifyListeners();

              //SHARED PREFERENCES
              await UserSharedPreferences.setUsername(widget.username);
              await UserSharedPreferences.setPhoneNumber(widget.phone);

              //USER MODEL
              userInfo.setUID(FirebaseAuth.instance.currentUser!.uid);
              userInfo.setUsername(widget.username);
              userInfo.setPhone(widget.phone);

              changeScreenAndRemove(context, NavigationBar());
              print(FirebaseAuth.instance.currentUser!.uid);
            }

          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cannot Complete Login...Please Try Again')));
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Code Sent')));
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
          // const Duration(seconds: 20);
        },
        timeout: const Duration(seconds: 60));

    // return retVal;
  }
}



