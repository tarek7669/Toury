import 'dart:async';
import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:project_toury/Pages/MuseumDetail/museumDetail.dart';
import 'package:project_toury/constants.dart';

class testPayments extends StatefulWidget {
  final String idHolder;
  final String nameHolder;
  final String locationHolder;
  final String thumbnailHolder;
  final String locationRouteHolder;
  // final double internationalPriceHolder;
  // final double egyptianPriceHolder;
  final dynamic finalPriceHolder;
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

  dynamic finalCurrency;

  testPayments({Key? key,
    required this.idHolder,
    required this.nameHolder,
    required this.locationHolder,
    required this.thumbnailHolder,
    required this.locationRouteHolder,
    // required this.internationalPriceHolder,
    // required this.egyptianPriceHolder,
    required this.finalPriceHolder,
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

    required this.finalCurrency,}) : super(key: key);

  @override
  _testPaymentsState createState() => _testPaymentsState(idHolder,
    nameHolder,locationHolder,thumbnailHolder,descriptionRouteHolder,locationRouteHolder,finalPriceHolder,
    descriptionSlideshowHolder,voiceOversHolder,voiceOverTitlesHolder,voiceOverSlideshowHolder,scriptsHolder,languagesHolder,
    defaultLanguage, defaultDescription, selectedLanguage, finalCurrency,

  );

}


class _testPaymentsState extends State<testPayments> {
  final String idHolder;
  String nameHolder;
  String locationHolder; String thumbnailHolder;
  List<String> descriptionRouteHolder; String locationRouteHolder;
  // double internationalPriceHolder; double egyptianPriceHolder;
  dynamic finalPriceHolder;
  String defaultLanguage; String defaultDescription; int selectedLanguage;
  List<String> descriptionSlideshowHolder; List<String> voiceOversHolder;
  List<String> voiceOverTitlesHolder; List<String> voiceOverSlideshowHolder;
  List<String> scriptsHolder; List<String> languagesHolder;

  // dynamic finalPrice;
  dynamic finalCurrency;
  _testPaymentsState(
      this.idHolder,
      this.nameHolder,
      this.locationHolder, this.thumbnailHolder,
      this.descriptionRouteHolder, this.locationRouteHolder,
      // this.internationalPriceHolder, this.egyptianPriceHolder,
      this.finalPriceHolder,
      this.descriptionSlideshowHolder, this.voiceOversHolder,
      this.voiceOverTitlesHolder, this.voiceOverSlideshowHolder,
      this.scriptsHolder, this.languagesHolder,
      this.defaultLanguage, this.defaultDescription, this.selectedLanguage,
      // this.finalPrice,
      this.finalCurrency);

  @override
  void initState() {
    super.initState();
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
        amount: finalPriceHolder,
        showBillingInfo: false,
        forceShippingInfo: false,
        currencyCode: finalCurrency,
        merchantCountryCode: "EG",
        // billingDetails: billingDetails,
        // shippingDetails: shippingDetails,
        alternativePaymentMethods: apms);

    var theme = IOSThemeConfigurations();
    theme.backgroundColor = "0xFFF"; // Color hex value
    theme.buttonColor = "0x03989E";
    theme.secondaryFontColor = "0x03989E";
    theme.secondaryColor = "0x03989E";

    theme.logoImage = "assets/Logo/toury-cyan.jpeg";

    configuration.iOSThemeConfigurations = theme;

