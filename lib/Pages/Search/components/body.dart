import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_toury/Pages/Carousel_Start/Carousel.dart';
import 'package:project_toury/Pages/Login/login.dart';
import 'package:project_toury/Pages/MuseumList/components/body.dart';
import 'package:project_toury/Services/auth_services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class SearchBody extends StatefulWidget {
//   final List<String> ids;
//   final List<String> names;
//   final List<String> locations;
//   final List<String> thumbnails;
//   final List<String> locationRoutes;
//   final List<dynamic> finalPrices;
//   final dynamic finalCurrency;
//
// //AFTER SELECTING A CERTAIN TOUR
//   final List<String> descriptionRoutes;
//   final List<String> voiceOvers;
//   final List<String> voiceOverTitles;
//   final List<String> voiceOverSlideshow;
//   final List<String> descriptionSlideshow;
//   final List<String> scripts;
//   final List<String> languages;

  SearchBody({
    Key? key,
    // required this.ids, required this.names,
    // required this.locations, required this.thumbnails,
    // required this.locationRoutes, required this.finalPrices,
    // required this.finalCurrency, required this.descriptionRoutes,
    // required this.voiceOvers, required this.voiceOverTitles,
    // required this.voiceOverSlideshow, required this.descriptionSlideshow,
    // required this.scripts, required this.languages,
  }) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState(/*ids, names, locations, thumbnails, locationRoutes, finalPrices, finalCurrency,
  descriptionRoutes, voiceOvers, voiceOverTitles, voiceOverSlideshow, descriptionSlideshow, scripts, languages*/);
}

