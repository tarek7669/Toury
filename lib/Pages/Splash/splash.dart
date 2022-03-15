import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Splash/components/body.dart';

import '../../constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Body();
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            bottom: 0,
            child: Image.asset('assets/Design/60286.png')
          ),
          Body(),
        ],
      ),
    );
  }
}