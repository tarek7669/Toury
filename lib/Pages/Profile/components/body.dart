import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_toury/Components/CustomAppBar.dart';
import 'package:project_toury/Components/SpinKit.dart';
import 'package:project_toury/Components/UserSharedPreferences.dart';
import 'package:project_toury/Models/user_model.dart';
import 'package:project_toury/Pages/Carousel_Start/Carousel.dart';
import 'package:project_toury/Pages/Login/components/body.dart';
import 'package:provider/provider.dart';
import 'package:project_toury/Pages/Login/login.dart';
import 'package:project_toury/Services/auth_services.dart';
import 'package:project_toury/constants.dart';
import 'package:project_toury/Models/user_model.dart' as user;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class profileBody extends StatefulWidget {
  const profileBody({Key? key}) : super(key: key);

  @override
  _profileBodyState createState() => _profileBodyState();
}

class _profileBodyState extends State<profileBody> {

  dynamic myUsername;
  dynamic myPhone;
  dynamic myCountry;
  dynamic myCountryCode;

  UserModel user = new UserModel();
  bool is_fetched = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // body: CustomScrollView(
        //   slivers: [
        //     SliverAppBar(
        //       pinned: false,
        //       floating: true,
        //       backgroundColor: Theme.of(context).canvasColor,
        //       // expandedHeight: size.height * 0.4,
        //       automaticallyImplyLeading: false,
        //       // foregroundColor: Colors.red,
        //       iconTheme: IconThemeData(color: kPrimaryColor),
        //
        //       flexibleSpace: FlexibleSpaceBar(
        //         titlePadding: EdgeInsets.fromLTRB(13.0, 23.0, 3.0, 13.0),
        //         centerTitle: false,
        //         title: Text('Toury',
        //             style: GoogleFonts.anton(
        //               textStyle: TextStyle(
        //                 color: kPrimaryColor,
        //                 letterSpacing: 2.0,
        //                 fontSize: 35,
        //               ),
        //             )),
        //       ),
        //     ),
        //
        //     SliverList(
        //         delegate: SliverChildBuilderDelegate(
        //               (_, int index) {
        //             return SingleChildScrollView(
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(18.0),
        //                   child: Container(
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         // Text(
        //                         //     'Profile',
        //                         //     style: TextStyle(
        //                         //       fontSize: 40,
        //                         //       color: kSecondaryColor,
        //                         //     )
        //                         // ),
        //                         // SizedBox(height: 15),
        //                         Text(
        //                           'Name',
        //                           style: TextStyle(
        //                             fontSize: 15,
        //                             color: kSecondaryColor,
        //                             letterSpacing: 1.5,
        //                           ),
        //                         ),
        //                         SizedBox(height: 5),
        //                         Text(
        //                           UserSharedPreferences.getUsername() as String,
        //                           style: TextStyle(
        //                             fontSize: 30,
        //                             color: kPrimaryColor,
        //                           ),
        //                         ),
        //                         SizedBox(height: 15),
        //                         Text(
        //                           'Phone',
        //                           style: TextStyle(
        //                             fontSize: 15,
        //                             color: kSecondaryColor,
        //                             letterSpacing: 1.5,
        //                           ),
        //                         ),
        //                         SizedBox(height: 5),
        //                         Text(
        //                           UserSharedPreferences.getPhoneNumber() as String,
        //                           style: TextStyle(
        //                             fontSize: 30,
        //                             color: kPrimaryColor,
        //                           ),
        //                         ),
        //                         SizedBox(height: 25,),
        //                         // FlatButton(
        //                         //   minWidth: size.width,
        //                         //   height: 50,
        //                         //   color: kPrimaryColor,
        //                         //   onPressed: () async{
        //                         //     await authService.signout();
        //                         //     Navigator.pushReplacement(context,
        //                         //         MaterialPageRoute(builder: (context) => Login()));
        //                         //   },
        //                         //   child: Text(
        //                         //       'LOG OUT',
        //                         //       style: TextStyle(
        //                         //         color: Colors.white,
        //                         //         fontSize: 20,
        //                         //       )
        //                         //   ),
        //                         // ),
        //                         // SizedBox(height: 25,),
        //
        //
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(10),
        //                                 topRight: Radius.circular(10),
        //                               ),
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             share(context);
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(10),
        //                                 topRight: Radius.circular(10),
        //                               ),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Invite Friends',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(Icons.person_add_alt_1_outlined, color: kPrimaryColor,),
        //                                   onPressed: () {
        //                                     share(context);
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             Navigator.pushNamed(context, '/feedback');
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Send Feedback',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(CupertinoIcons.bubble_right, color: kPrimaryColor,),
        //                                   onPressed: () {
        //                                     Navigator.pushNamed(context, '/feedback');
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             // TODO
        //
        //                             Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'How To Use Toury',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(Icons.info_outline_rounded, color: kPrimaryColor,),
        //                                   onPressed: () {
        //                                     // TODO
        //
        //                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () async{
        //                             try{
        //                               await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
        //                             } catch(e) {
        //                               ScaffoldMessenger.of(context).showSnackBar(
        //                                   SnackBar(content: Text("Can't Open The url")));
        //                             }
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Privacy Policy',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(CupertinoIcons.lock, color: kPrimaryColor,),
        //                                   onPressed: () async {
        //                                     try{
        //                                       await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
        //                                     } catch(e) {
        //                                       ScaffoldMessenger.of(context).showSnackBar(
        //                                           SnackBar(content: Text("Can't Open The url")));
        //                                     }
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             // TODO
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Follow Us',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Image.asset("assets/icons/facebook.png",
        //                                     width: 23,
        //                                     height: 23,
        //                                     color: kPrimaryColor,
        //                                   ),
        //                                   onPressed: () {
        //                                     // TODO
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () async{
        //                             try{
        //                               await launch('https://www.instagram.com/tarek.ashraf.733/');
        //                             } catch(e) {
        //                               ScaffoldMessenger.of(context).showSnackBar(
        //                                   SnackBar(content: Text("Can't Open Instagram")));
        //                             }
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Follow Us',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Image.asset("assets/icons/instagram (1).png",
        //                                     width: 23,
        //                                     height: 23,
        //                                     color: kPrimaryColor,
        //                                   ),
        //                                   onPressed: () async {
        //                                     try{
        //                                       await launch('https://www.instagram.com/tarek.ashraf.733/');
        //                                     } catch(e) {
        //                                       ScaffoldMessenger.of(context).showSnackBar(
        //                                           SnackBar(content: Text("Can't Open Instagram")));
        //                                     }
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.only(
        //                                 bottomLeft: Radius.circular(10),
        //                                 bottomRight: Radius.circular(10),
        //                               ),
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () async{
        //                             await authService.signout();
        //                             Navigator.pushReplacement(context,
        //                                 MaterialPageRoute(builder: (context) => Login()));
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(10),
        //                                 topRight: Radius.circular(10),
        //                               ),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'LOGOUT',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(Icons.logout, color: kPrimaryColor,),
        //                                   onPressed: () async{
        //                                     await authService.signout();
        //                                     Navigator.pushReplacement(context,
        //                                         MaterialPageRoute(builder: (context) => Login()));
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //
        //                       ],
        //                     ),
        //                   ),
        //                 ) );
        //           },
        //           childCount: 1,)
        //     ),
        //   ],
        // )

        body: CustomAppBar(
          widget: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //     'Profile',
                      //     style: TextStyle(
                      //       fontSize: 40,
                      //       color: kSecondaryColor,
                      //     )
                      // ),
                      // SizedBox(height: 15),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 15,
                          color: kSecondaryColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        UserSharedPreferences.getUsername() as String,
                        style: TextStyle(
                          fontSize: 30,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Phone',
                        style: TextStyle(
                          fontSize: 15,
                          color: kSecondaryColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        UserSharedPreferences.getPhoneNumber() as String,
                        style: TextStyle(
                          fontSize: 30,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 25,),
                      // FlatButton(
                      //   minWidth: size.width,
                      //   height: 50,
                      //   color: kPrimaryColor,
                      //   onPressed: () async{
                      //     await authService.signout();
                      //     Navigator.pushReplacement(context,
                      //         MaterialPageRoute(builder: (context) => Login()));
                      //   },
                      //   child: Text(
                      //       'LOG OUT',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 20,
                      //       )
                      //   ),
                      // ),
                      // SizedBox(height: 25,),


                      FlatButton(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            side: BorderSide(color: kPrimaryColor,)
                        ),
                        onPressed: () {
                          share(context);
                        },
                        child: Container(
                          width: 350.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                label: Text(
                                  'Invite Friends',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: kPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                icon: Icon(Icons.person_add_alt_1_outlined, color: kPrimaryColor,),
                                onPressed: () {
                                  share(context);
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kPrimaryColor,)
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/feedback');
                        },
                        child: Container(
                          width: 350.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                label: Text(
                                  'Send Feedback',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: kPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                icon: Icon(CupertinoIcons.bubble_right, color: kPrimaryColor,),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/feedback');
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kPrimaryColor,)
                        ),
                        onPressed: () {
                          // TODO

                          Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
                        },
                        child: Container(
                          width: 350.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                label: Text(
                                  'How To Use Toury',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: kPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                icon: Icon(Icons.info_outline_rounded, color: kPrimaryColor,),
                                onPressed: () {
                                  // TODO

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kPrimaryColor,)
                        ),
                        onPressed: () async{
                          try{
                            await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
                          } catch(e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Can't Open The url")));
                          }
                        },
                        child: Container(
                          width: 350.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                label: Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: kPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                icon: Icon(CupertinoIcons.lock, color: kPrimaryColor,),
                                onPressed: () async {
                                  try{
                                    await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
                                  } catch(e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Can't Open The url")));
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kPrimaryColor,)
                        ),
                        onPressed: () {
                          // TODO
                        },
                        child: Container(
                          width: 350.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                label: Text(
                                  'Follow Us',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: kPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                icon: Image.asset("assets/icons/facebook.png",
                                  width: 23,
                                  height: 23,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  // TODO
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kPrimaryColor,)
                        ),
                        onPressed: () async{
                          try{
                            await launch('https://www.instagram.com/tarek.ashraf.733/');
                          } catch(e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Can't Open Instagram")));
                          }
                        },
                        child: Container(
                          width: 350.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                label: Text(
                                  'Follow Us',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: kPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                icon: Image.asset("assets/icons/instagram (1).png",
                                  width: 23,
                                  height: 23,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () async {
                                  try{
                                    await launch('https://www.instagram.com/tarek.ashraf.733/');
                                  } catch(e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Can't Open Instagram")));
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            side: BorderSide(color: kPrimaryColor,)
                        ),
                        onPressed: () async{
                          await authService.signout();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          width: 350.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                label: Text(
                                  'LOGOUT',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: kPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                icon: Icon(Icons.logout, color: kPrimaryColor,),
                                onPressed: () async{
                                  await authService.signout();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => Login()));
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ) )
        )

        // body: CustomScrollView(
        //   slivers: [
        //     SliverAppBar(
        //       pinned: false,
        //       floating: true,
        //       backgroundColor: Theme.of(context).canvasColor,
        //       // expandedHeight: size.height * 0.4,
        //       automaticallyImplyLeading: false,
        //       // foregroundColor: Colors.red,
        //       iconTheme: IconThemeData(color: kPrimaryColor),
        //
        //       flexibleSpace: FlexibleSpaceBar(
        //         titlePadding: EdgeInsets.fromLTRB(13.0, 23.0, 3.0, 13.0),
        //         centerTitle: false,
        //         title: Text('Toury',
        //             style: GoogleFonts.anton(
        //               textStyle: TextStyle(
        //                 color: kPrimaryColor,
        //                 letterSpacing: 2.0,
        //                 fontSize: 35,
        //               ),
        //             )),
        //       ),
        //     ),
        //
        //     SliverList(
        //         delegate: SliverChildBuilderDelegate(
        //               (_, int index) {
        //             return is_fetched ? SingleChildScrollView(
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(18.0),
        //                   child: Container(
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                             'Profile',
        //                             style: TextStyle(
        //                               fontSize: 40,
        //                               color: kSecondaryColor,
        //                             )
        //                         ),
        //                         SizedBox(height: 15),
        //                         Text(
        //                           'Name',
        //                           style: TextStyle(
        //                             fontSize: 15,
        //                             color: kSecondaryColor,
        //                             letterSpacing: 1.5,
        //                           ),
        //                         ),
        //                         SizedBox(height: 5),
        //                         Text(
        //                           user.uid,
        //                           style: TextStyle(
        //                             fontSize: 30,
        //                             color: kPrimaryColor,
        //                           ),
        //                         ),
        //                         SizedBox(height: 15),
        //                         Text(
        //                           'Phone',
        //                           style: TextStyle(
        //                             fontSize: 15,
        //                             color: kSecondaryColor,
        //                             letterSpacing: 1.5,
        //                           ),
        //                         ),
        //                         SizedBox(height: 5),
        //                         Text(
        //                           user.phoneNumber as String,
        //                           style: TextStyle(
        //                             fontSize: 30,
        //                             color: kPrimaryColor,
        //                           ),
        //                         ),
        //                         SizedBox(height: 25,),
        //                         // FlatButton(
        //                         //   minWidth: size.width,
        //                         //   height: 50,
        //                         //   color: kPrimaryColor,
        //                         //   onPressed: () async{
        //                         //     await authService.signout();
        //                         //     Navigator.pushReplacement(context,
        //                         //         MaterialPageRoute(builder: (context) => Login()));
        //                         //   },
        //                         //   child: Text(
        //                         //       'LOG OUT',
        //                         //       style: TextStyle(
        //                         //         color: Colors.white,
        //                         //         fontSize: 20,
        //                         //       )
        //                         //   ),
        //                         // ),
        //                         // SizedBox(height: 25,),
        //
        //
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(10),
        //                                 topRight: Radius.circular(10),
        //                               ),
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             share(context);
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(10),
        //                                 topRight: Radius.circular(10),
        //                               ),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Invite Friends',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(Icons.person_add_alt_1_outlined, color: kPrimaryColor,),
        //                                   onPressed: () {
        //                                     share(context);
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             Navigator.pushNamed(context, '/feedback');
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Send Feedback',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(CupertinoIcons.bubble_right, color: kPrimaryColor,),
        //                                   onPressed: () {
        //                                     Navigator.pushNamed(context, '/feedback');
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             // TODO
        //
        //                             Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'How To Use Toury',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(Icons.info_outline_rounded, color: kPrimaryColor,),
        //                                   onPressed: () {
        //                                     // TODO
        //
        //                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () async{
        //                             try{
        //                               await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
        //                             } catch(e) {
        //                               ScaffoldMessenger.of(context).showSnackBar(
        //                                   SnackBar(content: Text("Can't Open The url")));
        //                             }
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Privacy Policy',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(CupertinoIcons.lock, color: kPrimaryColor,),
        //                                   onPressed: () async {
        //                                     try{
        //                                       await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
        //                                     } catch(e) {
        //                                       ScaffoldMessenger.of(context).showSnackBar(
        //                                           SnackBar(content: Text("Can't Open The url")));
        //                                     }
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () {
        //                             // TODO
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Follow Us',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Image.asset("assets/icons/facebook.png",
        //                                     width: 23,
        //                                     height: 23,
        //                                     color: kPrimaryColor,
        //                                   ),
        //                                   onPressed: () {
        //                                     // TODO
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () async{
        //                             try{
        //                               await launch('https://www.instagram.com/tarek.ashraf.733/');
        //                             } catch(e) {
        //                               ScaffoldMessenger.of(context).showSnackBar(
        //                                   SnackBar(content: Text("Can't Open Instagram")));
        //                             }
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.circular(0),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'Follow Us',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Image.asset("assets/icons/instagram (1).png",
        //                                     width: 23,
        //                                     height: 23,
        //                                     color: kPrimaryColor,
        //                                   ),
        //                                   onPressed: () async {
        //                                     try{
        //                                       await launch('https://www.instagram.com/tarek.ashraf.733/');
        //                                     } catch(e) {
        //                                       ScaffoldMessenger.of(context).showSnackBar(
        //                                           SnackBar(content: Text("Can't Open Instagram")));
        //                                     }
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                         FlatButton(
        //                           color: kPrimaryLightColor,
        //                           shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.only(
        //                                 bottomLeft: Radius.circular(10),
        //                                 bottomRight: Radius.circular(10),
        //                               ),
        //                               side: BorderSide(color: kPrimaryColor,)
        //                           ),
        //                           onPressed: () async{
        //                             await authService.signout();
        //                             Navigator.pushReplacement(context,
        //                                 MaterialPageRoute(builder: (context) => Login()));
        //                           },
        //                           child: Container(
        //                             width: 350.0,
        //                             height: 55.0,
        //                             decoration: BoxDecoration(
        //                               color: kPrimaryLightColor,
        //                               shape: BoxShape.rectangle,
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(10),
        //                                 topRight: Radius.circular(10),
        //                               ),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 FlatButton.icon(
        //                                   label: Text(
        //                                     'LOGOUT',
        //                                     style: TextStyle(
        //                                       letterSpacing: 2.0,
        //                                       color: kPrimaryColor,
        //                                       fontSize: 17,
        //                                     ),
        //                                   ),
        //                                   icon: Icon(Icons.logout, color: kPrimaryColor,),
        //                                   onPressed: () async{
        //                                     await authService.signout();
        //                                     Navigator.pushReplacement(context,
        //                                         MaterialPageRoute(builder: (context) => Login()));
        //                                   },
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment: MainAxisAlignment.end,
        //                                   children: [
        //                                     Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //
        //                       ],
        //                     ),
        //                   ),
        //                 ) )
        //                 : FutureBuilder(
        //                 future: _fetch(),
        //                 builder: (context, snapshot) {
        //                   if (snapshot.connectionState != ConnectionState.done)
        //                     return Padding(
        //                       padding: EdgeInsets.only(top: size.height * 0.35),
        //                       child: DoubleBounce(),
        //                     );
        //                   return SingleChildScrollView(
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(18.0),
        //                         child: Container(
        //                           child: Column(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: [
        //                               Text(
        //                                   'Profile',
        //                                   style: TextStyle(
        //                                     fontSize: 40,
        //                                     color: kSecondaryColor,
        //                                   )
        //                               ),
        //                               SizedBox(height: 15),
        //                               Text(
        //                                 'Name',
        //                                 style: TextStyle(
        //                                   fontSize: 15,
        //                                   color: kSecondaryColor,
        //                                   letterSpacing: 1.5,
        //                                 ),
        //                               ),
        //                               SizedBox(height: 5),
        //                               Text(
        //                                 "$myUsername",
        //                                 style: TextStyle(
        //                                   fontSize: 30,
        //                                   color: kPrimaryColor,
        //                                 ),
        //                               ),
        //                               SizedBox(height: 15),
        //                               Text(
        //                                 'Phone',
        //                                 style: TextStyle(
        //                                   fontSize: 15,
        //                                   color: kSecondaryColor,
        //                                   letterSpacing: 1.5,
        //                                 ),
        //                               ),
        //                               SizedBox(height: 5),
        //                               Text(
        //                                 "$myPhone",
        //                                 style: TextStyle(
        //                                   fontSize: 30,
        //                                   color: kPrimaryColor,
        //                                 ),
        //                               ),
        //                               SizedBox(height: 25,),
        //                               // FlatButton(
        //                               //   minWidth: size.width,
        //                               //   height: 50,
        //                               //   color: kPrimaryColor,
        //                               //   onPressed: () async{
        //                               //     await authService.signout();
        //                               //     Navigator.pushReplacement(context,
        //                               //         MaterialPageRoute(builder: (context) => Login()));
        //                               //   },
        //                               //   child: Text(
        //                               //       'LOG OUT',
        //                               //       style: TextStyle(
        //                               //         color: Colors.white,
        //                               //         fontSize: 20,
        //                               //       )
        //                               //   ),
        //                               // ),
        //                               // SizedBox(height: 25,),
        //
        //
        //                               FlatButton(
        //                                 color: kPrimaryLightColor,
        //                                 shape: RoundedRectangleBorder(
        //                                     borderRadius: BorderRadius.only(
        //                                       topLeft: Radius.circular(10),
        //                                       topRight: Radius.circular(10),
        //                                     ),
        //                                     side: BorderSide(color: kPrimaryColor,)
        //                                 ),
        //                                 onPressed: () {
        //                                   share(context);
        //                                 },
        //                                 child: Container(
        //                                   width: 350.0,
        //                                   height: 55.0,
        //                                   decoration: BoxDecoration(
        //                                     color: kPrimaryLightColor,
        //                                     shape: BoxShape.rectangle,
        //                                     borderRadius: BorderRadius.only(
        //                                       topLeft: Radius.circular(10),
        //                                       topRight: Radius.circular(10),
        //                                     ),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       FlatButton.icon(
        //                                         label: Text(
        //                                           'Invite Friends',
        //                                           style: TextStyle(
        //                                             letterSpacing: 2.0,
        //                                             color: kPrimaryColor,
        //                                             fontSize: 17,
        //                                           ),
        //                                         ),
        //                                         icon: Icon(Icons.person_add_alt_1_outlined, color: kPrimaryColor,),
        //                                         onPressed: () {
        //                                           share(context);
        //                                         },
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.end,
        //                                         children: [
        //                                           Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               FlatButton(
        //                                 color: kPrimaryLightColor,
        //                                 shape: RoundedRectangleBorder(
        //                                     side: BorderSide(color: kPrimaryColor,)
        //                                 ),
        //                                 onPressed: () {
        //                                   Navigator.pushNamed(context, '/feedback');
        //                                 },
        //                                 child: Container(
        //                                   width: 350.0,
        //                                   height: 55.0,
        //                                   decoration: BoxDecoration(
        //                                     color: kPrimaryLightColor,
        //                                     shape: BoxShape.rectangle,
        //                                     borderRadius: BorderRadius.circular(0),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       FlatButton.icon(
        //                                         label: Text(
        //                                           'Send Feedback',
        //                                           style: TextStyle(
        //                                             letterSpacing: 2.0,
        //                                             color: kPrimaryColor,
        //                                             fontSize: 17,
        //                                           ),
        //                                         ),
        //                                         icon: Icon(CupertinoIcons.bubble_right, color: kPrimaryColor,),
        //                                         onPressed: () {
        //                                           Navigator.pushNamed(context, '/feedback');
        //                                         },
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.end,
        //                                         children: [
        //                                           Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               FlatButton(
        //                                 color: kPrimaryLightColor,
        //                                 shape: RoundedRectangleBorder(
        //                                     side: BorderSide(color: kPrimaryColor,)
        //                                 ),
        //                                 onPressed: () {
        //                                   // TODO
        //
        //                                   Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
        //                                 },
        //                                 child: Container(
        //                                   width: 350.0,
        //                                   height: 55.0,
        //                                   decoration: BoxDecoration(
        //                                     color: kPrimaryLightColor,
        //                                     shape: BoxShape.rectangle,
        //                                     borderRadius: BorderRadius.circular(0),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       FlatButton.icon(
        //                                         label: Text(
        //                                           'How To Use Toury',
        //                                           style: TextStyle(
        //                                             letterSpacing: 2.0,
        //                                             color: kPrimaryColor,
        //                                             fontSize: 17,
        //                                           ),
        //                                         ),
        //                                         icon: Icon(Icons.info_outline_rounded, color: kPrimaryColor,),
        //                                         onPressed: () {
        //                                           // TODO
        //
        //                                           Navigator.push(context, MaterialPageRoute(builder: (context) => Carousel(first_time: false)));
        //                                         },
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.end,
        //                                         children: [
        //                                           Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               FlatButton(
        //                                 color: kPrimaryLightColor,
        //                                 shape: RoundedRectangleBorder(
        //                                     side: BorderSide(color: kPrimaryColor,)
        //                                 ),
        //                                 onPressed: () async{
        //                                   try{
        //                                     await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
        //                                   } catch(e) {
        //                                     ScaffoldMessenger.of(context).showSnackBar(
        //                                         SnackBar(content: Text("Can't Open The url")));
        //                                   }
        //                                 },
        //                                 child: Container(
        //                                   width: 350.0,
        //                                   height: 55.0,
        //                                   decoration: BoxDecoration(
        //                                     color: kPrimaryLightColor,
        //                                     shape: BoxShape.rectangle,
        //                                     borderRadius: BorderRadius.circular(0),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       FlatButton.icon(
        //                                         label: Text(
        //                                           'Privacy Policy',
        //                                           style: TextStyle(
        //                                             letterSpacing: 2.0,
        //                                             color: kPrimaryColor,
        //                                             fontSize: 17,
        //                                           ),
        //                                         ),
        //                                         icon: Icon(CupertinoIcons.lock, color: kPrimaryColor,),
        //                                         onPressed: () async {
        //                                           try{
        //                                             await launch('https://github.com/TouryCO/Toury_Privacy-Policy/blob/main/privacy_policy');
        //                                           } catch(e) {
        //                                             ScaffoldMessenger.of(context).showSnackBar(
        //                                                 SnackBar(content: Text("Can't Open The url")));
        //                                           }
        //                                         },
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.end,
        //                                         children: [
        //                                           Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               FlatButton(
        //                                 color: kPrimaryLightColor,
        //                                 shape: RoundedRectangleBorder(
        //                                     side: BorderSide(color: kPrimaryColor,)
        //                                 ),
        //                                 onPressed: () {
        //                                   // TODO
        //                                 },
        //                                 child: Container(
        //                                   width: 350.0,
        //                                   height: 55.0,
        //                                   decoration: BoxDecoration(
        //                                     color: kPrimaryLightColor,
        //                                     shape: BoxShape.rectangle,
        //                                     borderRadius: BorderRadius.circular(0),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       FlatButton.icon(
        //                                         label: Text(
        //                                           'Follow Us',
        //                                           style: TextStyle(
        //                                             letterSpacing: 2.0,
        //                                             color: kPrimaryColor,
        //                                             fontSize: 17,
        //                                           ),
        //                                         ),
        //                                         icon: Image.asset("assets/icons/facebook.png",
        //                                           width: 23,
        //                                           height: 23,
        //                                           color: kPrimaryColor,
        //                                         ),
        //                                         onPressed: () {
        //                                           // TODO
        //                                         },
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.end,
        //                                         children: [
        //                                           Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               FlatButton(
        //                                 color: kPrimaryLightColor,
        //                                 shape: RoundedRectangleBorder(
        //                                     side: BorderSide(color: kPrimaryColor,)
        //                                 ),
        //                                 onPressed: () async{
        //                                   try{
        //                                     await launch('https://www.instagram.com/tarek.ashraf.733/');
        //                                   } catch(e) {
        //                                     ScaffoldMessenger.of(context).showSnackBar(
        //                                         SnackBar(content: Text("Can't Open Instagram")));
        //                                   }
        //                                 },
        //                                 child: Container(
        //                                   width: 350.0,
        //                                   height: 55.0,
        //                                   decoration: BoxDecoration(
        //                                     color: kPrimaryLightColor,
        //                                     shape: BoxShape.rectangle,
        //                                     borderRadius: BorderRadius.circular(0),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       FlatButton.icon(
        //                                         label: Text(
        //                                           'Follow Us',
        //                                           style: TextStyle(
        //                                             letterSpacing: 2.0,
        //                                             color: kPrimaryColor,
        //                                             fontSize: 17,
        //                                           ),
        //                                         ),
        //                                         icon: Image.asset("assets/icons/instagram (1).png",
        //                                           width: 23,
        //                                           height: 23,
        //                                           color: kPrimaryColor,
        //                                         ),
        //                                         onPressed: () async {
        //                                           try{
        //                                             await launch('https://www.instagram.com/tarek.ashraf.733/');
        //                                           } catch(e) {
        //                                             ScaffoldMessenger.of(context).showSnackBar(
        //                                                 SnackBar(content: Text("Can't Open Instagram")));
        //                                           }
        //                                         },
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.end,
        //                                         children: [
        //                                           Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               FlatButton(
        //                                 color: kPrimaryLightColor,
        //                                 shape: RoundedRectangleBorder(
        //                                     borderRadius: BorderRadius.only(
        //                                       bottomLeft: Radius.circular(10),
        //                                       bottomRight: Radius.circular(10),
        //                                     ),
        //                                     side: BorderSide(color: kPrimaryColor,)
        //                                 ),
        //                                 onPressed: () async{
        //                                   await authService.signout();
        //                                   Navigator.pushReplacement(context,
        //                                       MaterialPageRoute(builder: (context) => Login()));
        //                                 },
        //                                 child: Container(
        //                                   width: 350.0,
        //                                   height: 55.0,
        //                                   decoration: BoxDecoration(
        //                                     color: kPrimaryLightColor,
        //                                     shape: BoxShape.rectangle,
        //                                     borderRadius: BorderRadius.only(
        //                                       topLeft: Radius.circular(10),
        //                                       topRight: Radius.circular(10),
        //                                     ),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       FlatButton.icon(
        //                                         label: Text(
        //                                           'LOGOUT',
        //                                           style: TextStyle(
        //                                             letterSpacing: 2.0,
        //                                             color: kPrimaryColor,
        //                                             fontSize: 17,
        //                                           ),
        //                                         ),
        //                                         icon: Icon(Icons.logout, color: kPrimaryColor,),
        //                                         onPressed: () async{
        //                                           await authService.signout();
        //                                           Navigator.pushReplacement(context,
        //                                               MaterialPageRoute(builder: (context) => Login()));
        //                                         },
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.end,
        //                                         children: [
        //                                           Icon(CupertinoIcons.chevron_right, color: kPrimaryColor,),
        //                                         ],
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //
        //                             ],
        //                           ),
        //                         ),
        //                       )
        //                   );
        //                 }
        //             );
        //           },
        //           childCount: 1,)
        //     ),
        //   ],
        // )
    );
  }

  share(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    Share.share(
      'This is the link in here',
      subject: 'A Link For Toury App ;)',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
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
        myCountryCode = ds['CountryCode'];

        user.setUID(FirebaseAuth.instance.currentUser!.uid);
        user.setUsername(myUsername);
        user.setPhone(myPhone);

        user.uid = FirebaseAuth.instance.currentUser!.uid;
        user.username = myUsername;
        user.phoneNumber = myPhone;

        if(user.uid == "")
          is_fetched = false;
        else
          is_fetched = true;
        print(user.uid);
        print(user.username);
        print(user.phoneNumber);
        print(is_fetched);

        // print(myUsername);
        // print(myPhone);
        // print(myCountryCode);
      }).catchError((e) {
        print(e);
      });

    // final user.User userInfo = new user.User(FirebaseAuth.instance.currentUser!.uid, myUsername, myPhone);
  }
}

