import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'GradientText.dart';

class CustomAppBar extends StatelessWidget {
  Widget widget;
  CustomAppBar({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(

          pinned: false,
          floating: true,
          backgroundColor: Theme.of(context).canvasColor,
          // expandedHeight: size.height * 0.4,
          automaticallyImplyLeading: false,
          // foregroundColor: Colors.red,
          iconTheme: IconThemeData(color: kPrimaryColor),


          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.fromLTRB(13.0, 23.0, 3.0, 13.0),
            centerTitle: false,
            title: GradientText(
                'Toury',
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kPrimaryColor, kTestColor]
                ),
                style: GoogleFonts.anton(
                  textStyle: TextStyle(
                    color: kPrimaryColor,
                    letterSpacing: 2.0,
                    fontSize: 35,
                  ),
                )),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                return widget;
                },
              childCount: 1,)
        ),
      ],
    );
  }
}
