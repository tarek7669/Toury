import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:project_toury/Components/bottomNavigationBar.dart';
import 'package:project_toury/Models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'Navigations.dart';
import 'database.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService with ChangeNotifier{
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  UserModel? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    UserModel().setUID(user.uid);
    UserModel().setUsername(user.displayName);
    UserModel().setPhone(user.phoneNumber);

    return UserModel();
  }


  Stream<UserModel?>? get user{
    try{
      return _auth.authStateChanges().map(_userFromFirebase);
    }catch(e){
      print ('Error while getting user');
    }
  }


  // GET UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser)!.uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    if (_auth.currentUser == null) {
      return "Null";
    }
    return await _auth.currentUser;
  }

  // sign In with email and Password
  Future<String> signInWithEmailAndPassword({
    required String email, required String password}) async {
    String result = 'first commit';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      result = "Welcome";
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        result = 'Wrong password provided for that user.';
      }
    }
    return result;
  }

  Future<String> LoginWithPhoneNumber(auth.PhoneAuthCredential phoneAuthCredential) async{
    String result = '';
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      // await DatabaseService(uid: authCredential.user!.uid).updatePhone(phoneAuthCredential.toString());

      if(authCredential.user != null){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> NavigationBar()));
        result = "Success";
      }

    } on auth.FirebaseAuthException catch (e) {
      result = "Error";
    }
    return result;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password, String username,
      String phoneNumber, String codeCountry, String isoCode,String country) async {
    String error;
    try{
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // await DatabaseService(uid: credential.user!.uid).updateUserData(username, phoneNumber, codeCountry, isoCode);

      return credential.user!.uid;
    }catch(e){
      error = 'Error in create new user function';
      print (error);
      return error;
    }
  }


  //VERIFY PHONE NUMBER


