import 'package:firebase_core/firebase_core.dart';
import 'package:project_toury/Components/bottomNavigationBar.dart';
import 'package:project_toury/Pages/Login/components/body.dart';
import 'package:project_toury/Pages/PaidToursList/paidToursList.dart';
import 'package:project_toury/Pages/Splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:project_toury/Pages/Carousel_Start/Carousel.dart';
import 'auth_services.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    //   return StreamBuilder<User?>(
    //     stream: authService.user,
    //     builder: (_, AsyncSnapshot<User?> snapshot){
    //       if (snapshot.connectionState == ConnectionState.active) {
    //         final User? user = snapshot.data;
    //         return user == null ? Carousel() : NavigationBar();
    //       } else {
    //         return Scaffold(
    //             body: Center(
    //               child: CircularProgressIndicator(),
    //             )
    //         );
    //       }
    //     },
    //   );
    // }

    return FirebaseAuth.instance.currentUser == null
        ? Carousel(first_time: true)
        : NavigationBar();
  }
}

// enum AuthStatus { unknown, notLoggedIn, loggedIn }
//
// class Wrapper extends StatefulWidget {
//   const Wrapper({Key? key}) : super(key: key);
//
//   @override
//   _WrapperState createState() => _WrapperState();
// }
//
// class _WrapperState extends State<Wrapper> {
//   AuthStatus _authStatus = AuthStatus.notLoggedIn;
//   String currentUid = '';
//
//   // AuthStatus _authStatus = authStatus;
//
//
//   // bool isConnected = false;
//   //
//   // Future<void> CheckConnection() async{
//   //   try {
//   //     final result = await InternetAddress.lookup('example.com');
//   //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//   //       setState(() {
//   //         isConnected = true;
//   //       });
//   //       print('connected');
//   //     }
//   //   } on SocketException catch (_) {
//   //     setState(() {
//   //       isConnected = false;
//   //     });
//   //     print('not connected');
//   //   }
//   // }
//   //
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   CheckConnection();
//   // }
//
//
//   @override
//   void didChangeDependencies() async {
//     super.didChangeDependencies();
//
//     //get the state, check current User, set AuthStatus based on state
//     PhoneUser _authStream = Provider.of<PhoneUser>(context);
//     if (_authStream != null) {
//       setState(() {
//         _authStatus = AuthStatus.loggedIn;
//         currentUid = _authStream.uid;
//       });
//     } else {
//       setState(() {
//         _authStatus = AuthStatus.notLoggedIn;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//   //   final authService = Provider.of<AuthService>(context);
//   //   return StreamBuilder<PhoneUser?>(
//   //     stream: authService.user,
//   //     builder: (_, AsyncSnapshot<PhoneUser?> snapshot){
//   //       if (snapshot.connectionState == ConnectionState.active) {
//   //         final PhoneUser? user = snapshot.data;
//   //         // return user == null ? Carousel() : NavigationBar();
//   //         return NavigationBar();
//   //       } else {
//   //         return Scaffold(
//   //             body: Center(
//   //               child: Splash(),
//   //             )
//   //         );
//   //       }
//   //     },
//   //   );
//   // }
//     Widget retVal = Splash();
//
//     switch (_authStatus) {
//       case AuthStatus.unknown:
//         retVal = Splash();
//         break;
//       case AuthStatus.notLoggedIn:
//         retVal = Carousel();
//         break;
//       case AuthStatus.loggedIn:
//         retVal = NavigationBar();
//         break;
//       default:
//     }
//     return retVal;
//   }
// }
//
