// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:project_toury/Components/bottomNavigationBar.dart';
// import 'package:project_toury/Services/auth_services.dart';
// import 'package:project_toury/Services/database.dart';
// import 'package:provider/provider.dart';
// import '../../../constants.dart';
//
// class GoogleFacebookSignup extends StatefulWidget {
//   const GoogleFacebookSignup({Key? key}) : super(key: key);
//
//   @override
//   _GoogleFacebookSignupState createState() => _GoogleFacebookSignupState();
// }
//
// class _GoogleFacebookSignupState extends State<GoogleFacebookSignup> {
//   GlobalKey<FormState> _formKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//
//     final TextEditingController countryController = new TextEditingController();
//     final TextEditingController usernameController = new TextEditingController();
//
//     String username = '';
//     String phoneNumber = '';
//     String country = '';
//     String code_country = '';
//     String isoCode = '';
//
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//     final authService = Provider.of<AuthService>(context);
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       color: kPrimaryLightColor,
//       child: AlertDialog(
//         title: Text('Additional Credentials'),
//         backgroundColor: kPrimaryLightColor,
//         content: new Container(
//           width: size.width,
//           height: size.height * 0.43,
//           decoration: new BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: const Color(0xFFFFFF),
//             borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//           ),
//           child: Column(
//             children: [
//               Text('Please Fill The Required Fields'),
//               SizedBox(height: 20),
//               Form(
//                 key: _formKey,
//                 child: Container(
//                   padding: EdgeInsets.all(15),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         cursorColor: kPrimaryColor,
//                         validator: (val) => val!.isEmpty ? 'Enter A Username' : null,
//                         controller: usernameController,
//                         decoration: InputDecoration(
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: kPrimaryColor),
//                             ),
//                             hintText: "Username",
//                             prefixIcon: Icon(
//                               Icons.person,
//                               color: kPrimaryColor,
//                             )
//                         ),
//                         onChanged: (user) {
//                           print(user);
//                           username = user;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       IntlPhoneField(
//                         dropDownArrowColor: kPrimaryColor,
//                         style: TextStyle(
//                           color: kPrimaryColor,
//                         ),
//                         decoration: InputDecoration(
//                           labelText: 'Phone Number',
//                           focusColor: kPrimaryColor,
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: kPrimaryColor),
//                           ),
//                         ),
//                         onChanged: (phone) {
//                           controller: phone.completeNumber;
//                           phoneNumber = phone.completeNumber;
//                           code_country = phone.countryCode;
//                           isoCode = phone.countryISOCode;
//                           print(phone.completeNumber);
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         cursorColor: kPrimaryColor,
//                         validator: (val) => val!.isEmpty ? 'Please Enter A Country' : null,
//                         controller: countryController,
//                         decoration: InputDecoration(
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: kPrimaryColor),
//                             ),
//                             hintText: "Country",
//                             prefixIcon: Icon(
//                               Icons.place_outlined,
//                               color: kPrimaryColor,
//                             )
//                         ),
//                         onChanged: (userCountry) {
//                           print(userCountry);
//                           country = userCountry;
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () async{
//                   await DatabaseService(uid: firebaseUser!.uid).updateUserData(
//                       (firebaseUser.email).toString(), firebaseUser.displayName.toString(),
//                       phoneNumber, code_country, isoCode, countryController.text)
//                       .then((value) {
//                     Navigator.pushAndRemoveUntil(context,
//                         MaterialPageRoute(builder: (context) => NavigationBar()), (route) => false);
//                   });
//
//                   // AuthService().signInWithGoogle().then((UserCredential value) {
//                   //   final displayName = value.user!.displayName;
//                   //   print(displayName);
//                   //
//                   //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MuseumList()), (route) => false);
//                   //
//                   // });
//                   // Navigator.pop(context);
//
//                   },
//                 child: Text('Submit'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