//   UserModel? _userFromFirebase(auth.User? user) {
//     if (user == null) {
//       return null;
//     }
//     UserModel(user.uid, user.phoneNumber);
//
//
//
//     return UserModel(user.uid, user.phoneNumber);
//   }
//
//
//   Stream<UserModel?>? get userCurrentModel{
//     try{
//       return _auth.authStateChanges().map(_userFromFirebase);
//     }catch(e){
//       print ('Error while getting user');
//     }
//   }
//
// //   static const LOGGED_IN = "loggedIn";
// //   late auth.User _user;
// //   Status _status = Status.Uninitialized;
// //
// //   // Firestore _firestore = Firestore.instance;
// //   UserServices _userServices = UserServices();
// //   late UserModel _userModel;
// //   TextEditingController phoneNo = new TextEditingController();
// //   String smsOTP = '';
// //   String verificationId = '';
// //   String errorMessage = '';
// //   bool loggedIn = false;
// //   bool loading = false;
// //
// // //  getter
// //   UserModel get userModel => _userModel;
// //
// //   Status get status => _status;
// //
// //   auth.User get user => _user;
// //
// //   // AuthService.initialize() {
// //   //   readPrefs();
// //   // }
// //
// //   Future<void> readPrefs()async{
// //     await Future.delayed(Duration(seconds: 3)).then((v)async {
// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //       loggedIn = prefs.getBool(LOGGED_IN) ?? false;
// //
// //       if(loggedIn){
// //         _user = await _auth.currentUser!;
// //         _userModel = await _userServices.getUserById(_user.uid);
// //         _status = Status.Authenticated;
// //         notifyListeners();
// //         return;
// //       }
// //
// //       _status = Status.Unauthenticated;
// //       notifyListeners();
// //
// //     });
// //   }
// //
// //   _verifyPhone(BuildContext context, String username, String phone, String isoCode, String codeCountry) async {
// //     await auth.FirebaseAuth.instance.verifyPhoneNumber(
// //         phoneNumber: phone,
// //         verificationCompleted: (auth.PhoneAuthCredential credential) async {
// //           await auth.FirebaseAuth.instance
// //               .signInWithCredential(credential)
// //               .then((value) async {
// //             if (value.user != null) {
// //               await DatabaseService(uid: auth.FirebaseAuth.instance.currentUser!.uid)
// //                   .updateUserData(username, phone, isoCode, codeCountry);
// //               // await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
// //               //   .updateUserData(widget.username, widget.phone, widget.isoCode, widget.codeCountry).then((value) async{
// //               //   await _fetchPaidTours();
// //               // }).then((value) async{
// //               //   await DatabaseService().updatePaidTours(WantToPayTour);
// //               // });
// //
// //               notifyListeners();
// //               changeScreenAndRemove(context, NavigationBar());
// //               print(auth.FirebaseAuth.instance.currentUser!.uid);
// //             }
// //           });
// //         },
// //         verificationFailed: (auth.FirebaseAuthException e) {
// //           print(e.message);
// //           Navigator.pop(context);
// //           ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('Cannot Complete Login...Please Try Again')));
// //         },
// //         codeSent: (String verficationID, int? resendToken) {
// //           // setState(() {
// //           //   _verificationCode = verficationID;
// //           // });
// //
// //           ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('Code Sent')));
// //         },
// //         codeAutoRetrievalTimeout: (String verificationID) {
// //           // setState(() {
// //           //   _verificationCode = verificationID;
// //           // });
// //           // const Duration(seconds: 20);
// //         },
// //         timeout: const Duration(seconds: 60));
// //   }
// //
// //   void _createUser({required String id, required String number}){
// //     _userServices.createUser({
// //       "id": id,
// //       "number": number,
// //     });
// //   }
// //
// //   signIn(BuildContext context) async {
// //     try {
// //       final auth.AuthCredential credential = auth.PhoneAuthProvider.credential(
// //         verificationId: verificationId,
// //         smsCode: smsOTP,
// //       );
// //       final auth.UserCredential user = await _auth.signInWithCredential(credential);
// //       final auth.User currentUser = await _auth.currentUser!;
// //       assert(user.user!.uid == currentUser.uid);
// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //       prefs.setBool(LOGGED_IN, true);
// //       loggedIn =  true;
// //       if (user != null) {
// //         _userModel = await _userServices.getUserById(user.user!.uid);
// //         if(_userModel == null){
// //           _createUser(id: user.user!.uid, number: user.user!.phoneNumber.toString());
// //         }
// //
// //         loading = false;
// //         Navigator.of(context).pop();
// //         changeScreenReplacement(context, NavigationBar());
// //       }
// //       loading = false;
// //
// //       Navigator.of(context).pop();
// //       changeScreenReplacement(context, NavigationBar());
// //       notifyListeners();
// //
// //     } catch (e) {
// //       print("${e.toString()}");
// //     }
// //
// //   }
//
  //sign out
  Future<void> signout() async {

    try{
      return await _auth.signOut();
    } catch(e) {
      print ('Error in sign out function');
    }
  }

  //reset password
  // Future<String> resetPassword({required String email}) async {
  //   try{
  //     await _auth.sendPasswordResetEmail(
  //       email: email,
  //     );
  //     return "Email sent";
  //   } catch (e) {
  //     return "Error occured in reset password";
  //   }
  // }

  // Google Auth
  // Future<auth.UserCredential> signInWithGoogle(/*String phone, String country*/) async {
  //   final GoogleSignInAccount? googleUser =
  //   await GoogleSignIn(scopes: <String>["email"]).signIn();
  //
  //   final GoogleSignInAuthentication googleAuth =
  //   await googleUser!.authentication;
  //
  //   final auth.OAuthCredential credential = auth.GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //
  //   return await auth.FirebaseAuth.instance.signInWithCredential(credential);
  // }

  //Facebook Auth

  // Future<auth.UserCredential> signInWithFacebook() async {
  //
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final auth.OAuthCredential facebookAuthCredential = auth.FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return auth.FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //
  // }


  //Send Feedback
  Future<String> sendFeedback(String username, String phone, String feedback, String place) async{
    String result = '';
    try{
      await DatabaseService(uid: _auth.currentUser!.uid).updateFeedback(
          username, phone, feedback, place);
      result = 'Done';
    } catch(e) {
      result = 'Error Occured';
    }
    return result;
  }

}