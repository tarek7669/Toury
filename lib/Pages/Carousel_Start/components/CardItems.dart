import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Login/login.dart';
import '../../../constants.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

// class Item1 extends StatelessWidget {
//   const Item1({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             stops: [0.3, 1],
//             colors: [kPrimaryColor,Color(0xffffcc66),]
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//               "Data",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.bold
//               )
//           ),
//           Text(
//               "Data",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.w600
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Item2 extends StatelessWidget {
//   const Item2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             stops: [0.3, 1],
//             colors: [Color(0xff5f2c82), Color(0xff49a09d)]
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//               "Data",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.bold
//               )
//           ),
//           Text(
//               "Data",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.w600
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Item3 extends StatelessWidget {
//   const Item3({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             stops: [0.3, 1],
//             colors: [Color(0xffff4000),Color(0xffffcc66),]
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Image.asset(
//             'assets/flutter_dev.png',
//             height: 180.0,
//             fit: BoxFit.cover,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class Item4 extends StatelessWidget {
//   const Item4({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.cyan,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//               "Data",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.bold
//               )
//           ),
//           Text(
//               "Data",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.w600
//               )
//           ),
//           Positioned(
//             bottom: 0,
//             child: FlatButton(
//                 color: Colors.white,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//                 },
//                 child: Text(
//                     'Get Started!!'
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }

final pageList = [
  PageModel(
      color: kSecondaryColor,
      icon: Icon(Icons.hotel),
      heroImagePath: 'assets/png/stores.svg',
      title: Text('Hotels',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All hotels and hostels are sorted by hospitality rating',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      // iconImagePath: 'assets/png/key.png',
  ),
  PageModel(
      color: const Color(0xFF65B0B4),
      heroImagePath: 'assets/png/banks.svg',
      title: Text('Banks',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text(
          'We carefully verify all banks before adding them into the app',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconImagePath: 'assets/png/wallet.png'),
  PageModel(
    color: const Color(0xFF9B90BC),
    heroImagePath: 'assets/png/stores.svg',
    title: Text('Store',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        )),
    body: Text('All local stores are categorized for your convenience',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        )),
    icon: Icon(
      Icons.shopping_cart,
      color: const Color(0xFF9B90BC),
    ),
  ),
  // SVG Pages Example
  PageModel(
      color: const Color(0xFF678FB4),
      heroImagePath: 'assets/svg/hotel.svg',
      title: Text('Hotels SVG',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All hotels and hostels are sorted by hospitality rating',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconImagePath: 'assets/svg/key.svg',
      heroImageColor: Colors.white),
  PageModel(
      color: const Color(0xFF65B0B4),
      heroImagePath: 'assets/svg/bank.svg',
      title: Text('Banks SVG',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text(
          'We carefully verify all banks before adding them into the app',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconImagePath: 'assets/svg/cards.svg',
      heroImageColor: Colors.white),
  PageModel(
    color: const Color(0xFF9B90BC),
    heroImagePath: 'assets/svg/store.svg',
    title: Text('Store SVG',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        )),
    body: Text('All local stores are categorized for your convenience',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        )),
    iconImagePath: 'assets/svg/cart.svg',
  ),
];
