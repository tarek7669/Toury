import 'package:flutter/material.dart';
import 'package:project_toury/Pages/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signupBody(),
    );
  }
}
