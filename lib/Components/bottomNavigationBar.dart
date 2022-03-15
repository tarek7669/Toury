import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Pages/MuseumList/museumList.dart';
import 'package:project_toury/Pages/PaidToursList/paidToursList.dart';
import 'package:project_toury/Pages/Search/Search.dart';
import '../../../constants.dart';
import 'package:project_toury/Pages/Profile/profile.dart';


class NavigationBar extends StatefulWidget {

  NavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  bool isConnected = false, loading_connection = false;
  int _selectedIndex = 0;

  Future<void> CheckConnection() async{
    setState(() {
      loading_connection = true;
    });

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isConnected = true;
          _selectedIndex = 0;
        });
        print('CONNECTED    (bottomNavigationBar -> CheckConnection())');
      }
    } on SocketException catch (_) {
      setState(() {
        isConnected = false;
        _selectedIndex = 1;
      });
      print('NOT CONNECTED   (bottomNavigationBar -> CheckConnection())');
    }

    setState(() {
      loading_connection = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckConnection();
  }

  static List<Widget> _pages = <Widget>[
    // homeList(),
    MuseumList(),
    PaidToursList(),
    // Search(),
    Profile(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: _pages.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: Opacity(
        opacity: 1,
        child: Container(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.centerLeft,
          //         end: Alignment.centerRight,
          //         colors: [Theme.of(context).canvasColor, kTestColor]
          //     )
          // ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            unselectedIconTheme: IconThemeData(color: Colors.blueGrey, size: 35, opacity: 0.8),
            selectedIconTheme: IconThemeData(color: kPrimaryColor, size: 35, opacity: 1),
            selectedItemColor: kPrimaryColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.headphones),
                label: "Home",
                // backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.play_arrow_solid),
                label: "Library",
                // backgroundColor: Colors.red,
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.search),
              //   label: "Search",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Profile",
                // backgroundColor: Colors.red,
              ),
            ],
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