    return configuration;
  }

  //Standard Payment Method
  Future<void> payPressed() async {
    try{
      FlutterPaytabsBridge.startCardPayment(await generateConfig(), (event) {
        setState(() async{
          if (event["status"] == "success") {
            // Handle transaction details here.
            debugPrint('\n\nPayment Success\n\n');
            List<String> WantToPayTour = [idHolder];
            await FirebaseFirestore.instance.collection('paidTours')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "paidTours": FieldValue.arrayUnion(WantToPayTour)
            }).then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => museumDetail(
                idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
                thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
                finalPriceHolder: finalPriceHolder, finalCurrency: finalCurrency, descriptionSlideshowHolder: descriptionSlideshowHolder,
                voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
                scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
                defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,

              )));
            }).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Completed Successfully.')));
            });

            var transactionDetails = event["data"];
            print("Transaction Details =>" + transactionDetails);
          } else if (event["status"] == "error") {
            // Handle error here.
            debugPrint('\n\nPayment failed (error)\n\n');
          } else if (event["status"] == "event") {
            // Handle events here.
            debugPrint('\n\nPayment (event)\n\n');
          }
        });
      });
    }catch (e){
      debugPrint('\n\ncatch error --> $e\n\n');
    }
  }

  //APMS Payment Method
  Future<void> apmsPayPressed() async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(await generateConfig(),
            (event) {
          setState(() {
            if (event["status"] == "success") {
              // Handle transaction details here.
              debugPrint('\n\nPayment Success\n\n');
              var transactionDetails = event["data"];
              print("Transaction Details =>" + transactionDetails);
            } else if (event["status"] == "error") {
              // Handle error here.
              debugPrint('\n\nPayment failed (error)\n\n');
            } else if (event["status"] == "event") {
              // Handle events here.
              debugPrint('\n\nPayment (event)\n\n');
            }
          });
        });
  }

  //Apple Pay Payment Method
  Future<void> applePayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "85333",
        serverKey: "S2JNBJB9N2-J2NBLZGG2T-JGD9LRRRK2",
        clientKey: "CHKMP9-QNHP6M-Q2B9TT-TM96QK",
        cartId: "12433",
        // cartDescription: "Flowers",
        // merchantName: "Flowers Store",
        amount: finalPriceHolder,
        currencyCode: finalCurrency,
        merchantCountryCode: "EG",
        merchantApplePayIndentifier: "merchant.com.bunldeId",
        simplifyApplePayValidation: true);
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
      setState(() async{
        if (event["status"] == "success") {
          // Handle transaction details here.
          debugPrint('\n\nPayment Success\n\n');
          List<String> WantToPayTour = [idHolder];
          await FirebaseFirestore.instance.collection('paidTours')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "paidTours": FieldValue.arrayUnion(WantToPayTour)
          }).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => museumDetail(
              idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
              thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
              finalPriceHolder: finalPriceHolder, finalCurrency: finalCurrency, descriptionSlideshowHolder: descriptionSlideshowHolder,
              voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
              scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
              defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,

            )));
          }).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment Completed Successfully.')));
          });
          var transactionDetails = event["data"];
          print("Transaction Details =>" + transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
          debugPrint('\n\nPayment failed (error)\n\n');
        } else if (event["status"] == "event") {
          // Handle events here.
          debugPrint('\n\nPayment (event)\n\n');
        }
      });
    });
  }


  //Samsung Payment Method
  Future<void> samsungPayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "85333",
        serverKey: "S2JNBJB9N2-J2NBLZGG2T-JGD9LRRRK2",
        clientKey: "CHKMP9-QNHP6M-Q2B9TT-TM96QK",
        cartId: "12433",
        // cartDescription: "Flowers",
        // merchantName: "Flowers Store",
        amount: finalPriceHolder,
        currencyCode: finalCurrency,
        merchantCountryCode: "EG",
        merchantApplePayIndentifier: "merchant.com.bunldeId",
        simplifyApplePayValidation: true);
    FlutterPaytabsBridge.startSamsungPayPayment(configuration, (event) {
      setState(() async{
        if (event["status"] == "success") {
          // Handle transaction details here.
          debugPrint('\n\nPayment Success\n\n');
          List<String> WantToPayTour = [idHolder];
          await FirebaseFirestore.instance.collection('paidTours')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "paidTours": FieldValue.arrayUnion(WantToPayTour)
          }).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => museumDetail(
              idHolder: idHolder, nameHolder : nameHolder, locationHolder: locationHolder,
              thumbnailHolder: thumbnailHolder, descriptionRouteHolder: descriptionRouteHolder, locationRouteHolder: locationRouteHolder,
              finalPriceHolder: finalPriceHolder, finalCurrency: finalCurrency, descriptionSlideshowHolder: descriptionSlideshowHolder,
              voiceOversHolder: voiceOversHolder, voiceOverTitlesHolder: voiceOverTitlesHolder, voiceOverSlideshowHolder: voiceOverSlideshowHolder,
              scriptsHolder: scriptsHolder, languagesHolder: languagesHolder,
              defaultLanguage: defaultLanguage, defaultDescription: defaultDescription, selectedLanguage: selectedLanguage,

            )));
          }).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment Completed Successfully.')));
          });
          var transactionDetails = event["data"];
          print("Transaction Details =>" + transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
          debugPrint('\n\nPayment failed (error)\n\n');
        } else if (event["status"] == "event") {
          // Handle events here.
          debugPrint('\n\nPayment (event)\n\n');
        }
      });
    });
  }



  //Apple pay Button
  Widget applePayButton() {
    if (Platform.isIOS) {
      return FlatButton(
        onPressed: () {
          applePayPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Pay with Apple Pay',
                style: TextStyle(fontSize: 23, color: kSecondaryColor)
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  //Samsung Pay Button
  Widget samsungPayButton() {
    if (Platform.isAndroid) {
      return FlatButton(
        onPressed: () {
          samsungPayPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Pay with Samsung Pay',
                style: TextStyle(fontSize: 23, color: kSecondaryColor)
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          title: Text('Pick One To Proceed',
              style: TextStyle(
            color: kPrimaryColor,
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text('Pick One To Proceed'),
              SizedBox(height: 16),
              FlatButton(
                minWidth: size.width,
                onPressed: () {
                  payPressed();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Pay with Card',
                        style: TextStyle(fontSize: 23, color: kSecondaryColor)
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 16),
              Divider(thickness: 1, color: kPrimaryLightColor,),
              applePayButton(),
              samsungPayButton(),
              // SizedBox(height: 16),
              Divider(thickness: 1, color: kPrimaryLightColor,),
              FlatButton(
                onPressed: () {
                  apmsPayPressed();
                },
                child: Text('Pay with Alternative payment methods',
                    style: TextStyle(fontSize: 23, color: kSecondaryColor)
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {Navigator.pop(context);},
                    child: Text("Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: kPrimaryColor,
                    minWidth: 150,
                    height: 50,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                  child: Image.asset("assets/Logo/1024.png")
                ),
              ),
            ]),
        ),
      ),
    );

    // return Column(
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
    //         onPressed: () {
    //           // payPressed();
    //         },
    //         child: Text('Pay with Card'),
    //       ),
    //       SizedBox(height: 16),
    //       TextButton(
    //         onPressed: () {
    //           // apmsPayPressed();
    //         },
    //         child: Text('Pay with Alternative payment methods'),
    //       ),
    //       SizedBox(height: 16),
    //       // applePayButton(),
    //       samsungPayButton(),
    //     ],
    //   );
    }
}

// class testPayments {
//
//   Future<PaymentSdkConfigurationDetails> generateConfig() async {
//     var billingDetails = BillingDetails("John Smith", "email@domain.com",
//         "+97311111111", "st. 12", "ae", "dubai", "dubai", "12345");
//     var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
//         "+97311111111", "st. 12", "ae", "dubai", "dubai", "12345");
//     List<PaymentSdkAPms> apms = [];
//     apms.add(PaymentSdkAPms.VALU);
//     var configuration = PaymentSdkConfigurationDetails(
//         profileId: "85333",
//         serverKey: "S2JNBJB9N2-J2NBLZGG2T-JGD9LRRRK2",
//         clientKey: "CHKMP9-QNHP6M-Q2B9TT-TM96QK",
//         cartId: "12433",
//         // cartDescription: "Flowers",
//         // merchantName: "Flowers Store",
//         screentTitle: "Pay with Card",
//         amount: 2.0,
//         showBillingInfo: false,
//         forceShippingInfo: false,
//         currencyCode: "EGP",
//         merchantCountryCode: "EG",
//         billingDetails: billingDetails,
//         shippingDetails: shippingDetails,
//         alternativePaymentMethods: apms);
//
//     // var theme = IOSThemeConfigurations();
//     var theme = IOSThemeConfigurations();
//     theme.backgroundColor = "FFF"; // Color hex value
//     theme.buttonColor = "03989E";
//     theme.secondaryFontColor = "03989E";
//     theme.secondaryColor = "03989E";
//
//     theme.logoImage = "assets/Logo/toury-cyan.jpeg";
//
//     configuration.iOSThemeConfigurations = theme;
//
//     return configuration;
//   }
//
//   //Standard Payment Method
//   Future<void> payPressed() async {
//     try{
//       FlutterPaytabsBridge.startCardPayment(await generateConfig(), (event) {
//         // setState(() {
//           if (event["status"] == "success") {
//             // Handle transaction details here.
//             debugPrint('Payment Success');
//             var transactionDetails = event["data"];
//             print("Transaction Details =>" + transactionDetails);
//           } else if (event["status"] == "error") {
//             // Handle error here.
//             debugPrint('Payment failed (error)');
//           } else if (event["status"] == "event") {
//             // Handle events here.
//             debugPrint('Payment (event)');
//           }
//         // });
//       });
//     }catch (e){
//       debugPrint('catch error --> $e');
//     }
//   }
//
//   //APMS Payment Method
//   Future<void> apmsPayPressed() async {
//     FlutterPaytabsBridge.startAlternativePaymentMethod(await generateConfig(),
//             (event) {
//           // setState(() {
//             if (event["status"] == "success") {
//               // Handle transaction details here.
//               var transactionDetails = event["data"];
//               print(transactionDetails);
//             } else if (event["status"] == "error") {
//               // Handle error here.
//             } else if (event["status"] == "event") {
//               // Handle events here.
//             }
//           // });
//         });
//   }
//
//   //Apple Pay Payment Method
//   Future<void> applePayPressed() async {
//     var configuration = PaymentSdkConfigurationDetails(
//         profileId: "*Profile id*",
//         serverKey: "*server key*",
//         clientKey: "*client key*",
//         cartId: "12433",
//         cartDescription: "Flowers",
//         merchantName: "Flowers Store",
//         amount: 20.0,
//         currencyCode: "AED",
//         merchantCountryCode: "ae",
//         merchantApplePayIndentifier: "merchant.com.bunldeId",
//         simplifyApplePayValidation: true);
//     FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
//       // setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           print(transactionDetails);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       // });
//     });
//   }
//   //Apple pay Button
//   Widget applePayButton() {
//     if (Platform.isIOS) {
//       return TextButton(
//         onPressed: () {
//           applePayPressed();
//         },
//         child: Text('Pay with Apple Pay'),
//       );
//     }
//     return SizedBox(height: 0);
//   }
//
//   //Samsung Pay Button
//   Widget samsungPayButton() {
//     if (Platform.isAndroid) {
//       return TextButton(
//         onPressed: () {
//           // applePayPressed();
//         },
//         child: Text('Pay with Samsung Pay (same code of apple pay :/)'),
//       );
//     }
//     return SizedBox(height: 0);
//   }
//
//
//
//   selectPaymentOption(int index) async{
//     switch(index){
//       case 1:{
//           payPressed();
//           break;
//       }
//
//       case 2:{
//           apmsPayPressed();
//           break;
//       }
//     }
//
//   }
//
// }

