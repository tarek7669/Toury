import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Components/bottomNavigationBar.dart';
import 'package:project_toury/Pages/MuseumList/components/body.dart';
import 'package:project_toury/Pages/NoConnection/NC_homeList.dart';

import '../../../constants.dart';

class PaidToursBody extends StatelessWidget {
  List<String> ids;
  List<String> names;
  List<String> locations;
  List<String> thumbnails;
  List<File> testThumbnails;
  List<String> descriptionRoutes;
  List<String> locationRoutes;
  // List<double> internationalPrices;
  // List<double> egyptianPrices;
  List<dynamic> finalPrices;
  dynamic finalCurrency;

  List<String> descriptionSlideshow;
  List<String> voiceOvers;
  List<String> voiceOverTitles;
  List<String> voiceOverSlideshow;
  List<String> scripts;
  List<String> languages;

  bool is_empty;
  bool isConnected;

  PaidToursBody({
    Key? key,
    required this.ids,
    required this.names,
    required this.locations,
    required this.thumbnails,
    required this.testThumbnails,
    required this.descriptionRoutes,
    required this.locationRoutes,
    // required this.internationalPrices,
    // required this.egyptianPrices,
    required this.finalPrices,
    required this.finalCurrency,

    required this.descriptionSlideshow,
    required this.voiceOvers,
    required this.voiceOverTitles,
    required this.voiceOverSlideshow,
    required this.scripts,
    required this.languages,

    required this.is_empty,
    required this.isConnected,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isConnected ? is_empty ? Center(child: Container(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("It's Lonely Here", style: TextStyle(fontSize: 26) ),
        FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBar()));
          },
          child: Text("Add Some Tours"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: kPrimaryColor,)
          ),
        )
      ],
    )))
      : SingleChildScrollView(
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
                        CupertinoIcons.location_circle,
                        color: kSecondaryColor,
                        size: 45,
                      ),
                      Text(
                        'Saved Tours',
                        style: TextStyle(
                          fontSize: 40,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Time To Start Our Journey',
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
            descriptionRouteList: descriptionRoutes, locationRouteList: locationRoutes,
            finalPriceList: finalPrices, finalCurrency: finalCurrency,
            descriptionSlideshowList: descriptionSlideshow, voiceOversList: voiceOvers, voiceOverTitlesList: voiceOverTitles,
            voiceOverSlideshowList: voiceOverSlideshow, scriptsList: scripts, languagesList: languages,
          ),
          SizedBox(height: 25,),
        ],
      ),
    )
    //NOT CONNECTED
      : SingleChildScrollView(
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
                        CupertinoIcons.location_circle,
                        color: kSecondaryColor,
                        size: 45,
                      ),
                      Text(
                        'Saved Tours',
                        style: TextStyle(
                          fontSize: 40,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Time To Start Our Journey',
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
          offlineHomeList(idList: ids, nameList: names, thumbnailList: thumbnails, locationList: locations,
            descriptionRouteList: descriptionRoutes, locationRouteList: locationRoutes,
            finalPriceList: finalPrices, finalCurrency: finalCurrency,
            descriptionSlideshowList: descriptionSlideshow, voiceOversList: voiceOvers, voiceOverTitlesList: voiceOverTitles,
            voiceOverSlideshowList: voiceOverSlideshow, scriptsList: scripts, languagesList: languages, isConnected: isConnected,
              testThumbnails: testThumbnails,
          ),
          SizedBox(height: 25,),
        ],
      ),
    )
    ;
  }
}
