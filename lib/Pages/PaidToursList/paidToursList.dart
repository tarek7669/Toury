import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_toury/Components/bottomNavigationBar.dart';
import 'package:project_toury/Pages/MuseumList/museumList.dart';
import '../../constants.dart';
import 'components/PaidToursBody.dart';

class PaidToursList extends StatefulWidget {
  PaidToursList({ Key? key}) : super(key: key);

  @override
  _PaidToursListState createState() => _PaidToursListState();
}

class _PaidToursListState extends State<PaidToursList> with AutomaticKeepAliveClientMixin{

  List<String> paidListID = [];
  List<String> downloadedListID = [];
  bool is_empty = true;
  bool loading_data = true;

  //GET DATA FROM CLOUD FIRESTORE
  List<String> ids = [];
  List<String> names = [];
  List<String> locations = [];
  List<String> thumbnails = [];
  List<File> testThumbnails = [];
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

  dynamic finalIso;
  dynamic finalCurrency;

  bool isConnected = false, loading_connection = false;

  Future<void> CheckConnection() async{
    setState(() {
      loading_connection = true;
    });

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isConnected = true;
        });
        print('CONNECTED    (bottomNavigationBar -> CheckConnection())');
      }
    } on SocketException catch (_) {
      setState(() {
        isConnected = false;
      });
      print('NOT CONNECTED   (bottomNavigationBar -> CheckConnection())');
    }

    setState(() {
      loading_connection = false;
    });
  }

  _fetchOfflineData() async{
    Directory fetched_directory = Directory("/storage/emulated/0/Toury App/");
    //test directories
    Directory sub_voiceOvers = Directory("/storage/emulated/0/Toury App/IZRrFMjed1v1RweB5Jvn/Voice Overs");
    Directory sub_voiceOverSlideshow = Directory("/storage/emulated/0/Toury App/IZRrFMjed1v1RweB5Jvn/Voice Over Slideshow");
    Directory sub_Thumbnail = Directory("/storage/emulated/0/Toury App/IZRrFMjed1v1RweB5Jvn/Thumbnail");
    Directory sub_descriptionSlideshow = Directory("/storage/emulated/0/Toury App/IZRrFMjed1v1RweB5Jvn/Description Slideshow");


    //dummy data
    ids.add("IZRrFMjed1v1RweB5Jvn");
    names.add("Aswan Museum");
    locations.add("Aswan");
    locationRoutes.add("https://www.google.com/maps/place/Museu+d'Assuan/@24.0850074,32.8847928,17z/data=!4m9!1m2!2m1!1saswan+museum!3m5!1s0x14367b4cbf181b19:"
        "0x8198a3efb4c1b5e8!8m2!3d24.0850074!4d32.8869815!15sCgxhc3dhbiBtdXNldW1aDiIMYXN3YW4gbXVzZXVtkgEGbXVzZXVt");

    finalPrices.add(23.99);
    descriptionRoutes.add("English Aswan Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
        "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.");
    descriptionRoutes.add("Arabic Aswan Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
        "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.");

    languages.add("English");
    languages.add("Arabic");

    scripts.add("First Test Script");
    scripts.add("Second Test Script");

    //get voice overs
    try {
      await for (var entity in
      sub_voiceOvers.list(recursive: true, followLinks: false)) {
        print(entity.path);

        debugPrint("\n\n sub directories \n");

        voiceOvers.add(entity.toString());

        // debugPrint(entity.toString());
        debugPrint("\n sub directories \n\n");
      }
    }catch(e){
      debugPrint("\n\n getting voice over error\n");
      debugPrint(e.toString());
      debugPrint("\n ending voice over error\n\n");
    }

    try{
      //get voice over slideshow
      await for (var entity in
      sub_voiceOverSlideshow.list(recursive: true, followLinks: false)) {
        print(entity.path);

        debugPrint("\n\n sub directories \n");

        voiceOverSlideshow.add(entity.toString());

        // debugPrint(entity.toString());
        debugPrint("\n sub directories \n\n");
      }
    }catch(e){
      debugPrint("\n\n getting voice over slideshow error\n");
      debugPrint(e.toString());
      debugPrint("\n ending voice over slideshow error\n\n");
    }

    try{
      //get thumbnail
      await for (var entity in
      sub_Thumbnail.list(recursive: true, followLinks: false)) {
        print(entity.path);

        debugPrint("\n\n sub directories \n");

        testThumbnails.add(File(entity.toString()));

        // debugPrint(entity.toString());
        debugPrint("\n sub directories \n\n");
      }
    }catch(e){
      debugPrint("\n\n getting thumbnail error\n");
      debugPrint(e.toString());
      debugPrint("\n ending thumbnail error\n\n");
    }

    try{
      //get description slideshow
      await for (var entity in
      sub_descriptionSlideshow.list(recursive: true, followLinks: false)) {
        print(entity.path);

        debugPrint("\n\n sub directories \n");

        descriptionSlideshow.add(entity.toString());

        // debugPrint(entity.toString());
        debugPrint("\n sub directories \n\n");
      }
    }catch(e){
      debugPrint("\n\n getting description slideshow error\n");
      debugPrint(e.toString());
      debugPrint("\n ending description slideshow error\n\n");
    }
  }

  _fetchPaidListId() async {
    setState(() {
      paidListID = [];
      // loading_data = true;
    });

    // await FirebaseFirestore.instance.collection('paidTours')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get().then((value) {
    //   List.from(value.data()!['paidTours']).forEach((element) {
    //     String data = element;
    //     setState(() {
    //       paidListID.add(data);
    //     });
    //   });
    // });
    // debugPrint("***** paidToursList -> _fetchPaidListId() *****");
    // debugPrint("paid list length is equal to ${paidListID.length}");
    // for(int i = 0; i < paidListID.length; i++){
    //   print(paidListID[i]);
    //   print(i);
    // }

    await FirebaseFirestore.instance.collection('likedTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
      List.from(value.data()!['likedTours']).forEach((element) {
        String data = element;
        setState(() {
          paidListID.add(data);
        });
      });
    });
    debugPrint("***** likedToursList -> _fetchPaidListId() *****");
    debugPrint("liked list length is equal to ${paidListID.length}");
    for (int i = 0; i < paidListID.length; i++) {
      print(paidListID[i]);
      print(i);
    }

    //GET DOCS()

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
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        "tours").get();

    //FETCH IZO
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        finalIso = ds['ISOCode'];

        for (int i = 0; i < querySnapshot.docs.length; i++) {
          var a = querySnapshot.docs[i];

          if (finalIso == "EG") {
            for (int j = 0; j < paidListID.length; j++) {
              var a = querySnapshot.docs[i];

              if (paidListID[j] == a.get('ID')) {
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
                break;
              }
            }
          } else {
            for (int j = 0; j < paidListID.length; j++) {
              var a = querySnapshot.docs[i];
              if (paidListID[j] == a.get('ID')) {
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
                break;
              }
            }
          }
        }

        if (names.length == 0) {
          setState(() {
            is_empty = true;
          });
        } else {
          setState(() {
            is_empty = false;
          });
        }


        setState(() {
          // loading_data = false;
        });

        return ids;

        //END OF GET DOCS()


      });
    }
  }

  _fetchDownloadedListId() async {
    setState(() {
      downloadedListID = [];
      // loading_data = true;
    });

    // await FirebaseFirestore.instance.collection('paidTours')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get().then((value) {
    //   List.from(value.data()!['paidTours']).forEach((element) {
    //     String data = element;
    //     setState(() {
    //       paidListID.add(data);
    //     });
    //   });
    // });
    // debugPrint("***** paidToursList -> _fetchPaidListId() *****");
    // debugPrint("paid list length is equal to ${paidListID.length}");
    // for(int i = 0; i < paidListID.length; i++){
    //   print(paidListID[i]);
    //   print(i);
    // }

    await FirebaseFirestore.instance.collection('downloadedTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
      List.from(value.data()!['downloadedTours']).forEach((element) {
        String data = element;
        setState(() {
          downloadedListID.add(data);
        });
      });
    });
    debugPrint("***** downloadedToursList -> _fetchDownloadedListId() *****");
    debugPrint("liked list length is equal to ${downloadedListID.length}");
    for (int i = 0; i < downloadedListID.length; i++) {
      print(downloadedListID[i]);
      print(i);
    }

    //GET DOCS()

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
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        "tours").get();

    //FETCH IZO
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        finalIso = ds['ISOCode'];

        for (int i = 0; i < querySnapshot.docs.length; i++) {
          var a = querySnapshot.docs[i];

          if (finalIso == "EG") {
            for (int j = 0; j < paidListID.length; j++) {
              var a = querySnapshot.docs[i];

              if (paidListID[j] == a.get('ID')) {
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
                break;
              }
            }
          } else {
            for (int j = 0; j < paidListID.length; j++) {
              var a = querySnapshot.docs[i];
              if (paidListID[j] == a.get('ID')) {
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
                break;
              }
            }
          }
        }

        if (names.length == 0) {
          setState(() {
            is_empty = true;
          });
        } else {
          setState(() {
            is_empty = false;
          });
        }


        setState(() {
          // loading_data = false;
        });

        return ids;

        //END OF GET DOCS()


      });
    }
  }

  _runOperations() async {
    setState(() {
      loading_data = true;
    });

    await CheckConnection();

    if(isConnected){
      await _fetchPaidListId();
      await _fetchDownloadedListId();
    }
    else{
      await _fetchOfflineData();
    }

    setState(() {
      loading_data = false;
    });
  }

  // _getDocs() async{
  //   setState(() {
  //     ids = [];
  //     names = [];
  //     locations = [];
  //     thumbnails = [];
  //     descriptionRoutes = [];
  //     locationRoutes = [];
  //     internationalPrices = [];
  //     egyptianPrices = [];
  //     descriptionSlideshow = [];
  //     voiceOvers = [];
  //     voiceOverTitles = [];
  //     voiceOverSlideshow = [];
  //     scripts = [];
  //     languages = [];
  //   });
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("tours").get();
  //
  //   for(int i = 0; i < querySnapshot.docs.length; i++){
  //     for(int j = 0; j < paidListID.length; j++){
  //       var a = querySnapshot.docs[i];
  //
  //       if(paidListID[j] == a.get('ID')) {
  //         setState(() {
  //           ids.add(a.get('ID'));
  //           names.add(a.get('Name'));
  //           locations.add(a.get('Location'));
  //           thumbnails.add(a.get('Thumbnail'));
  //           locationRoutes.add(a.get('LocationRoute'));
  //           internationalPrices.add(a.get('InternationalPrice'));
  //           egyptianPrices.add(a.get('EgyptianPrice'));
  //         });
  //         break;
  //       }
  //     }
  //   }
  //
  //   if(names.length == 0) {
  //       setState(() {
  //         is_empty = true;
  //       });
  //   }else {
  //     setState(() {
  //       is_empty = false;
  //     });
  //   }
  //
  //   return ids;
  // }

  Future<void> refreshList() async{
    await Future.delayed(Duration(seconds: 2));

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
    });

      //refresh NAMES, LOCATIONS, THUMBNAILS, DESCRIPTION ROUTES, LOCATION ROUTES
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        for (int j = 0; j < paidListID.length; j++) {
          var a = querySnapshot.docs[i];

          if (finalIso == "EG") {
            for (int j = 0; j < paidListID.length; j++) {
              var a = querySnapshot.docs[i];

              if (paidListID[j] == a.get('ID')) {
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
                break;
              }
            }
          } else {
            for (int j = 0; j < paidListID.length; j++) {
              var a = querySnapshot.docs[i];
              if (paidListID[j] == a.get('ID')) {
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
                break;
              }
            }
          }
        }
      }

    if(names.length == 0) {
      setState(() {
        is_empty = true;
      });
    }else {
      setState(() {
        is_empty = false;
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _runOperations();
    //_fetchPaidListId();
    // _getDocs();
    debugPrint('***** the length of names list is ${names.length} (paidToursList -> initState())*****');

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FirebaseAuth.instance.currentUser == null
        ? Center(child: Text("SIGN IN TO CONTINUE"))
        :
    RefreshIndicator(
      child: Scaffold(
       //  appBar: AppBar(
       //    elevation: 10,
       //    automaticallyImplyLeading: false,
       //    backgroundColor: Colors.white,
       //    title: Text(
       //      'Toury',
       //      style: GoogleFonts.iceland(
       //        textStyle: TextStyle(
       //          color: kPrimaryColor,
       //          letterSpacing: 2.0,
       //          fontSize: 35,
       //        ),
       //      ),
       //    ),
       //  ),
       //  body: loading_data ? Center(child: SpinKitFadingCube(
       //    color: kPrimaryColor,
       //    size: 50.0,
       //  ))
       //   // : isConnected ?
       // : Container(
       //    child: PaidToursBody(ids: ids, names: names, locations: locations, thumbnails: thumbnails,
       //      locationRoutes: locationRoutes, finalPrices: finalPrices, finalCurrency: finalCurrency,
       //      descriptionRoutes: descriptionRoutes, descriptionSlideshow: descriptionSlideshow, voiceOvers: voiceOvers,
       //      voiceOverTitles: voiceOverTitles, voiceOverSlideshow: voiceOverSlideshow,
       //      scripts: scripts, languages: languages, is_empty: is_empty, isConnected: isConnected,
       //        testThumbnails: testThumbnails,
       //    ),
       //  )

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


                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.fromLTRB(13.0, 23.0, 3.0, 13.0),
                  centerTitle: false,
                  title: Text('Toury',
                      style: GoogleFonts.anton(
                        textStyle: TextStyle(
                          color: kPrimaryColor,
                          letterSpacing: 2.0,
                          fontSize: 35,
                        ),
                      )),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (_, int index) {
                      return loading_data ? Padding(
                        padding: EdgeInsets.only(top: size.height * 0.35),
                        child: SpinKitFadingCube(
                        color: kPrimaryColor,
                        size: 50.0,
                      ))
                      // : isConnected ?
                          : Container(
                          child: PaidToursBody(ids: ids, names: names, locations: locations, thumbnails: thumbnails,
                          locationRoutes: locationRoutes, finalPrices: finalPrices, finalCurrency: finalCurrency,
                          descriptionRoutes: descriptionRoutes, descriptionSlideshow: descriptionSlideshow, voiceOvers: voiceOvers,
                          voiceOverTitles: voiceOverTitles, voiceOverSlideshow: voiceOverSlideshow,
                          scripts: scripts, languages: languages, is_empty: is_empty, isConnected: isConnected,
                          testThumbnails: testThumbnails,
                      ));
                    },
                    childCount: 1,)
              ),
            ],
          )


        // Center(
        //         child: Column(
        //           children: [
        //             Text("Not Connected To The Internet"),
        //             FlatButton(
        //                 onPressed: () => CheckConnection(),
        //                 child: Text("Try Again"))
        //           ],
        //     ))
      ),
      onRefresh: refreshList,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
