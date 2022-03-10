// import 'dart:html';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_toury/Pages/VoiceOver/VoiceOver.dart';
import 'package:project_toury/Pages/testPayment/testPayments.dart';
import '../../constants.dart';
import 'initialSetup.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:dio/dio.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:banner_carousel/banner_carousel.dart';

class museumDetail extends StatefulWidget {
  final String idHolder;
  final String nameHolder;
  final String locationHolder;
  final String thumbnailHolder;
  final String locationRouteHolder;
  // final double internationalPriceHolder;
  // final double egyptianPriceHolder;
  final dynamic finalPriceHolder;
  final dynamic finalCurrency;
  final String  defaultLanguage;
  final String defaultDescription;
  final int selectedLanguage;

  final List<String> descriptionRouteHolder;
  final List<String> descriptionSlideshowHolder;
  final List<String> voiceOversHolder;
  final List<String> voiceOverTitlesHolder;
  final List<String> voiceOverSlideshowHolder;
  final List<String> scriptsHolder;
  final List<String> languagesHolder;

  museumDetail({
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
  _museumDetailState createState() => _museumDetailState(
  idHolder,nameHolder,locationHolder,thumbnailHolder,descriptionRouteHolder,locationRouteHolder,finalPriceHolder, finalCurrency,
    descriptionSlideshowHolder,voiceOversHolder,voiceOverTitlesHolder,voiceOverSlideshowHolder,scriptsHolder,languagesHolder,
      defaultLanguage, defaultDescription, selectedLanguage,
  );
}

class _museumDetailState extends State<museumDetail>
    with TickerProviderStateMixin {

  String idHolder; String nameHolder;
  String locationHolder; String thumbnailHolder;
  List<String> descriptionRouteHolder; String locationRouteHolder;
  // double internationalPriceHolder; double egyptianPriceHolder;
  dynamic finalPriceHolder;
  dynamic finalCurrency;
  String defaultLanguage; String defaultDescription; int selectedLanguage;
  List<String> descriptionSlideshowHolder; List<String> voiceOversHolder;
  List<String> voiceOverTitlesHolder; List<String> voiceOverSlideshowHolder;
  List<String> scriptsHolder; List<String> languagesHolder;

  _museumDetailState(this.idHolder, this.nameHolder,
      this.locationHolder, this.thumbnailHolder,
      this.descriptionRouteHolder, this.locationRouteHolder,
      // this.internationalPriceHolder, this.egyptianPriceHolder,
      this.finalPriceHolder, this.finalCurrency,
      this.descriptionSlideshowHolder, this.voiceOversHolder,
      this.voiceOverTitlesHolder, this.voiceOverSlideshowHolder,
      this.scriptsHolder, this.languagesHolder,
      this.defaultLanguage, this.defaultDescription, this.selectedLanguage);

  bool isBought = false;
  bool isDownloaded = false;
  bool loading = false;
  bool like_loading = false;
  bool isLiked = false;

  dynamic finalIso;
  List<String> paidTours = [];
  // Color container_color = Color(0x0000ffff);

  // ScrollController _scrollViewController = new ScrollController();
  //
  // void changeColor(){
  //   if((_scrollViewController.offset == 0) && (container_color != Colors.red[400])){
  //     setState(() {
  //       container_color = Colors.transparent;
  //     });
  //   }else if((_scrollViewController.offset <= 70) && (container_color != Color.fromRGBO(66,165,245 ,0.4))){
  //     setState(() {
  //       container_color = Color.fromRGBO(66,165,245 ,0.4);
  //     });
  //   }else if((_scrollViewController.offset <= 100) && (_scrollViewController.offset > 40)){
  //     var opacity = _scrollViewController.offset/100;
  //     setState(() {
  //       container_color = Color.fromRGBO(66,165,245 ,opacity);
  //     });
  //   }
  // }


  _fetchDownloaded() async{
    await FirebaseFirestore.instance.collection('downloadedTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
      List.from(value.data()!['downloadedTours']).forEach((element) {
        String data = element;

        if(idHolder == element)
          setState(() {
            isDownloaded = true;
          });
      });
    });
  }
  _fetchPaidTours() async{
    paidTours = [];

    await FirebaseFirestore.instance.collection('paidTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) async{
      List.from(value.data()!['paidTours']).forEach((element) {
        String data = element;
        paidTours.add(data);
      });
      debugPrint("***** paid Tours -> museumDetail -> _fetchPaidTours() *****");
      for(int i = 0; i < paidTours.length; i++) {
        print(paidTours[i]);
      }
      // WHETHER THE USER BOUGHT THE TOUR
      for(int i = 0; i < paidTours.length; i++){
        if(idHolder == paidTours[i]){
          setState(() {
            isBought = true;
          });
          break;
        } else {
          setState(() {
            isBought = false;
          });
        }
      }


      // //WHETHER THE USER BOUGHT THE TOUR
      // for(int i = 0; i < paidTours.length; i++){
      //   if(idHolder == paidTours[i]){
      //     setState(() {
      //       boughtTour = true;
      //     });
      //     break;
      //   } else {
      //     setState(() {
      //       boughtTour = false;
      //     });
      //   }
      // }
    });
    // await FirebaseFirestore.instance.collection('users')
    // .doc(FirebaseAuth.instance.currentUser!.uid)
    // .get().then((ds) {
    //   finalIso = ds['ISOCode'];
    //
    //   if(finalIso == "EG"){
    //     setState(() {
    //       finalPrice = egyptianPriceHolder;
    //       finalCurrency = 'EGP';
    //     });
    //   } else {
    //     setState(() {
    //       finalPrice = internationalPriceHolder;
    //       finalCurrency = '\$';
    //     });
    //   }
    //
    //   print(finalIso);
    // }).catchError((e) {
    //   print(e);
    // });
  }
  // _fetchCurrency() async{
  //   // isBought = false;
  //
  //   await FirebaseFirestore.instance.collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get().then((ds) {
  //     finalIso = ds['ISOCode'];
  //
  //     if(finalIso == "EG"){
  //       setState(() {
  //         finalPrice = egyptianPriceHolder;
  //         finalCurrency = 'EGP';
  //       });
  //     } else {
  //       setState(() {
  //         finalPrice = internationalPriceHolder;
  //         finalCurrency = 'USD';
  //       });
  //     }
  //
  //     debugPrint("***** museumDetail -> _fetchCurrency() *****");
  //     print(finalIso);
  //     print(finalPrice);
  //     print(finalCurrency);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  _fetchLiked() async{
    await FirebaseFirestore.instance.collection('likedTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
      List.from(value.data()!['likedTours']).forEach((element) {
        String data = element;

        if(idHolder == element)
          setState(() {
            isLiked = true;
          });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    // _scrollViewController.addListener(changeColor);

    super.initState();
    _fetchDownloaded();
    // _fetchCurrency();
    _fetchPaidTours();
    _fetchLiked();
  }

  // double progress = 0.0;
  // final Dio dio = Dio();
  //
  // Future<bool>saveFile(String url, String sub_folder, String fileName) async{
  //   Directory directory;
  //   try{
  //     if(Platform.isAndroid) {
  //       if(await _requestPermission(Permission.storage)) {
  //         directory = (await getExternalStorageDirectory())!;
  //         print(directory.path);
  //         String newPath = "";
  //         List<String> folders = directory.path.split("/");
  //         for(int i = 1; i < folders.length; i++){
  //           String folder = folders[i];
  //           if(folder != "Android") {
  //             newPath += "/" + folder;
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = newPath+ "/Toury App/$idHolder";
  //         directory = Directory(newPath);
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       if(await _requestPermission(Permission.photos)){
  //         directory = await getTemporaryDirectory();
  //       } else {
  //         return false;
  //       }
  //     }
  //     if(!await directory.exists()){
  //       await directory.create(recursive: true);
  //     }
  //     if(await directory.exists()){
  //       File savedFile = File(directory.path+ "/$sub_folder/$fileName");
  //
  //       debugPrint("Your Saved File Path Is:  " + savedFile.path);
  //       await dio.download(url, savedFile.path,
  //           onReceiveProgress: (downloaded, totalSize) {
  //         setState(() {
  //           progress = downloaded/totalSize;
  //         });
  //       });
  //       if(Platform.isIOS){
  //         ImageGallerySaver.saveFile(savedFile.path, isReturnPathOfIOS: true);
  //       }
  //       return true;
  //     }
  //   }catch(e){
  //     debugPrint("Error in (museumDetail -> saveFile(): $e");
  //   }
  //   return false;
  // }
  //
  // Future<bool> _requestPermission(Permission permission) async{
  //   if(await permission.isGranted){
  //     return true;
  //   }
  //   else{
  //     var result = await permission.request();
  //     if(result == PermissionStatus.granted){
  //       return true;
  //     } else{
  //       return false;
  //     }
  //   }
  // }
  //
  // downloadFile(String url, String sub_folder, String fileName) async {
  //   setState(() {
  //     loading = true;
  //     progress = 0;
  //   });
  //
  //   bool downloaded = await saveFile(
  //     //   "https://firebasestorage.googleapis.com/v0/b/toury-1727-tn.appspot.com/o/VoiceOver%2FAswan%2FArabic%"
  //     //       "2FJalandhar.mp3?alt=media&token=a0adeaa5-c886-4841-b21f-a01f3692591b",
  //     // "Arabic Toury Music.mp3"
  //     url, sub_folder, fileName
  //   );
  //   if(downloaded)
  //     debugPrint("File Downloaded");
  //   else
  //     debugPrint("File Is Not Downloaded");
  //
  //   setState((){
  //     loading = false;
  //   });
  // }

  manageLikeButton(BuildContext context) async{
    setState(() {
      like_loading = true;
    });

    List<String> WantToLikeTour = [idHolder];
    isLiked ? await FirebaseFirestore.instance.collection('likedTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "likedTours": FieldValue.arrayRemove(WantToLikeTour)
    })
      : await FirebaseFirestore.instance.collection('likedTours')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "likedTours": FieldValue.arrayUnion(WantToLikeTour)
        });

    setState(() {
      like_loading = false;
      isLiked = !isLiked;
    });

  }

