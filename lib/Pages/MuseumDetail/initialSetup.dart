import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_toury/Components/SpinKit.dart';
import '../../constants.dart';
import 'museumDetail.dart';

class initialSetup extends StatefulWidget {
  final String idHolder;
  final String nameHolder;
  final String locationHolder;
  final String thumbnailHolder;
  final String locationRouteHolder;
  // final double internationalPriceHolder;
  // final double egyptianPriceHolder;
  final dynamic finalPriceHolder;
  final dynamic finalCurrency;
  final String defaultLanguage;
  final String defaultDescription;
  final int selectedLanguage;

  final List<String> descriptionRouteHolder;
  final List<String> descriptionSlideshowHolder;
  final List<String> voiceOversHolder;
  final List<String> voiceOverTitlesHolder;
  final List<String> voiceOverSlideshowHolder;
  final List<String> scriptsHolder;
  final List<String> languagesHolder;


  const initialSetup({
    Key? key,
    required this.idHolder,
    required this.nameHolder,
    required this.locationHolder,
    required this.thumbnailHolder,
    required this.locationRouteHolder,
    // required this.internationalPriceHolder,
    // required this.egyptianPriceHolder,
    required this.finalPriceHolder,
    required this.finalCurrency,
    required this.defaultLanguage,
    required this.defaultDescription,
    required this.selectedLanguage,

    required this.descriptionRouteHolder,
    required this.descriptionSlideshowHolder,
    required this.voiceOversHolder,
    required this.voiceOverTitlesHolder,
    required this.voiceOverSlideshowHolder,
    required this.scriptsHolder,
    required this.languagesHolder,
  }) : super(key: key);

  @override
  _initialSetupState createState() => _initialSetupState(
    idHolder,nameHolder,locationHolder,thumbnailHolder,descriptionRouteHolder,locationRouteHolder,finalPriceHolder,finalCurrency,
    descriptionSlideshowHolder,voiceOversHolder,voiceOverTitlesHolder,voiceOverSlideshowHolder,scriptsHolder,languagesHolder,
      defaultLanguage, defaultDescription, selectedLanguage,
  );
}

class _initialSetupState extends State<initialSetup> {
  String idHolder;
  String nameHolder;
  String locationHolder;
  String thumbnailHolder;
  List<String> descriptionRouteHolder;
  String locationRouteHolder;
  // double internationalPriceHolder;
  // double egyptianPriceHolder;
  dynamic finalPriceHolder;
  dynamic finalCurrency;
  String defaultLanguage;
  String defaultDescription;
  int selectedLanguage;
  List<String> descriptionSlideshowHolder;
  List<String> voiceOversHolder;
  List<String> voiceOverTitlesHolder;
  List<String> voiceOverSlideshowHolder;
  List<String> scriptsHolder;
  List<String> languagesHolder;


  _initialSetupState(this.idHolder, this.nameHolder,
      this.locationHolder, this.thumbnailHolder,
      this.descriptionRouteHolder, this.locationRouteHolder,
      // this.internationalPriceHolder, this.egyptianPriceHolder,
      this.finalPriceHolder, this.finalCurrency,
      this.descriptionSlideshowHolder, this.voiceOversHolder,
      this.voiceOverTitlesHolder, this.voiceOverSlideshowHolder,
      this.scriptsHolder, this.languagesHolder,
      this.defaultLanguage, this.defaultDescription, this.selectedLanguage);


  List<String> paidTours = [];
  bool isBought = false;

