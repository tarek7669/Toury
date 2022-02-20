import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Login/login.dart';
import 'package:project_toury/Pages/MuseumDetail/initialSetup.dart';
import 'package:project_toury/Pages/MuseumList/components/Home/museumCard.dart';
import 'package:project_toury/Services/auth_services.dart';
import 'package:project_toury/constants.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class offlineHomeList extends StatelessWidget {
  List<String> idList;
  List<String> nameList;
  List<String> locationList;
  List<String> thumbnailList;
  List<File> testThumbnails;
  List<String> locationRouteList;
  // List<double> internationalPriceList;
  // List<double> egyptianPriceList;
  List<dynamic> finalPriceList;
  dynamic finalCurrency;

  List<String> descriptionRouteList;
  List<String> descriptionSlideshowList;
  List<String> voiceOversList;
  List<String> voiceOverTitlesList;
  List<String> voiceOverSlideshowList;
  List<String> scriptsList;
  List<String> languagesList;

  bool isConnected;

  offlineHomeList({
    Key? key,
    required this.idList,
    required this.nameList,
    required this.locationList,
    required this.thumbnailList,
    required this.testThumbnails,
    required this.locationRouteList,
    // required this.internationalPriceList,
    // required this.egyptianPriceList,
    required this.finalPriceList,
    required this.finalCurrency,

    required this.descriptionRouteList,
    required this.descriptionSlideshowList,
    required this.voiceOversList,
    required this.voiceOverTitlesList,
    required this.voiceOverSlideshowList,
    required this.scriptsList,
    required this.languagesList,

    required this.isConnected,
  }) : super(key: key);


  getItemAndNavigate(String idItem, String nameItem, String locationItem, String thumbnailItem,
      String locationRouteItem, dynamic finalPriceList, dynamic finalCurrency, BuildContext context){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => initialSetup(idHolder: idItem, nameHolder : nameItem, locationHolder: locationItem,
    //           thumbnailHolder: thumbnailItem, descriptionRouteHolder: descriptionRouteList, locationRouteHolder: locationRouteItem,
    //           finalPriceHolder: finalPriceList, finalCurrency: finalCurrency,
    //           descriptionSlideshowHolder: descriptionSlideshowList, voiceOversHolder: voiceOversList,
    //           voiceOverTitlesHolder: voiceOverTitlesList, voiceOverSlideshowHolder: voiceOverSlideshowList, scriptsHolder: scriptsList,
    //           languagesHolder: languagesList,
    //           defaultLanguage: "English", defaultDescription: "Select A Language Please", selectedLanguage: 0,
    //         )
    //     )
    // );
    Navigator.push(
        context,
        PageTransition(type: PageTransitionType.bottomToTop,
            child: initialSetup(idHolder: idItem, nameHolder : nameItem, locationHolder: locationItem,
              thumbnailHolder: thumbnailItem, descriptionRouteHolder: descriptionRouteList, locationRouteHolder: locationRouteItem,
              finalPriceHolder: finalPriceList, finalCurrency: finalCurrency,
              descriptionSlideshowHolder: descriptionSlideshowList, voiceOversHolder: voiceOversList,
              voiceOverTitlesHolder: voiceOverTitlesList, voiceOverSlideshowHolder: voiceOverSlideshowList, scriptsHolder: scriptsList,
              languagesHolder: languagesList,
              defaultLanguage: "English", defaultDescription: "Select A Language Please", selectedLanguage: 0,
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: idList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: GestureDetector(
                child: MuseumCard(
                  isConnected: isConnected,
                  testThumbnails: testThumbnails[index],

                  Id: idList[index],
                  Name: nameList[index],
                  Thumbnail: thumbnailList[index],
                  subtitle: locationList[index],
                  locationRoute: locationRouteList[index],
                  // internationalPrice: internationalPriceList[index],
                  // egyptianPrice: egyptianPriceList[index],
                  finalPrice: finalPriceList[index],
                  finalCurrency: finalCurrency,
                ),
                onTap: ()=> getItemAndNavigate(idList[index], nameList[index], locationList[index], thumbnailList[index], locationRouteList[index],
                    finalPriceList[index], finalCurrency, context),
              )
          );
        }
    );
  }
}