// import 'package:flutter/material.dart';
//
// import 'museumDetail.dart';
//
// class midProcess extends StatefulWidget {
//   final String idHolder;
//   final String nameHolder;
//   final String locationHolder;
//   final String thumbnailHolder;
//   final String locationRouteHolder;
//   final int internationalPriceHolder;
//   final int egyptianPriceHolder;
//
//   final List<String> descriptionRouteHolder;
//   final List<String> descriptionSlideshowHolder;
//   final List<String> voiceOversHolder;
//   final List<String> voiceOverTitlesHolder;
//   final List<String> voiceOverSlideshowHolder;
//   final List<String> scriptsHolder;
//   final List<String> languagesHolder;
//
//   final bool isBought;
//   final String defaultLanguage;
//   final String defaultDescription;
//   final int selectedLanguage;
//
//   const midProcess({
//     Key? key,
//     required this.idHolder,
//     required this.nameHolder,
//     required this.locationHolder,
//     required this.thumbnailHolder,
//     required this.locationRouteHolder,
//     required this.internationalPriceHolder,
//     required this.egyptianPriceHolder,
//
//     required this.descriptionRouteHolder,
//     required this.descriptionSlideshowHolder,
//     required this.voiceOversHolder,
//     required this.voiceOverTitlesHolder,
//     required this.voiceOverSlideshowHolder,
//     required this.scriptsHolder,
//     required this.languagesHolder,
//
//     required this.isBought,
//     required this.defaultLanguage,
//     required this.defaultDescription,
//     required this.selectedLanguage,
//   }) : super(key: key);
//
//   @override
//   _midProcessState createState() => _midProcessState(
//     idHolder,nameHolder,locationHolder,thumbnailHolder,descriptionRouteHolder,locationRouteHolder,internationalPriceHolder,egyptianPriceHolder,
//     descriptionSlideshowHolder,voiceOversHolder,voiceOverTitlesHolder,voiceOverSlideshowHolder,scriptsHolder,languagesHolder,
//     isBought, defaultLanguage, defaultDescription, selectedLanguage,
//   );
// }
//
// class _midProcessState extends State<midProcess> {
//   String idHolder; String nameHolder;
//   String locationHolder; String thumbnailHolder;
//   List<String> descriptionRouteHolder; String locationRouteHolder;
//   int internationalPriceHolder; int egyptianPriceHolder;
//   List<String> descriptionSlideshowHolder; List<String> voiceOversHolder;
//   List<String> voiceOverTitlesHolder; List<String> voiceOverSlideshowHolder;
//   List<String> scriptsHolder; List<String> languagesHolder;
//
//   bool isBought; String defaultLanguage; String defaultDescription; int selectedLanguage;
//
//   _midProcessState(this.idHolder, this.nameHolder,
//       this.locationHolder, this.thumbnailHolder,
//       this.descriptionRouteHolder, this.locationRouteHolder,
//       this.internationalPriceHolder, this.egyptianPriceHolder,
//       this.descriptionSlideshowHolder, this.voiceOversHolder,
//       this.voiceOverTitlesHolder, this.voiceOverSlideshowHolder,
//       this.scriptsHolder, this.languagesHolder,
//       this.isBought, this.defaultLanguage, this.defaultDescription, this.selectedLanguage,);
//
//   @override
//   Widget build(BuildContext context) {
//     return museumDetail(idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
//       thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
//       internationalPriceHolder: internationalPriceHolder, egyptianPriceHolder: egyptianPriceHolder, descriptionSlideshowHolder: descriptionSlideshowHolder,
//       voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
//       scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
//       isBought: isBought, /*finalPrice: finalPrice, finalCurrency: finalCurrency*/
//     );
//   }
// }
