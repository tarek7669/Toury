import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Splash/components/body.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {
    return Body();
  }
}