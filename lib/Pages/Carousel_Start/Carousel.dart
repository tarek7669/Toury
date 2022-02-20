import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Carousel_Start/components/body.dart';

class Carousel extends StatelessWidget {
  bool first_time;
  Carousel({Key? key, required this.first_time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(first_time: first_time),
    );
  }
}