  @override
  Widget build(BuildContext context) {
    _fetchData() async{
      //RESET LISTS
      setState(() {
        descriptionRouteHolder = [];
        descriptionSlideshowHolder = [];
        voiceOversHolder = [];
        voiceOverTitlesHolder = [];
        voiceOverSlideshowHolder = [];
        scriptsHolder = [];
        languagesHolder = [];
      });

//GETTING DESCRIPTIONS DATA
      await FirebaseFirestore.instance.collection('tours')
          .doc(idHolder)
          .get().then((value) {
        List.from(value.data()!['DescriptionRoute']).forEach((element) {
          String data = element;

          descriptionRouteHolder.add(data);
        });
      });

      for(int i = 0; i < descriptionRouteHolder.length; i++){
        print(descriptionRouteHolder[i]);
      }
      print('length of Description Route (initialSetup -> _fetchData()) ' + (descriptionRouteHolder.length).toString());

//GETTING DESCRIPTION SLIDESHOW DATA
      await FirebaseFirestore.instance.collection('tours')
          .doc(idHolder)
          .get().then((value) {
        List.from(value.data()!['DescriptionSlideShow']).forEach((element) {
          String data = element;

          descriptionSlideshowHolder.add(data);
        });
      });

      for(int i = 0; i < descriptionSlideshowHolder.length; i++){
        print(descriptionSlideshowHolder[i]);
      }
      print('length of Description SlideShow (initialSetup -> _fetchData())' + (descriptionSlideshowHolder.length).toString());

//GETTING VOICE OVERS DATA
      await FirebaseFirestore.instance.collection('tours')
          .doc(idHolder).collection('VoiceOvers').doc(idHolder)
          .get().then((value) {
        List.from(value.data()![defaultLanguage]).forEach((element) {
          String data = element;
          voiceOversHolder.add(data);
        });
      });

      print('length of Voice Overs  (initialSetup -> _fetchData())' + (voiceOversHolder.length).toString());

//GETTING VOICE OVERS TITLES DATA
      await FirebaseFirestore.instance.collection('tours')
          .doc(idHolder).collection('VoiceOverTitle').doc(idHolder)
          .get().then((value) {
        List.from(value.data()![defaultLanguage]).forEach((element) {
          String data = element;

          voiceOverTitlesHolder.add(data);
        });
      });

      for(int i = 0; i < voiceOverTitlesHolder.length; i++){
        print(voiceOverTitlesHolder[i]);
      }
      print('length of Voice Overs Titles (initialSetup -> _fetchData())' + (voiceOverTitlesHolder.length).toString());

//GETTING VOICE OVERS SLIDE SHOW DATA
      await FirebaseFirestore.instance.collection('tours')
          .doc(idHolder)
          .get().then((value) {
        List.from(value.data()!['VoiceSlideShow']).forEach((element) {
          String data = element;

          voiceOverSlideshowHolder.add(data);
        });
      });

      for(int i = 0; i < voiceOverSlideshowHolder.length; i++){
        print(voiceOverSlideshowHolder[i]);
      }
      print('length of Voice Overs Titles (initialSetup -> _fetchData())' + (voiceOverSlideshowHolder.length).toString());

//GETTING SCRIPTS DATA
      await FirebaseFirestore.instance.collection('tours')
          .doc(idHolder).collection('Scripts').doc(idHolder)
          .get().then((value) {
        List.from(value.data()![defaultLanguage]).forEach((element) {
          String data = element;

          scriptsHolder.add(data);
        });
      });

      for(int i = 0; i < scriptsHolder.length; i++){
        print(scriptsHolder[i]);
      }
      print('length of Description SlideShow (initialSetup -> _fetchData())' + (scriptsHolder.length).toString());


//GETTING LANGUAGES DATA
      await FirebaseFirestore.instance.collection('tours')
          .doc(idHolder)
          .get().then((value) {
        List.from(value.data()!['AvailableLanguage']).forEach((element) {
          String data = element;

          languagesHolder.add(data);
        });
      });

      for(int i = 0; i < languagesHolder.length; i++){
        print(languagesHolder[i]);
      }
      print('length of Description SlideShow (initialSetup -> _fetchData())' + (languagesHolder.length).toString());

    }

    return Scaffold(
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done)
            return Center(child: DoubleBounce());
              return museumDetail(idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
                thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
                finalPriceHolder: finalPriceHolder, finalCurrency: finalCurrency, descriptionSlideshowHolder: descriptionSlideshowHolder,
                voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder,
                voiceOverSlideshowHolder: voiceOverSlideshowHolder, scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
                defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,
                // isBought: isBought, /*finalPrice: finalPrice, finalCurrency: finalCurrency,*/
              );
            }
          )
        );
        }
  }
