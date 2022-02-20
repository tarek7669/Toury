import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Services/auth_services.dart';
import '../../../constants.dart';
import 'background.dart';
import 'package:provider/provider.dart';


class signupBody extends StatefulWidget {

  const signupBody({
    Key? key,
  }) : super(key: key);

  @override
  _signupBody createState() => _signupBody();

}

class _signupBody extends State<signupBody> {

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final TextEditingController usernameController = new TextEditingController();
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController passwordController = new TextEditingController();
    final TextEditingController countryController = new TextEditingController();

    String username = '';
    String email = '';
    String country = '';

    String phoneNumber = '';
    String code_country = '';
    String isoCode = '';

    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Toury',
                style: GoogleFonts.iceland(
                  textStyle: TextStyle(
                    color: kPrimaryColor,
                    letterSpacing: 2.0,
                    fontSize: 50,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "SIGNUP",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        validator: (val) => val!.isEmpty ? 'Enter A Username' : null,
                        controller: usernameController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                          )
                        ),
                        onChanged: (user) {
                          print(user);
                          username = user;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                        controller: emailController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: kPrimaryColor,
                          )
                        ),
                        onChanged: (userEmail) {
                          print(userEmail);
                          email = userEmail;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        validator: (val) => val!.length < 6 ? 'Password Too Short' : null,
                        controller: passwordController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.password,
                            color: kPrimaryColor,
                          )
                        ),
                        obscureText: true,
                        onChanged: (userPassword) {
                          print(userPassword);
                        },
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        cursorColor: kPrimaryColor,
                        validator: (val) => val!.isEmpty ? 'Please Enter A Country' : null,
                        controller: countryController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "Country",
                          prefixIcon: Icon(
                            Icons.place_outlined,
                            color: kPrimaryColor,
                          )
                        ),
                        onChanged: (userCountry) {
                          print(userCountry);
                          country = userCountry;
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ButtonTheme(
                buttonColor: kPrimaryColor,
                minWidth: 320.0,
                height: 55.0,
                child: RaisedButton(
                  onPressed: () async {
                    // if(_formKey.currentState!.validate()) {
                    //   await authService.createUserWithEmailAndPassword(
                    //       emailController.text, passwordController.text,
                    //       usernameController.text, phoneNumber, code_country, isoCode, countryController.text);
                    //   Navigator.pop(context);
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text('Invalid Inputs')));
                    // }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Already have An Account? Login"),
              ),

            ],
          ),
        )
    );
  }
}