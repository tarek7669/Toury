import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_toury/Components/bottomNavigationBar.dart';
import 'package:project_toury/Models/user_model.dart';
import 'package:project_toury/Pages/Carousel_Start/Carousel.dart';
import 'package:project_toury/Pages/MuseumList/components/body.dart';
import 'package:project_toury/Pages/Profile/components/body.dart';
import 'package:project_toury/Services/InternetConnection.dart';
import '../../constants.dart';


class MuseumList extends StatefulWidget {
  const MuseumList({Key? key}) : super(key: key);

  @override
  _MuseumListState createState() => _MuseumListState();
}

class _MuseumListState extends State<MuseumList>
    /*with AutomaticKeepAliveClientMixin*/{

  // Map _source = {ConnectivityResult.none: false};
  // final MyConnectivity _connectivity = MyConnectivity.instance;
  //
  //
  // //CHECKING INTERNET CONNECTION
  // bool isConnected = false;

  // Future<void> CheckConnection() async{
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         isConnected = true;
  //       });
  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     setState(() {
  //       isConnected = false;
  //     });
  //     print('not connected');
  //   }
  // }


  //GET DATA FROM CLOUD FIRESTORE

  List<String> ids = [];
  List<String> names = [];
  List<String> locations = [];
  List<String> thumbnails = [];
  List<String> locationRoutes = [];
  // List<double> internationalPrices = [];
  // List<double> egyptianPrices = [];
  List<dynamic> finalPrices = [];

  //AFTER SELECTING A CERTAIN TOUR
  List<String> descriptionRoutes = [];
  List<String> voiceOvers = [];
  List<String> voiceOverTitles = [];
  List<String> voiceOverSlideshow = [];
  List<String> descriptionSlideshow = [];
  List<String> scripts = [];
  List<String> languages = [];

  bool loading_data = true;
  dynamic finalIso;
  dynamic finalCurrency;

  getDocs() async {
    setState(() {
      loading_data = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        "tours").get();

    debugPrint('***** the length of QuerySnapshot Docs is ${querySnapshot.docs
        .length} (museumList.dart -> getDocs())*****');

    //get NAMES, LOCATIONS, THUMBNAILS, DESCRIPTION ROUTES, LOCATION ROUTES
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      // documents.add(a.get('Email'));

      setState(() {
        ids.add(a.get('ID'));
        names.add(a.get('Name'));
        locations.add(a.get('Location'));
        thumbnails.add(a.get('Thumbnail'));
        // descriptionRoutes.add(a.get('DescriptionRoute'));
        locationRoutes.add(a.get('LocationRoute'));
        finalPrices.add(a.get('EgyptianPrice'));
        finalCurrency = "EGP";
      });

      // if (finalIso == "EG") {
      //   // documents.add(a.get('Email'));
      //   setState(() {
      //     ids.add(a.get('ID'));
      //     names.add(a.get('Name'));
      //     locations.add(a.get('Location'));
      //     thumbnails.add(a.get('Thumbnail'));
      //     // descriptionRoutes.add(a.get('DescriptionRoute'));
      //     locationRoutes.add(a.get('LocationRoute'));
      //     finalPrices.add(a.get('EgyptianPrice'));
      //     finalCurrency = "EGP";
      //   });
      // } else {
      //   setState(() {
      //     ids.add(a.get('ID'));
      //     names.add(a.get('Name'));
      //     locations.add(a.get('Location'));
      //     thumbnails.add(a.get('Thumbnail'));
      //     // descriptionRoutes.add(a.get('DescriptionRoute'));
      //     locationRoutes.add(a.get('LocationRoute'));
      //     finalPrices.add(a.get('InternationalPrice'));
      //     finalCurrency = "USD";
      //   });
      // }

      // setState(() {
      //   ids.add(a.get('ID'));
      //   names.add(a.get('Name'));
      //   locations.add(a.get('Location'));
      //   thumbnails.add(a.get('Thumbnail'));
      //   // descriptionRoutes.add(a.get('DescriptionRoute'));
      //   locationRoutes.add(a.get('LocationRoute'));
      //   internationalPrices.add(a.get('InternationalPrice'));
      //   egyptianPrices.add(a.get('EgyptianPrice'));
      // });
    }
    debugPrint("\n\n***** TOURS ID LENGTH IS EQUAL TO ${ids
        .length} (museumList.dart -> getDocs())*****\n\n");
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      print(ids[i]);
      print(names[i]);
      print(locations[i]);
      print(thumbnails[i]);
      // print(descriptionRoutes[i]);
      print(locationRoutes[i]);
      // print(internationalPrices[i]);
      // print(egyptianPrices[i]);
      print(finalPrices[i]);
      print(finalCurrency);
      print("***** END TOUR ${i + 1} *****");
    }

    setState(() {
      loading_data = false;
    });
    return ids;


    //FETCH IZO
    // final firebaseUser = await FirebaseAuth.instance.currentUser;
    // if (firebaseUser != null) {
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(firebaseUser.uid)
    //       .get()
    //       .then((ds) {
    //     finalIso = ds['ISOCode'];
    //
    //     //get NAMES, LOCATIONS, THUMBNAILS, DESCRIPTION ROUTES, LOCATION ROUTES
    //     for (int i = 0; i < querySnapshot.docs.length; i++) {
    //       var a = querySnapshot.docs[i];
    //       // documents.add(a.get('Email'));
    //
    //       if (finalIso == "EG") {
    //         // documents.add(a.get('Email'));
    //         setState(() {
    //           ids.add(a.get('ID'));
    //           names.add(a.get('Name'));
    //           locations.add(a.get('Location'));
    //           thumbnails.add(a.get('Thumbnail'));
    //           // descriptionRoutes.add(a.get('DescriptionRoute'));
    //           locationRoutes.add(a.get('LocationRoute'));
    //           finalPrices.add(a.get('EgyptianPrice'));
    //           finalCurrency = "EGP";
    //         });
    //       } else {
    //         setState(() {
    //           ids.add(a.get('ID'));
    //           names.add(a.get('Name'));
    //           locations.add(a.get('Location'));
    //           thumbnails.add(a.get('Thumbnail'));
    //           // descriptionRoutes.add(a.get('DescriptionRoute'));
    //           locationRoutes.add(a.get('LocationRoute'));
    //           finalPrices.add(a.get('InternationalPrice'));
    //           finalCurrency = "USD";
    //         });
    //       }
    //
    //       // setState(() {
    //       //   ids.add(a.get('ID'));
    //       //   names.add(a.get('Name'));
    //       //   locations.add(a.get('Location'));
    //       //   thumbnails.add(a.get('Thumbnail'));
    //       //   // descriptionRoutes.add(a.get('DescriptionRoute'));
    //       //   locationRoutes.add(a.get('LocationRoute'));
    //       //   internationalPrices.add(a.get('InternationalPrice'));
    //       //   egyptianPrices.add(a.get('EgyptianPrice'));
    //       // });
    //     }
    //
    //     debugPrint("***** TOURS ID LENGTH IS EQUAL TO ${ids
    //         .length} (museumList.dart -> getDocs())*****");
    //
    //     for (int i = 0; i < querySnapshot.docs.length; i++) {
    //       print(ids[i]);
    //       print(names[i]);
    //       print(locations[i]);
    //       print(thumbnails[i]);
    //       // print(descriptionRoutes[i]);
    //       print(locationRoutes[i]);
    //       // print(internationalPrices[i]);
    //       // print(egyptianPrices[i]);
    //       print(finalPrices[i]);
    //       print(finalCurrency);
    //       print("***** END TOUR ${i + 1} *****");
    //     }
    //
    //     setState(() {
    //       loading_data = false;
    //     });
    //     return ids;
    //   });
    // }
  }

  Future<void> refreshList() async{
    setState((){
      loading_data = true;
    });
    await Future.delayed(Duration(seconds: 2));

    //REFRESH INTERNET CONNECTION
    // try {
    //   final result = await InternetAddress.lookup('example.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     setState(() {
    //       isConnected = true;
    //     });
    //     print('connected');
    //   }
    // } on SocketException catch (_) {
    //   setState(() {
    //     isConnected = false;
    //   });
    //   print('not connected');
    // }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("tours").get();

    setState(() {
      ids = [];
      names = [];
      locations = [];
      thumbnails = [];
      descriptionRoutes = [];
      locationRoutes = [];
      // internationalPrices = [];
      // egyptianPrices = [];
      finalPrices = [];
      descriptionSlideshow = [];
      voiceOvers = [];
      voiceOverTitles = [];
      voiceOverSlideshow = [];
      scripts = [];
      languages = [];


      debugPrint('***** the length of QuerySnapshot Docs is ${querySnapshot.docs.length} (museumList.dart -> refreshList())*****');
      //refresh NAMES, LOCATIONS, THUMBNAILS, DESCRIPTION ROUTES, LOCATION ROUTES
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        // documents.add(a.get('Email'));
        if (finalIso == "EG") {
          // documents.add(a.get('Email'));
          setState(() {
            ids.add(a.get('ID'));
            names.add(a.get('Name'));
            locations.add(a.get('Location'));
            thumbnails.add(a.get('Thumbnail'));
            // descriptionRoutes.add(a.get('DescriptionRoute'));
            locationRoutes.add(a.get('LocationRoute'));
            finalPrices.add(a.get('EgyptianPrice'));
            finalCurrency = "EGP";
          });
        } else {
          setState(() {
            ids.add(a.get('ID'));
            names.add(a.get('Name'));
            locations.add(a.get('Location'));
            thumbnails.add(a.get('Thumbnail'));
            // descriptionRoutes.add(a.get('DescriptionRoute'));
            locationRoutes.add(a.get('LocationRoute'));
            finalPrices.add(a.get('InternationalPrice'));
            finalCurrency = "USD";
          });
        }
      }
      for (int i = 0; i < names.length; i++) {
        print(ids[i]);
        print(names[i]);
        print(locations[i]);
        print(thumbnails[i]);
        // print(descriptionRoutes[i]);
        print(locationRoutes[i]);
        // print(internationalPrices[i]);
        // print(egyptianPrices[i]);
        print(finalPrices[i]);
      }
    });
    setState((){
      loading_data = false;
    });
  }


  List<String> search_ids = [];
  List<String> search_names = [];
  List<String> search_locations = [];
  List<String> search_thumbnails = [];
  List<String> search_locationRoutes = [];
  List<dynamic> search_finalPrices = [];

//AFTER SELECTING A CERTAIN TOUR
  List<String> search_descriptionRoutes = [];
  List<String> search_voiceOvers = [];
  List<String> search_voiceOverTitles = [];
  List<String> search_voiceOverSlideshow = [];
  List<String> search_descriptionSlideshow = [];
  List<String> search_scripts = [];
  List<String> search_languages = [];

  List<String> _foundUsers = [];
  bool is_loading = false;
  bool exit = true;

  @override
  void initState(){
    getDocs();
    is_loading = true;
    _foundUsers = names;
    is_loading = false;
    super.initState();
  }


  void _runFilter(String enteredKeyword) async {
    setState(() {
      is_loading = true;

      search_ids = [];
      search_names = [];
      search_locations = [];
      search_thumbnails = [];
      search_locationRoutes = [];
      search_finalPrices = [];

//AFTER SELECTING A CERTAIN TOUR
      search_descriptionRoutes = [];
      search_voiceOvers = [];
      search_voiceOverTitles = [];
      search_voiceOverSlideshow = [];
      search_descriptionSlideshow = [];
      search_scripts = [];
      search_languages = [];
    });

    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      // results = names;
      setState(() {
        results.clear();
        search_ids = ids;
        search_names = names;
        search_locations = locations;
        search_thumbnails = thumbnails;
        // descriptionRoutes.add(a.get('DescriptionRoute'));
        search_locationRoutes = locationRoutes;
        search_finalPrices = finalPrices;
        finalCurrency = "EGP";
      });
    }

    else {
      // results = names
      //     .where((name) =>
      //     name.toLowerCase().contains(enteredKeyword.toLowerCase()))
      //     .toList();
      //
      // setState(() {
      //   // search_ids = ids
      //   //     .where((id) => id.);
      //   search_names = names
      //       .where((name) =>
      //       name.toLowerCase().contains(enteredKeyword.toLowerCase()))
      //       .toList();
      // });

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
          "tours").get();

      //get NAMES, LOCATIONS, THUMBNAILS, DESCRIPTION ROUTES, LOCATION ROUTES
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        // documents.add(a.get('Email'));

        if (a.get('Name').toLowerCase().contains(enteredKeyword.toLowerCase()) ) {
          setState(() {
            results = names;
            search_ids.add(a.get('ID'));
            search_names.add(a.get('Name'));
            search_locations.add(a.get('Location'));
            search_thumbnails.add(a.get('Thumbnail'));
            // descriptionRoutes.add(a.get('DescriptionRoute'));
            search_locationRoutes.add(a.get('LocationRoute'));
            search_finalPrices.add(a.get('EgyptianPrice'));
            finalCurrency = "EGP";
          });
        }
        // else {
        //   setState(() {
        //     ids.add(a.get('ID'));
        //     names.add(a.get('Name'));
        //     locations.add(a.get('Location'));
        //     thumbnails.add(a.get('Thumbnail'));
        //     // descriptionRoutes.add(a.get('DescriptionRoute'));
        //     locationRoutes.add(a.get('LocationRoute'));
        //     finalPrices.add(a.get('InternationalPrice'));
        //     finalCurrency = "USD";
        //   });
        // }

        // we use the toLowerCase() method to make it case-insensitive
      }
      setState(() {
        _foundUsers = results;
        is_loading = false;
      });
    }
  }

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Toury',
      style: GoogleFonts.anton(
        textStyle: TextStyle(
          color: kPrimaryColor,
          letterSpacing: 2.0,
          fontSize: 35,
        ),
      ));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      child: Scaffold(

        body: CustomScrollView(
          slivers: [
            SliverAppBar(

              pinned: false,
              floating: true,
              backgroundColor: Theme.of(context).canvasColor,
              // expandedHeight: size.height * 0.4,
              automaticallyImplyLeading: false,
              // foregroundColor: Colors.red,
              iconTheme: IconThemeData(color: kPrimaryColor),


              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (customIcon.icon == Icons.search) {
                        // Perform set of instructions.
                        // debugPrint("\n\n ${UserModel().uid} \n\n");
                        exit = false;
                        customIcon = const Icon(Icons.cancel);
                        customSearchBar = ListTile(
                          leading: Icon(
                            Icons.search,
                            color: kPrimaryColor,
                            size: 28,
                          ),
                          title: TextField(
                            onChanged: (value) => _runFilter(value),
                            decoration: InputDecoration(
                              hintText: 'type in tour name...',
                              hintStyle: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: kSecondaryColor,
                            ),
                          ),
                        );
                      } else {
                        customIcon = const Icon(Icons.search);
                        customSearchBar = Text('Toury',
                            style: GoogleFonts.anton(
                              textStyle: TextStyle(
                                color: kPrimaryColor,
                                letterSpacing: 2.0,
                                fontSize: 35,
                              ),
                            ));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBar()));
                        exit = true;
                      }
                    });
                  },
                  icon: customIcon,
                )
              ],


              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.fromLTRB(13.0, 23.0, 3.0, 13.0),
                centerTitle: false,
                title: customSearchBar,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return Container(
                    child: exit ? Body(ids: ids, names: names, locations: locations, thumbnails: thumbnails,
                      locationRoutes: locationRoutes, finalPrices: finalPrices, finalCurrency: finalCurrency,
                      descriptionRoutes: descriptionRoutes,
                      descriptionSlideshow: descriptionSlideshow, voiceOvers: voiceOvers, voiceOverTitles: voiceOverTitles,
                      voiceOverSlideshow: voiceOverSlideshow, scripts: scripts, languages: languages,)

                        : _foundUsers.isNotEmpty ? Body(ids: search_ids, names: search_names, locations: search_locations, thumbnails: search_thumbnails,
                      locationRoutes: search_locationRoutes, finalPrices: search_finalPrices, finalCurrency: finalCurrency,
                      descriptionRoutes: search_descriptionRoutes,
                      descriptionSlideshow: search_descriptionSlideshow, voiceOvers: search_voiceOvers, voiceOverTitles: search_voiceOverTitles,
                      voiceOverSlideshow: search_voiceOverSlideshow, scripts: search_scripts, languages: search_languages,)
                        : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                },
                childCount: 1,)
            ),
          ],
        )

        // appBar: AppBar(
        //   elevation: 10,
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.white,
        //   iconTheme: IconThemeData(color: kPrimaryColor),
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         setState(() {
        //           if (customIcon.icon == Icons.search) {
        //             // Perform set of instructions.
        //             // debugPrint("\n\n ${UserModel().uid} \n\n");
        //             exit = false;
        //             customIcon = const Icon(Icons.cancel);
        //             customSearchBar = ListTile(
        //               leading: Icon(
        //                 Icons.search,
        //                 color: kPrimaryColor,
        //                 size: 28,
        //               ),
        //               title: TextField(
        //                 onChanged: (value) => _runFilter(value),
        //                 decoration: InputDecoration(
        //                   hintText: 'type in tour name...',
        //                   hintStyle: TextStyle(
        //                     color: kSecondaryColor,
        //                     fontSize: 18,
        //                     fontStyle: FontStyle.italic,
        //                   ),
        //                   border: InputBorder.none,
        //                 ),
        //                 style: TextStyle(
        //                   color: kSecondaryColor,
        //                 ),
        //               ),
        //             );
        //           } else {
        //             customIcon = const Icon(Icons.search);
        //             customSearchBar = Text('Toury',
        //                 style: GoogleFonts.iceland(
        //                   textStyle: TextStyle(
        //                     color: kPrimaryColor,
        //                     letterSpacing: 2.0,
        //                     fontSize: 35,
        //                   ),
        //                 ));
        //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBar()));
        //             exit = true;
        //           }
        //         });
        //       },
        //       icon: customIcon,
        //     )
        //   ],
        //   title:customSearchBar,
        // ),
        //
        // body: Container(
        //   child: exit ? Body(ids: ids, names: names, locations: locations, thumbnails: thumbnails,
        //     locationRoutes: locationRoutes, finalPrices: finalPrices, finalCurrency: finalCurrency,
        //     descriptionRoutes: descriptionRoutes,
        //     descriptionSlideshow: descriptionSlideshow, voiceOvers: voiceOvers, voiceOverTitles: voiceOverTitles,
        //     voiceOverSlideshow: voiceOverSlideshow, scripts: scripts, languages: languages,)
        //
        //         : _foundUsers.isNotEmpty ? Body(ids: search_ids, names: search_names, locations: search_locations, thumbnails: search_thumbnails,
        //     locationRoutes: search_locationRoutes, finalPrices: search_finalPrices, finalCurrency: finalCurrency,
        //     descriptionRoutes: search_descriptionRoutes,
        //     descriptionSlideshow: search_descriptionSlideshow, voiceOvers: search_voiceOvers, voiceOverTitles: search_voiceOverTitles,
        //     voiceOverSlideshow: search_voiceOverSlideshow, scripts: search_scripts, languages: search_languages,)
        //       : const Text(
        //     'No results found',
        //     style: TextStyle(fontSize: 24),
        //   ),
        //     ),
        ),
      onRefresh: refreshList,
    );
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;
}

