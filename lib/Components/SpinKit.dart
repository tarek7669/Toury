import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';

class DoubleBounce extends StatelessWidget {
  const DoubleBounce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: kPrimaryColor,
      size: 50.0,
    );
  }
}
