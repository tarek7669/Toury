import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants.dart';
import 'components/body.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

//   List<String> ids = [];
//   List<String> names = [];
//   List<String> locations = [];
//   List<String> thumbnails = [];
//   List<String> locationRoutes = [];
//   List<dynamic> finalPrices = [];
//   dynamic finalCurrency;
//
// //AFTER SELECTING A CERTAIN TOUR
//   List<String> descriptionRoutes = [];
//   List<String> voiceOvers = [];
//   List<String> voiceOverTitles = [];
//   List<String> voiceOverSlideshow = [];
//   List<String> descriptionSlideshow = [];
//   List<String> scripts = [];
//   List<String> languages = [];
//
//   bool loading_data = true;
//   dynamic finalIso;
//
//   getDocs() async {
//     setState(() {
//       loading_data = true;
//     });
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
//         "tours").get();
//
//     debugPrint('***** the length of QuerySnapshot Docs is ${querySnapshot.docs
//         .length} (museumList.dart -> getDocs())*****');
//     //FETCH IZO
//     final firebaseUser = await FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseUser.uid)
//           .get()
//           .then((ds) {
//         finalIso = ds['ISOCode'];
//
//
//         //get NAMES, LOCATIONS, THUMBNAILS, DESCRIPTION ROUTES, LOCATION ROUTES
//         for (int i = 0; i < querySnapshot.docs.length; i++) {
//           var a = querySnapshot.docs[i];
//           // documents.add(a.get('Email'));
//           if (finalIso == "EG") {
//             // documents.add(a.get('Email'));
//             setState(() {
//               ids.add(a.get('ID'));
//               names.add(a.get('Name'));
//               locations.add(a.get('Location'));
//               thumbnails.add(a.get('Thumbnail'));
//               // descriptionRoutes.add(a.get('DescriptionRoute'));
//               locationRoutes.add(a.get('LocationRoute'));
//               finalPrices.add(a.get('EgyptianPrice'));
//               finalCurrency = "EGP";
//             });
//           } else {
//             setState(() {
//               ids.add(a.get('ID'));
//               names.add(a.get('Name'));
//               locations.add(a.get('Location'));
//               thumbnails.add(a.get('Thumbnail'));
//               // descriptionRoutes.add(a.get('DescriptionRoute'));
//               locationRoutes.add(a.get('LocationRoute'));
//               finalPrices.add(a.get('InternationalPrice'));
//               finalCurrency = "USD";
//             });
//           }
//         }
//
//         debugPrint("***** TOURS ID LENGTH IS EQUAL TO ${ids
//             .length} (museumList.dart -> getDocs())*****");
//
//         for (int i = 0; i < querySnapshot.docs.length; i++) {
//           print(ids[i]);
//           print(names[i]);
//           print(locations[i]);
//           print(thumbnails[i]);
//           // print(descriptionRoutes[i]);
//           print(locationRoutes[i]);
//           print(finalPrices[i]);
//           print("***** END TOUR ${i + 1} *****");
//         }
//         setState(() {
//           loading_data = false;
//         });
//
//
//         return names;
//       });
//     }
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     getDocs();
//     // debugPrint('***** the length of names list is ${names.length} *****');
//     // CheckConnection();
//     // _connectivity.initialise();
//     // _connectivity.myStream.listen((source) {
//     //   setState(() => _source = source);
//     // };
//     // getSlideShow();
//   }


  @override
  Widget build(BuildContext context) {
    // return loading_data ? Center(child: SpinKitFadingCube(
    //   color: kPrimaryColor,
    //   size: 50.0,
    // ))
    // : SearchBody(ids: ids, names: names, locations: locations, thumbnails: thumbnails, locationRoutes: locationRoutes,
    // finalPrices: finalPrices, finalCurrency: finalCurrency, descriptionRoutes: descriptionRoutes, voiceOvers: voiceOvers,
    //     voiceOverTitles: voiceOverTitles, voiceOverSlideshow: voiceOverSlideshow, descriptionSlideshow: descriptionSlideshow,
    //     scripts: scripts, languages: languages);
    return SearchBody();
  }
}

