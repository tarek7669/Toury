import 'package:flutter/material.dart';

import '../../../constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kPrimaryColor, kTestColor]
          )
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/toury-1727-tn.appspot.com/o/Images%2Fmain_top.png?alt=media&token=266de0ed-b4a6-415c-bbd5-a6ce2d6b7ca0",
              width: size.width * 0.35,
              color: kPrimaryColor,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/toury-1727-tn.appspot.com/o/Images%2Flogin_bottom.png?alt=media&token=69d7c715-cd38-43f5-8c37-d57d197ab78b",
              width: size.width * 0.4,
              color: kSecondaryColor,
            ),
          ),
          SingleChildScrollView(child: child),
        ],
      ),
    );
  }
}