class _SearchBodyState extends State<SearchBody> {
//   List<String> ids;
//   List<String> names;
//   List<String> locations;
//   List<String> thumbnails;
//   List<String> locationRoutes;
//   List<dynamic> finalPrices;
//   dynamic finalCurrency;
//
// //AFTER SELECTING A CERTAIN TOUR
//   List<String> descriptionRoutes;
//   List<String> voiceOvers;
//   List<String> voiceOverTitles;
//   List<String> voiceOverSlideshow;
//   List<String> descriptionSlideshow;
//   List<String> scripts;
//   List<String> languages;
//   _SearchBodyState(this.ids, this.names,
//       this.locations, this.thumbnails,
//       this.locationRoutes, this.finalPrices,
//       this.finalCurrency, this.descriptionRoutes,
//       this.voiceOvers, this.voiceOverTitles,
//       this.voiceOverSlideshow, this.descriptionSlideshow,
//       this.scripts, this.languages,);
//
//   List<String> search_ids = [];
//   List<String> search_names = [];
//   List<String> search_locations = [];
//   List<String> search_thumbnails = [];
//   List<String> search_locationRoutes = [];
//   List<dynamic> search_finalPrices = [];
//
// //AFTER SELECTING A CERTAIN TOUR
//   List<String> search_descriptionRoutes = [];
//   List<String> search_voiceOvers = [];
//   List<String> search_voiceOverTitles = [];
//   List<String> search_voiceOverSlideshow = [];
//   List<String> search_descriptionSlideshow = [];
//   List<String> search_scripts = [];
//   List<String> search_languages = [];
//
//   // final List<Map<String, dynamic>> _allUsers = [
//   //   {"id": 1, "name": "Andy", "age": 29},
//   //   {"id": 2, "name": "Aragon", "age": 40},
//   //   {"id": 3, "name": "Bob", "age": 5},
//   //   {"id": 4, "name": "Barbara", "age": 35},
//   //   {"id": 5, "name": "Candy", "age": 21},
//   //   {"id": 6, "name": "Colin", "age": 55},
//   //   {"id": 7, "name": "Audra", "age": 30},
//   //   {"id": 8, "name": "Banana", "age": 14},
//   //   {"id": 9, "name": "Caversky", "age": 100},
//   //   {"id": 10, "name": "Becky", "age": 32},
//   // ];
//   List<String> _foundUsers = [];
//   bool is_loading = false;
//   bool exit = true;
//   @override
//   initState() {
//     // at the beginning, all users are shown
//     is_loading = true;
//     _foundUsers = names;
//     super.initState();
//     is_loading = false;
//   }
//
//   void _runFilter(String enteredKeyword) async {
//     setState(() {
//       is_loading = true;
//
//       search_ids = [];
//       search_names = [];
//       search_locations = [];
//       search_thumbnails = [];
//       search_locationRoutes = [];
//       search_finalPrices = [];
//
// //AFTER SELECTING A CERTAIN TOUR
//       search_descriptionRoutes = [];
//       search_voiceOvers = [];
//       search_voiceOverTitles = [];
//       search_voiceOverSlideshow = [];
//       search_descriptionSlideshow = [];
//       search_scripts = [];
//       search_languages = [];
//     });
//
//     List<String> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       // results = names;
//       setState(() {
//         results.clear();
//         search_ids = ids;
//         search_names = names;
//         search_locations = locations;
//         search_thumbnails = thumbnails;
//         // descriptionRoutes.add(a.get('DescriptionRoute'));
//         search_locationRoutes = locationRoutes;
//         search_finalPrices = finalPrices;
//         finalCurrency = "EGP";
//       });
//     }
//
//      else {
//       // results = names
//       //     .where((name) =>
//       //     name.toLowerCase().contains(enteredKeyword.toLowerCase()))
//       //     .toList();
//       //
//       // setState(() {
//       //   // search_ids = ids
//       //   //     .where((id) => id.);
//       //   search_names = names
//       //       .where((name) =>
//       //       name.toLowerCase().contains(enteredKeyword.toLowerCase()))
//       //       .toList();
//       // });
//
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
//           "tours").get();
//
//           //get NAMES, LOCATIONS, THUMBNAILS, DESCRIPTION ROUTES, LOCATION ROUTES
//           for (int i = 0; i < querySnapshot.docs.length; i++) {
//             var a = querySnapshot.docs[i];
//             // documents.add(a.get('Email'));
//
//             if (a.get('Name').toLowerCase().contains(enteredKeyword.toLowerCase()) ) {
//               setState(() {
//                 results = names;
//                 search_ids.add(a.get('ID'));
//                 search_names.add(a.get('Name'));
//                 search_locations.add(a.get('Location'));
//                 search_thumbnails.add(a.get('Thumbnail'));
//                 // descriptionRoutes.add(a.get('DescriptionRoute'));
//                 search_locationRoutes.add(a.get('LocationRoute'));
//                 search_finalPrices.add(a.get('EgyptianPrice'));
//                 finalCurrency = "EGP";
//               });
//             }
//             // else {
//             //   setState(() {
//             //     ids.add(a.get('ID'));
//             //     names.add(a.get('Name'));
//             //     locations.add(a.get('Location'));
//             //     thumbnails.add(a.get('Thumbnail'));
//             //     // descriptionRoutes.add(a.get('DescriptionRoute'));
//             //     locationRoutes.add(a.get('LocationRoute'));
//             //     finalPrices.add(a.get('InternationalPrice'));
//             //     finalCurrency = "USD";
//             //   });
//             // }
//
//       // we use the toLowerCase() method to make it case-insensitive
//       }
//       setState(() {
//         _foundUsers = results;
//         is_loading = false;
//       });
//     }
//   }
//
//   Icon customIcon = const Icon(Icons.search);
//   Widget customSearchBar = Text('Toury',
//       style: GoogleFonts.iceland(
//     textStyle: TextStyle(
//       color: kPrimaryColor,
//       letterSpacing: 2.0,
//       fontSize: 35,
//     ),
//   ));

bool changed = true;
int _count = 0;
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    // Size size = MediaQuery.of(context).size;
    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 10,
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Colors.white,
    //     iconTheme: IconThemeData(color: kPrimaryColor),
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           setState(() {
    //             if (customIcon.icon == Icons.search) {
    //               // Perform set of instructions.
    //               exit = false;
    //               customIcon = const Icon(Icons.cancel);
    //               customSearchBar = ListTile(
    //                 leading: Icon(
    //                   Icons.search,
    //                   color: kPrimaryColor,
    //                   size: 28,
    //                 ),
    //                 title: TextField(
    //                   onChanged: (value) => _runFilter(value),
    //                   decoration: InputDecoration(
    //                     hintText: 'type in tour name...',
    //                     hintStyle: TextStyle(
    //                       color: kSecondaryColor,
    //                       fontSize: 18,
    //                       fontStyle: FontStyle.italic,
    //                     ),
    //                     border: InputBorder.none,
    //                   ),
    //                   style: TextStyle(
    //                     color: kSecondaryColor,
    //                   ),
    //                 ),
    //               );
    //             } else {
    //               customIcon = const Icon(Icons.search);
    //               customSearchBar = Text('Toury',
    //                   style: GoogleFonts.iceland(
    //                     textStyle: TextStyle(
    //                       color: kPrimaryColor,
    //                       letterSpacing: 2.0,
    //                       fontSize: 35,
    //                     ),
    //                   ));
    //               exit = true;
    //             }
    //           });
    //         },
    //         icon: customIcon,
    //       )
    //     ],
    //     // title: Text(
    //     //   'Toury',
    //     //   style: GoogleFonts.iceland(
    //     //     textStyle: TextStyle(
    //     //       color: kPrimaryColor,
    //     //       letterSpacing: 2.0,
    //     //       fontSize: 35,
    //     //     ),
    //     //   ),
    //     // ),
    //     title:customSearchBar,
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: const EdgeInsets.all(10),
    //       child: Column(
    //         children: [
    //           // const SizedBox(
    //           //   height: 20,
    //           // ),
    //           // TextField(
    //           //   onChanged: (value) => _runFilter(value),
    //           //   style: TextStyle(color: kSecondaryColor),
    //           //   decoration: InputDecoration(
    //           //     // labelText: 'Search...',
    //           //     hintText: "Search...",
    //           //     suffixIcon: Icon(Icons.search, color: kPrimaryColor,),
    //           //     labelStyle: new TextStyle(
    //           //         color: kSecondaryColor
    //           //     ),
    //           //     enabledBorder: UnderlineInputBorder(
    //           //       borderSide: BorderSide(color: kPrimaryColor),
    //           //     ),
    //           //     focusedBorder: UnderlineInputBorder(
    //           //       borderSide: BorderSide(color: kPrimaryColor),
    //           //     ),
    //           //   ),
    //           // ),
    //           // const SizedBox(
    //           //   height: 20,
    //           // ),
    //           // Expanded(
    //           //   child: _foundUsers.isNotEmpty
    //           //       ? ListView.builder(
    //           //     itemCount: _foundUsers.length,
    //           //     itemBuilder: (context, index) => Card(
    //           //       key: ValueKey(_foundUsers[index]["id"]),
    //           //       color: Colors.amberAccent,
    //           //       elevation: 4,
    //           //       margin: const EdgeInsets.symmetric(vertical: 10),
    //           //       child: ListTile(
    //           //         leading: Text(
    //           //           _foundUsers[index]["id"].toString(),
    //           //           style: const TextStyle(fontSize: 24),
    //           //         ),
    //           //         title: Text(_foundUsers[index]['name']),
    //           //         subtitle: Text(
    //           //             '${_foundUsers[index]["age"].toString()} years old'),
    //           //       ),
    //           //     ),
    //           //   )
    //           //       : const Text(
    //           //     'No results found',
    //           //     style: TextStyle(fontSize: 24),
    //           //   ),
    //           // ),
    //           exit ? SingleChildScrollView(
    //             child: homeList(idList: ids, nameList: names, thumbnailList: thumbnails, locationList: locations,
    //               descriptionRouteList: descriptionRoutes, locationRouteList: locationRoutes, finalPriceList: finalPrices,
    //               finalCurrency: finalCurrency,
    //               descriptionSlideshowList: descriptionSlideshow, voiceOversList: voiceOvers, voiceOverTitlesList: voiceOverTitles,
    //               voiceOverSlideshowList: voiceOverSlideshow, scriptsList: scripts, languagesList: languages,),
    //           )
    //           : _foundUsers.isNotEmpty ? SingleChildScrollView(
    //             child: homeList(idList: search_ids, nameList: search_names, thumbnailList: search_thumbnails, locationList: search_locations,
    //               descriptionRouteList: search_descriptionRoutes, locationRouteList: search_locationRoutes, finalPriceList: search_finalPrices,
    //               finalCurrency: finalCurrency,
    //               descriptionSlideshowList: search_descriptionSlideshow, voiceOversList: search_voiceOvers, voiceOverTitlesList: search_voiceOverTitles,
    //               voiceOverSlideshowList: search_voiceOverSlideshow, scriptsList: search_scripts, languagesList: search_languages,),
    //           )
    //               : const Text(
    //                 'No results found',
    //                 style: TextStyle(fontSize: 24),
    //               ),
    //         ],
    //       ),
    //     ),
    //   ),
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Toury',
          style: GoogleFonts.iceland(
            textStyle: TextStyle(
              color: kPrimaryColor,
              letterSpacing: 2.0,
              fontSize: 35,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                '$_count',
                // This key causes the AnimatedSwitcher to interpret this as a "new"
                // child each time the count changes, so that it will begin its animation
                // when the count changes.
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            GestureDetector(
              child: const Text('Increment'),
              onTap: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
      // body: Stack(
      //   // alignment: Alignment(0, 0),
      //   children: [
      //     GestureDetector(
      //       onTap: () {
      //         debugPrint("tapped");
      //         setState(() {
      //           changed = !changed;
      //         });
      //
      //         AnimatedSwitcher(
      //           duration: const Duration(milliseconds: 1000),
      //           transitionBuilder: (Widget child, Animation<double> animation) {
      //             return ScaleTransition(scale: animation, child: child);
      //           },
      //           child: changed ? Container(
      //             color: kPrimaryLightColor,
      //           )
      //               : Container(
      //             color: Colors.red,
      //           ),
      //           key: ValueKey<bool>(changed),
      //         );
      //
      //       },
      //       child: changed ? Container(
      //         color: kPrimaryLightColor,
      //       )
      //           : Container(
      //         color: Colors.red,
      //       )
      //     ),
      //   ],
      // ),
    );
  }

}