  // changeColor(double percent) {
  //   double value = percent / 100;
  //
  //   if(value <= 10){
  //     container_color = Colors.transparent;
  //   }else if(value <= 20){
  //     container_color = Color();
  //   }
  //
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
        return Scaffold(
          // appBar: AppBar(
          //   centerTitle: true,
          //   elevation: 5,
          //   backgroundColor: Colors.white,
          //   iconTheme: IconThemeData(color: kPrimaryColor),
          //   actions: <Widget>[
          //     // like_loading ? Padding(
          //     //   padding: const EdgeInsets.all(0.0),
          //     //   child: CircularProgressIndicator(color: kPrimaryColor, ),
          //     // )
          //     //     :
          //     isLiked ? IconButton(icon: Icon(CupertinoIcons.heart_fill, color: kPrimaryColor,), onPressed: () async{ await manageLikeButton(context); },)
          //     : IconButton(icon: Icon(CupertinoIcons.heart,), onPressed: () async{ await manageLikeButton(context); },),
          //
          //     loading ? Padding(
          //       padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
          //       child: CircularProgressIndicator(value: progress, color: kPrimaryColor, ),
          //     )
          //         : isDownloaded ? IconButton(
          //       onPressed: () async{
          //
          //         // for(int i = 0; i < voiceOversHolder.length; i++){
          //         //   await downloadFile(voiceOversHolder[i], "Voice Overs", voiceOverTitlesHolder[i] + ".mp3");
          //         // }
          //         // for(int i = 0; i < descriptionSlideshowHolder.length; i++){
          //         //   await downloadFile(descriptionSlideshowHolder[i], "Description Slideshow", "title slide show $i" + ".png");
          //         // }
          //         // await downloadFile(thumbnailHolder, "Thumbnail","thumbnail" + ".png");
          //
          //         Directory rm_directory = await Directory("/storage/emulated/0/Toury App/$idHolder");
          //         rm_directory.deleteSync(recursive: true);
          //         debugPrint("Your rm directory:  " + rm_directory.path);
          //         isDownloaded = false;
          //
          //
          //         List<String> WantToDownloadTour = [idHolder];
          //         await FirebaseFirestore.instance.collection('downloadedTours')
          //             .doc(FirebaseAuth.instance.currentUser!.uid)
          //             .update({
          //           "downloadedTours": FieldValue.arrayRemove(WantToDownloadTour),
          //         });
          //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => initialSetup(
          //           idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
          //           thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
          //           finalPriceHolder: finalPriceHolder, finalCurrency: finalCurrency, descriptionSlideshowHolder: descriptionSlideshowHolder,
          //           voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
          //           scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
          //           defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,
          //         )));
          //         ScaffoldMessenger.of(context).showSnackBar(
          //             SnackBar(content: Text('Tour Removed Successfully.')));
          //       },
          //       icon: Icon(Icons.download_done_rounded)
          //     )
          //     : IconButton(
          //       onPressed: () async{
          //
          //         for(int i = 0; i < voiceOversHolder.length; i++){
          //           await downloadFile(voiceOversHolder[i], "Voice Overs", voiceOverTitlesHolder[i] + ".mp3");
          //         }
          //         for(int i = 0; i < descriptionSlideshowHolder.length; i++){
          //           await downloadFile(descriptionSlideshowHolder[i], "Description Slideshow", "title slideshow $i" + ".png");
          //         }
          //         for(int i = 0; i < voiceOverSlideshowHolder.length; i++){
          //           await downloadFile(voiceOverSlideshowHolder[i], "Voice Over Slideshow", "Voice Slideshow $i" + ".png");
          //         }
          //         await downloadFile(thumbnailHolder, "Thumbnail","thumbnail" + ".png");
          //
          //         isDownloaded = true;
          //
          //         List<String> WantToDownloadTour = [idHolder];
          //         await FirebaseFirestore.instance.collection('downloadedTours')
          //             .doc(FirebaseAuth.instance.currentUser!.uid)
          //             .update({
          //           "downloadedTours": FieldValue.arrayUnion(WantToDownloadTour)
          //         });
          //
          //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => initialSetup(
          //           idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
          //           thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
          //           finalPriceHolder: finalPriceHolder, finalCurrency: finalCurrency, descriptionSlideshowHolder: descriptionSlideshowHolder,
          //           voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
          //           scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
          //           defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,
          //         )));
          //         ScaffoldMessenger.of(context).showSnackBar(
          //             SnackBar(content: Text('Tour Downloaded Successfully.')));
          //       },
          //       icon: Icon(Icons.download_rounded,)
          //     ),
          //   ],
          //   title: Text(
          //       nameHolder,
          //       style: TextStyle(
          //         color: kPrimaryColor,
          //       )
          //   ),
          // ),

          body: Stack(
            children: [
              CustomScrollView(
              slivers: <Widget>[
                //2
                SliverAppBar(
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: kTestColor,),
                        onPressed: () => Navigator.pop(context),
                        // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                      );
                    },
                  ),
                  actions: [
                    isLiked ? IconButton(icon: Icon(CupertinoIcons.heart_fill, color: kTestColor,), onPressed: () async{ await manageLikeButton(context); },)
                        : IconButton(icon: Icon(CupertinoIcons.heart, color: kUnselectedColor), onPressed: () async{ await manageLikeButton(context); },),
                  ],

                  pinned: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: size.height * 0.4,
                  automaticallyImplyLeading: false,
                  foregroundColor: Colors.red,


                  flexibleSpace: FlexibleSpaceBar(


                    titlePadding: EdgeInsets.fromLTRB(13.0, 3.0, 3.0, 23.0),
                    centerTitle: false,
                    title: Opacity(
                      opacity: 0.0,
                      child: Text(nameHolder, textScaleFactor: 1, /*style: TextStyle(color: kPrimaryColor),*/ )),


                    background: BannerCarousel.fullScreen(
                        banners: descriptionSlideshowHolder
                              .map((item) => BannerModel(
                          imagePath: item,
                          id: '',

                        )).toList(),
                        animation: false,
                        activeColor: kPrimaryColor,
                        height: size.height * 0.4,
                      ),
                  ),

                  // flexibleSpace: LayoutBuilder(
                  //   builder:
                  //       (BuildContext context, BoxConstraints constraints) {
                  //     // double percent =
                  //     // ((constraints.maxHeight - kToolbarHeight) *
                  //     //     100 /
                  //     //     (300 - kToolbarHeight));
                  //
                  //     double percent =
                  //     ( (constraints.maxHeight) - (kToolbarHeight)) *
                  //         100 /
                  //         (300 - kToolbarHeight);
                  //     double dx = 0;
                  //     double textOpacity = 0.0;
                  //     double container_opacity = 0.0;
                  //     // Color final_color;
                  //     // Color incremented_color = Colors.white24;
                  //     // Color container_color = Color(0x0000ffff);
                  //
                  //     debugPrint("\n\n PERCENT  is  $percent  \n\n");
                  //
                  //     if (percent <= 46){
                  //       dx = size.width * 0.15;
                  //       textOpacity = 1.0 - (percent / 93.0);
                  //       container_opacity = 1.0 - (percent / 92.0);
                  //
                  //       // changeColor(percent);
                  //       // final_color = Color.alphaBlend(container_color, incremented_color);
                  //       // container_color = final_color;
                  //
                  //       // debugPrint("\n\n Hex Color is  ${container_color.toHex()} \n\n");
                  //     }else {
                  //       dx = 100 - (percent);
                  //       textOpacity = 1.0 - (percent / 93.0);
                  //       container_opacity = 1.0 - (percent / 92.0);
                  //
                  //       // final_color = Color.alphaBlend(container_color, incremented_color);
                  //       // container_color = final_color;
                  //       // changeColor(percent);
                  //       // container_color = Colors.transparent;
                  //     }
                  //
                  //     return Stack(
                  //       children: <Widget>[
                  //         BannerCarousel.fullScreen(
                  //           banners: descriptionSlideshowHolder
                  //               .map((item) => BannerModel(
                  //             imagePath: item,
                  //             id: '',
                  //           )).toList(),
                  //           animation: true,
                  //           activeColor: kPrimaryColor,
                  //           height: size.height * 0.4,
                  //
                  //         ),
                  //         // Opacity(
                  //         //   opacity: container_opacity,
                  //         //   child: Container(
                  //         //     color: Colors.white,
                  //         //   ),
                  //         // ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               /*top: kToolbarHeight / 4,*/ left: 0.0, top: 17.0),
                  //           child: Transform.translate(
                  //             child: Opacity(
                  //               opacity: textOpacity,
                  //               child: Text(
                  //                 nameHolder,
                  //                 style: TextStyle(
                  //                   fontSize: 20,
                  //                   // color: kPrimaryColor,
                  //                 ),
                  //               ),
                  //             ),
                  //             offset: Offset(
                  //                 dx, constraints.maxHeight - kToolbarHeight),
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),

                ),
                //3
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //         (_, int index) {
                //       return ListTile(
                //         leading: Container(
                //             padding: EdgeInsets.all(8),
                //             width: 100,
                //             child: Placeholder()),
                //         title: Text('Place ${index + 1}', textScaleFactor: 2),
                //       );
                //     },
                //     childCount: 20,
                //   ),
                // ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (_, int index) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameHolder,
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                      DropdownButton<String>(
                                        underline: Container(),
                                        value: defaultLanguage,
                                        items: languagesHolder
                                        // ["English", "Arabic"]
                                            .map<DropdownMenuItem<String>>((String e) {
                                          return DropdownMenuItem<String>(
                                            child: Text(e, style: TextStyle(fontWeight: FontWeight.bold)),
                                            value: e,
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            defaultLanguage = value!;
                                            print(defaultLanguage);
                                            selectedLanguage = languagesHolder.indexOf(value);
                                            defaultDescription = descriptionRouteHolder[selectedLanguage];
                                          });
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => initialSetup(
                                              idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
                                              thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
                                              finalPriceHolder: finalPriceHolder,finalCurrency: finalCurrency,
                                              descriptionSlideshowHolder: descriptionSlideshowHolder, voiceOversHolder: voiceOversHolder,
                                              voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder, scriptsHolder: scriptsHolder,
                                              languagesHolder: languagesHolder, defaultLanguage: value!,  defaultDescription: defaultDescription, selectedLanguage: selectedLanguage
                                          )));
                                        },
                                      ),
                                    ]
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text(defaultDescription == "Select A Language Please" ? descriptionRouteHolder[0]: defaultDescription),
                            SizedBox(height: size.height * 0.08),
                          ],
                        )
                      ),
                    );
                  },
                    childCount: 1,) ,
                ),
                // isBought ? FloatingActionButton.extended(
                //   onPressed: () => Navigator.push(context,
                //       MaterialPageRoute(builder: (context) =>
                //           VoiceOver(nameHolder: nameHolder, voiceOversHolder: voiceOversHolder,
                //             voiceOverTitlesHolder: voiceOverTitlesHolder,
                //             voiceOverSlideshowHolder: voiceOverSlideshowHolder,
                //             scriptsHolder: scriptsHolder, selectedLanguage: selectedLanguage,))),
                //   icon: Icon(Icons.play_arrow_rounded),
                //   label: Text('Play'),
                //   // backgroundColor: Colors.pink,
                // )
                // : FloatingActionButton.extended(
                //     onPressed: () {
                //       Navigator.push(context, MaterialPageRoute(builder: (context) => testPayments(
                //         idHolder: idHolder, finalCurrency: finalCurrency,
                //         nameHolder : nameHolder, locationHolder: locationHolder, thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
                //         finalPriceHolder: finalPriceHolder, descriptionSlideshowHolder: descriptionSlideshowHolder,
                //         voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
                //         scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
                //         defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,
                //       )));
                //     },
                //     label: Text('Buy $finalPriceHolder $finalCurrency'),
                //     // icon: const Icon(Icons.thumb_up),
                //     // backgroundColor: Colors.pink,
                //   ),
              ],
            ),
              Positioned(
                bottom: size.height * 0.05,
                right: size.width * 0.07,
                child: isBought ? FloatingActionButton.extended(
                  isExtended: true,
                  backgroundColor: kPrimaryColor,
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          VoiceOver(nameHolder: nameHolder, voiceOversHolder: voiceOversHolder,
                            voiceOverTitlesHolder: voiceOverTitlesHolder,
                            voiceOverSlideshowHolder: voiceOverSlideshowHolder,
                            scriptsHolder: scriptsHolder, selectedLanguage: selectedLanguage,))),
                  icon: Icon(Icons.play_arrow_rounded),
                  label: Text('Play', style: TextStyle(color: Colors.white)),
                  // backgroundColor: Colors.pink,
                )
                    : FloatingActionButton.extended(
                  isExtended: true,
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => testPayments(
                      idHolder: idHolder, finalCurrency: finalCurrency,
                      nameHolder : nameHolder, locationHolder: locationHolder, thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
                      finalPriceHolder: finalPriceHolder, descriptionSlideshowHolder: descriptionSlideshowHolder,
                      voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
                      scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
                      defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,
                    )));
                  },
                  label: Text('Buy $finalPriceHolder $finalCurrency', style: TextStyle(color: Colors.white)),
                  // icon: const Icon(Icons.thumb_up),
                  // backgroundColor: Colors.pink,
                ),
              ),
          ],
        ),

          // body: SingleChildScrollView(
          //       child: Container(
          //
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Stack(
          //               children: [
          //                 Container(
          //                   // child: CarouselSlider(
          //                   //   options: CarouselOptions(
          //                   //     autoPlay: true,
          //                   //   ),
          //                   //   items: descriptionSlideshowHolder
          //                   //       .map((item) => Container(
          //                   //     color: Colors.grey,
          //                   //     child: Center(
          //                   //         child:
          //                   //         Image.network(item, fit: BoxFit.fitWidth, width: size.width)),
          //                   //   ))
          //                   //       .toList(),
          //                   // )
          //
          //                   foregroundDecoration: BoxDecoration(
          //                     color: Colors.black38,
          //                     backgroundBlendMode: BlendMode.softLight,
          //                     // gradient: LinearGradient(
          //                     //   begin: Alignment.topCenter,
          //                     //   end: Alignment.bottomCenter,
          //                     //   colors: [Colors.black38, Colors.white],
          //                     // )
          //                   ),
          //
          //                   child: BannerCarousel.fullScreen(
          //                     banners: descriptionSlideshowHolder
          //                           .map((item) => BannerModel(
          //                       imagePath: item,
          //                       id: '',
          //
          //                     )).toList(),
          //                     animation: true,
          //                     activeColor: kPrimaryColor,
          //                     height: size.height * 0.34,
          //
          //                   ),
          //
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: SafeArea(
          //                     child: IconButton(
          //                       onPressed: () => Navigator.pop(context),
          //                       icon: Icon(Icons.arrow_back_ios),
          //                       color: Colors.white,
          //                     )
          //                   ),
          //                 ),
          //
          //               ]
          //             ),
          //             SizedBox(height: 10,),
          //
          //             Padding(
          //               padding: EdgeInsets.all(18),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     nameHolder,
          //                     style: TextStyle(
          //                       color: kSecondaryColor,
          //                       fontSize: 30,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text(
          //                         'Description',
          //                         style: TextStyle(
          //                           letterSpacing: 2.0,
          //                           fontSize: 20,
          //                         ),
          //                       ),
          //                       Row(
          //                           mainAxisAlignment: MainAxisAlignment.end,
          //                           children:[
          //                             DropdownButton<String>(
          //                               underline: Container(),
          //                               value: defaultLanguage,
          //                               items: languagesHolder
          //                               // ["English", "Arabic"]
          //                                   .map<DropdownMenuItem<String>>((String e) {
          //                                 return DropdownMenuItem<String>(
          //                                   child: Text(e, style: TextStyle(fontWeight: FontWeight.bold)),
          //                                   value: e,
          //                                 );
          //                               }).toList(),
          //                               onChanged: (String? value) {
          //                                 setState(() {
          //                                   defaultLanguage = value!;
          //                                   print(defaultLanguage);
          //                                   selectedLanguage = languagesHolder.indexOf(value);
          //                                   defaultDescription = descriptionRouteHolder[selectedLanguage] + descriptionRouteHolder[selectedLanguage];
          //                                 });
          //                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => initialSetup(
          //                                     idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
          //                                     thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
          //                                     finalPriceHolder: finalPriceHolder,finalCurrency: finalCurrency,
          //                                     descriptionSlideshowHolder: descriptionSlideshowHolder, voiceOversHolder: voiceOversHolder,
          //                                     voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder, scriptsHolder: scriptsHolder,
          //                                     languagesHolder: languagesHolder, defaultLanguage: value!,  defaultDescription: defaultDescription, selectedLanguage: selectedLanguage
          //                                 )));
          //                               },
          //                             ),
          //                           ]
          //                       )
          //                     ],
          //                   ),
          //                   SizedBox(height: 10,),
          //                   Text(defaultDescription == "Select A Language Please" ? descriptionRouteHolder[0]: defaultDescription),
          //                 ],
          //               )
          //             ),
          //
          //
          //             SizedBox(height: 20,),
          //             Center(
          //               child: isBought ? FlatButton.icon(
          //                 minWidth: 200,
          //                 height: 50,
          //                 textColor: Colors.white,
          //                 color: kPrimaryColor,
          //                 onPressed: () => Navigator.push(context,
          //                     MaterialPageRoute(builder: (context) =>
          //                         VoiceOver(nameHolder: nameHolder, voiceOversHolder: voiceOversHolder,
          //                           voiceOverTitlesHolder: voiceOverTitlesHolder,
          //                           voiceOverSlideshowHolder: voiceOverSlideshowHolder,
          //                           scriptsHolder: scriptsHolder, selectedLanguage: selectedLanguage,))),
          //                 icon: Icon(Icons.play_arrow_rounded),
          //                 label: Text('Play'),
          //               )
          //                   :
          //               FlatButton(
          //                 minWidth: 200,
          //                 height: 50,
          //                 textColor: Colors.white,
          //                 color: kPrimaryColor,
          //                 onPressed: () {
          //
          //                   // payPressed();
          //
          //                   Navigator.push(context, MaterialPageRoute(builder: (context) => testPayments(
          //                       idHolder: idHolder, finalCurrency: finalCurrency,
          //                       nameHolder : nameHolder, locationHolder: locationHolder, thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
          //                       finalPriceHolder: finalPriceHolder, descriptionSlideshowHolder: descriptionSlideshowHolder,
          //                       voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
          //                       scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
          //                       defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,
          //                   )));
          //
          //                   // await payPressed().then((value) async{
          //                   //   if(value == true) {
          //                   //     List<String> WantToPayTour = [idHolder];
          //                   //     await FirebaseFirestore.instance.collection('paidTours')
          //                   //         .doc(FirebaseAuth.instance.currentUser!.uid)
          //                   //         .update({
          //                   //       "paidTours": FieldValue.arrayUnion(WantToPayTour)
          //                   //     });
          //                   //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => initialSetup(
          //                   //         idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
          //                   //         thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
          //                   //         internationalPriceHolder: internationalPriceHolder, egyptianPriceHolder: egyptianPriceHolder, descriptionSlideshowHolder: descriptionSlideshowHolder,
          //                   //         voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
          //                   //         scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,  defaultLanguage: defaultLanguage,
          //                   //         defaultDescription: defaultDescription, selectedLanguage: selectedLanguage
          //                   //     ))).then((value) {
          //                   //       debugPrint('\n\nPayment Success\n\n');
          //                   //       ScaffoldMessenger.of(context).showSnackBar(
          //                   //           SnackBar(content: Text('Payment Completed Successfully')));
          //                   //     });
          //                   //   }
          //                   //   else{
          //                   //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => initialSetup(
          //                   //         idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
          //                   //         thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
          //                   //         internationalPriceHolder: internationalPriceHolder, egyptianPriceHolder: egyptianPriceHolder, descriptionSlideshowHolder: descriptionSlideshowHolder,
          //                   //         voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
          //                   //         scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,  defaultLanguage: defaultLanguage,
          //                   //         defaultDescription: defaultDescription, selectedLanguage: selectedLanguage
          //                   //     ))).then((value) {
          //                   //       debugPrint('\n\nPayment failed (error)\n\n');
          //                   //       ScaffoldMessenger.of(context).showSnackBar(
          //                   //           SnackBar(content: Text('An Error Occured')));
          //                   //     });
          //                   //   }
          //
          //                   // });
          //
          //
          //                 },
          //                 child:
          //                   Text(
          //                     "Buy $finalPriceHolder $finalCurrency"
          //                   ),
          //               )
          //
          //               // Align(
          //               //   alignment: Alignment.bottomCenter,
          //               //   child: FloatingActionButton.extended(
          //               //   onPressed: () {},
          //               //   label: Text("Buy 2\$"),
          //               //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //               //   isExtended: true,
          //               //   backgroundColor: kPrimaryColor,
          //               // ),)
          //               // FloatingActionButtonLocation.centerFloat,
          //             ),
          //             // )
          //           ],
          //         ),
          //       ),
          //     ),
      );
  }

  Future<PaymentSdkConfigurationDetails> generateConfig() async {
    // var billingDetails = BillingDetails("John Smith", "email@domain.com",
    //     "+97311111111", "st. 12", "ae", "dubai", "dubai", "12345");
    // var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
    //     "+97311111111", "st. 12", "ae", "dubai", "dubai", "12345");
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.VALU);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "85333",
        serverKey: "S2JNBJB9N2-J2NBLZGG2T-JGD9LRRRK2",
        clientKey: "CHKMP9-QNHP6M-Q2B9TT-TM96QK",
        cartId: "12433",
        // cartDescription: "Flowers",
        // merchantName: "Flowers Store",
        screentTitle: "Pay with Card",
        amount: 2.0,
        showBillingInfo: false,
        forceShippingInfo: false,
        currencyCode: finalCurrency,
        merchantCountryCode: "EG",
        // billingDetails: billingDetails,
        // shippingDetails: shippingDetails,
        alternativePaymentMethods: apms);

    // var theme = IOSThemeConfigurations();
    var theme = IOSThemeConfigurations();
    theme.backgroundColor = "FFF"; // Color hex value
    theme.buttonColor = "03989E";
    theme.secondaryFontColor = "03989E";
    theme.secondaryColor = "03989E";

    theme.logoImage = "assets/Logo/toury-cyan.jpeg";

    configuration.iOSThemeConfigurations = theme;

    return configuration;
  }

  Future<void> payPressed() async {
    bool result = false;
    try {
      FlutterPaytabsBridge.startCardPayment(await generateConfig(), (event) {
        setState(() {
          if (event["status"] == "success") {
            // Handle transaction details here.
            debugPrint('\n\nPayment Success\n\n');
            var transactionDetails = event["data"];
            print("Transaction Details =>" + transactionDetails);
            result = true;
          } else if (event["status"] == "error") {
            // Handle error here.
            debugPrint('\n\nPayment failed (error)\n\n');
          } else if (event["status"] == "event") {
            // Handle events here.
            debugPrint('Payment (event)');
          }
        });
      });
      // return result;
    }catch (e){
      debugPrint('catch error --> $e');
      // return result;
    }
  }

  // _buildTrackBottomNavigationMenu() async{
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Icon(
  //         // Icons.view_headline_sharp,
  //         Icons.space_bar_sharp,
  //         size: 25,
  //       ),
  //       Text('Pick One To Proceed'),
  //       SizedBox(height: 16),
  //       TextButton(
  //         onPressed: () async{
  //           // payPressed();
  //           // Navigator.push(context, MaterialPageRoute(builder: (context) => testPayments());
  //           await testPayments().payPressed();
  //         },
  //         child: Text('Pay with Card'),
  //       ),
  //       SizedBox(height: 16),
  //       TextButton(
  //         onPressed: () async{
  //           // apmsPayPressed();
  //           // Navigator.push(context, MaterialPageRoute(builder: (context) => testPayments()));
  //           await testPayments().apmsPayPressed();
  //         },
  //         child: Text('Pay with Alternative payment methods'),
  //       ),
  //       SizedBox(height: 16),
  //       // applePayButton(),
  //       // samsungPayButton(),
  //     ],
  //   );
  // }

  // Future<void> _onTrackPressed() async{
  //   showModalBottomSheet(context: context, builder: (context) {
  //     return SingleChildScrollView(
  //       child: Container(
  //           height: 200,
  //           color: Color(0xFF737373),
  //           child: Container(
  //             child: _buildTrackBottomNavigationMenu(),
  //             decoration: BoxDecoration(
  //                 color: Theme.of(context).canvasColor,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: const Radius.circular(10),
  //                   topRight: const Radius.circular(10),
  //                 )
  //             ),
  //           )
  //       ),
  //     );
  //   });
  // }

}