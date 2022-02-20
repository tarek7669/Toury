import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key ? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFF03989E)]
          )
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/toury-1727-tn.appspot.com/o/Images%2Fsignup_top.png?alt=media&token=9671c39b-1bcc-4b10-a7b4-9389929f8ec5",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/toury-1727-tn.appspot.com/o/Images%2Fmain_bottom.png?alt=media&token=699a7ed7-bea0-483f-b6fa-b77a82253bd9",
              width: size.width * 0.25,
            ),
          ),
          child,
        ],
      ),
    );
  }
}