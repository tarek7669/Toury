import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Login/login.dart';
import 'CardItems.dart';

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);
//
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//
//   int _currentIndex=0;
//
//   List cardList=[
//     Item1(),
//     Item2(),
//     Item3(),
//     Item4()
//   ];
//
//   List<T> map<T>(List list, Function handler) {
//     List<T> result = [];
//     for (var i = 0; i < list.length; i++) {
//       result.add(handler(i, list[i]));
//     }
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: size.height * 0.7,
//                 autoPlay: false,
//                 enableInfiniteScroll: false,
//                 enlargeCenterPage: true,
//                 autoPlayInterval: Duration(seconds: 3),
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 pauseAutoPlayOnTouch: true,
//                 aspectRatio: 2.0,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                 },
//               ),
//               items: cardList.map((card){
//                 return Builder(
//                     builder:(BuildContext context){
//                       return Container(
//                         // height: MediaQuery.of(context).size.height*0.30,
//                         width: MediaQuery.of(context).size.width,
//                         // child: Card(
//                         //   color: Colors.grey,
//                         //   child: card,
//                         // ),
//                         child: card,
//                       );
//                     }
//                 );
//               }).toList(),
//             ),
//           ],
//         )
//     );
//   }
// }


class Body extends StatelessWidget {
  bool first_time;

  Body({Key? key, required this.first_time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
        first_time ?
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()))
        : Navigator.pop(context),
        onSkipButtonPressed: () =>
        first_time ?
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()))
        : Navigator.pop(context),
      ),
    );
  }
}

