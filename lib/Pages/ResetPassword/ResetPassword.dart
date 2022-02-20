import 'package:flutter/material.dart';
import 'package:project_toury/Services/auth_services.dart';
import 'package:project_toury/Pages/Login/login.dart';
import 'package:project_toury/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 30,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    FlatButton(
                      minWidth: size.width * 0.4,
                      color: Colors.white,
                      onPressed: () {
                          Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.1),
                    FlatButton(
                      minWidth: size.width * 0.4,
                      color: kPrimaryColor,
                      onPressed: () {
                        // AuthService().resetPassword(email: _email.text.trim()).then((value) {
                        //   if (value == "Email sent") {
                        //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                        //   }
                        // });
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
