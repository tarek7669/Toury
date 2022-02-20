import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Login/login.dart';
import 'package:project_toury/Pages/MuseumDetail/initialSetup.dart';
import 'package:project_toury/Services/auth_services.dart';
import 'package:project_toury/constants.dart';
import 'package:provider/provider.dart';
import 'Home/museumCard.dart';
import '../../MuseumDetail/museumDetail.dart';
import 'package:page_transition/page_transition.dart';

class Body extends StatelessWidget {
  List<String> ids;
  List<String> names;
  List<String> locations;
  List<String> thumbnails;
  List<String> locationRoutes;
  // List<double> internationalPrices;
  // List<double> egyptianPrices;
  List<dynamic> finalPrices;
  dynamic finalCurrency;

  List<String> descriptionRoutes;
  List<String> descriptionSlideshow;
  List<String> voiceOvers;
  List<String> voiceOverTitles;
  List<String> voiceOverSlideshow;
  List<String> scripts;
  List<String> languages;

  Body({
    Key? key,
    required this.ids,
    required this.names,
    required this.locations,
    required this.thumbnails,
    required this.locationRoutes,
    // required this.internationalPrices,
    // required this.egyptianPrices,
    required this.finalPrices,
    required this.finalCurrency,

    required this.descriptionRoutes,
    required this.descriptionSlideshow,
    required this.voiceOvers,
    required this.voiceOverTitles,
    required this.voiceOverSlideshow,
    required this.scripts,
    required this.languages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.compass,
                          color: kSecondaryColor,
                          size: 25,
                        ),
                        Text(
                          'Discover',
                          style: TextStyle(
                            fontSize: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'There Is Always Something New',
                      style: TextStyle(
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            // ),
          ),
          homeList(idList: ids, nameList: names, thumbnailList: thumbnails, locationList: locations,
              descriptionRouteList: descriptionRoutes, locationRouteList: locationRoutes, finalPriceList: finalPrices,
            finalCurrency: finalCurrency,
            descriptionSlideshowList: descriptionSlideshow, voiceOversList: voiceOvers, voiceOverTitlesList: voiceOverTitles,
            voiceOverSlideshowList: voiceOverSlideshow, scriptsList: scripts, languagesList: languages,
          ),
          SizedBox(height: 25,),
        ],
      ),
    );
  }
}

class homeList extends StatelessWidget {
  List<String> idList;
  List<String> nameList;
  List<String> locationList;
  List<String> thumbnailList;
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

  homeList({
    Key? key,
    required this.idList,
    required this.nameList,
    required this.locationList,
    required this.thumbnailList,
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
                    isConnected: true,
                    testThumbnails: File(""),

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



