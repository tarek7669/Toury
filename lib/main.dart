import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_toury/Pages/Splash/splash.dart';
import 'package:project_toury/Pages/Login/login.dart';
import 'package:project_toury/Pages/Signup/signup.dart';
import 'Components/UserSharedPreferences.dart';
import 'Feedback/feedback.dart';
import 'Pages/Carousel_Start/Carousel.dart';
import 'Pages/MuseumList/museumList.dart';
import 'Pages/ResetPassword/ResetPassword.dart';
import 'Services/wrapper.dart';
import 'Services/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await UserSharedPreferences.init();

  runApp(Toury());
  // runApp(MultiProvider(providers: [
  //   ChangeNotifierProvider.value(value: AuthProvider.initialize())
  // ],
  //   child: Toury(),));
}

class Toury extends StatelessWidget {
  const Toury({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService> (
          create: (_) => AuthService(),
        ),
        // ChangeNotifierProvider.value(value: AuthProvider().initialize())
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'TouryApp',

        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/wrapper': (context) => Wrapper(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUpScreen(),
          '/reset': (context) => ResetPassword(),

          '/feedback': (context) => FeedBack(),

          '/museumsList': (context) => MuseumList(),

          '/carousel': (context) => Carousel(first_time: true),
        },
      ),
    );
  }
}
