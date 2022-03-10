import 'package:flutter/material.dart';
import '../constants.dart';
import 'components/body.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Feedback',
          style: TextStyle(
            color: kPrimaryColor,
            letterSpacing: 2.0,
            // fontSize: ,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
