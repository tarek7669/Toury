// import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_toury/Pages/MuseumDetail/components/MuseumServices.dart';
import 'package:project_toury/constants.dart';

class MuseumCard extends StatefulWidget {
  final String Id;
  final String Name;
  final String subtitle;
  final String Thumbnail;
  final File testThumbnails;
  final String locationRoute;
  // final double internationalPrice;
  // final double egyptianPrice;
  final dynamic finalPrice;
  final dynamic finalCurrency;

  final bool isConnected;

  const MuseumCard({
    Key? key,
    required this.Id,
    required this.Name,
    required this.subtitle,
    required this.Thumbnail,
    required this.testThumbnails,
    required this.locationRoute,
    // required this.internationalPrice,
    // required this.egyptianPrice,
    required this.finalPrice,
    required this.finalCurrency,
    required this.isConnected,
  }) : super(key: key);

  @override
  _MuseumCardState createState() => _MuseumCardState(
  Id,
  Name,
  subtitle,
  Thumbnail,
  testThumbnails,
  locationRoute,
  // internationalPrice,
  // egyptianPrice,
  finalPrice,
  finalCurrency,
  isConnected
  );
}

class _MuseumCardState extends State<MuseumCard> {
  final String Id;
  final String Name;
  final String subtitle;
  final String Thumbnail;
  final File testThumbnails;
  final String locationRoute;
  // final double internationalPrice;
  // final double egyptianPrice;
  final dynamic finalPrice;
  final dynamic finalCurrency;
  final bool isConnected;
  _MuseumCardState(
      this.Id,
      this.Name,
      this.subtitle,
      this.Thumbnail,
      this.testThumbnails,
      this.locationRoute,
      // this.internationalPrice,
      // this.egyptianPrice,
      this.finalPrice,
      this.finalCurrency,
      this.isConnected,
    );

  dynamic finalIso;
  // dynamic finalPrice;
  // dynamic finalCurrency;
  bool boughtTour = false;
  bool loading = true;
  List<String> paidTours = [];

  _fetchPaidTours() async{
    setState(() {
      paidTours = [];
    });

    await FirebaseFirestore.instance.collection('paidTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) async{
      List.from(value.data()!['paidTours']).forEach((element) {
        String data = element;
        paidTours.add(data);
      });
      debugPrint("***** museumCard -> _fetchPaidTours() ${paidTours.length}*****");

    });

    for(int i = 0; i < paidTours.length; i++) {
      print(paidTours[i]);
    }
//WHETHER THE USER BOUGHT THE TOUR
    for(int i = 0; i < paidTours.length; i++){
      if(Id == paidTours[i]){
        setState(() {
          boughtTour = true;
          loading = false;
        });
        break;
      } else {
        setState(() {
          boughtTour = false;
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchIzo();
    _fetchPaidTours();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  isConnected ? Image.network(Thumbnail, fit: BoxFit.fitWidth, width: size.width,)
                  : Image.file(testThumbnails),
                  Positioned(
                    right: 10,
                    bottom: 15,
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: loading ? Center(child: SpinKitFadingCube(
                          color: kPrimaryColor,
                          size: 50.0,
                        ))
                            : boughtTour ? Text(" Owned ", style: TextStyle(fontSize: 25, color: kSecondaryColor),)
                            : Text(
                          " $finalPrice $finalCurrency ",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Stack(
                // padding: EdgeInsets.only(left: 8.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: size.width * 0.9,
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          Name,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: Icon(Icons.location_on_rounded, color: kSecondaryColor,),
                              onPressed: () {
                                MuseumService.openMap(locationRoute);
                              }
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(top: 40.0, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subtitle,
                          style: TextStyle(
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      );
  }

  // _fetchIzo() async {
  //   final firebaseUser = await FirebaseAuth.instance.currentUser;
  //   if (firebaseUser != null){
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(firebaseUser.uid)
  //         .get()
  //         .then((ds) {
  //       finalIso = ds['ISOCode'];
  //
  //       if(finalIso == "EG"){
  //         setState(() {
  //           finalPrice = egyptianPrice;
  //           finalCurrency = 'EGP';
  //         });
  //       } else {
  //         setState(() {
  //           finalPrice = internationalPrice;
  //           finalCurrency = 'USD';
  //         });
  //       }
  //       debugPrint("***** museumCard -> _fetchIzo() *****");
  //       print(finalIso);
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   }
  //
  // }

}
