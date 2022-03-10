import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_toury/Components/bottomNavigationBar.dart';
import 'package:project_toury/Pages/Carousel_Start/Carousel.dart';
import 'package:project_toury/Pages/MuseumList/museumList.dart';
import 'package:project_toury/Services/wrapper.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splash: Image.asset("assets/Logo/1024.png", height: size.height * 0.4, width: size.width * 0.4,),
      animationDuration: Duration(milliseconds: 2000),
      splashIconSize: 400,
      backgroundColor: kPrimaryColor,
      nextScreen: Wrapper(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      duration: 4000,
    );
  }
}