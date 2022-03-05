import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sign_button/sign_button.dart';
import 'package:flash_chat_app/UI/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ChatScreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool showSpinner = false;
  final snackBar = SnackBar(
    content: Text("Email Or Password isn't Correct"),
    duration: Duration(seconds: 2),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
                Colors.blue[900],
                Colors.blue[600],
                Colors.blue[300],
              ]),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 60.0,
              ),
              Center(
                child: Column(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Icon(
                        FontAwesomeIcons.comments,
                        color: Colors.blue[900],
                        size: 100,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blue[900].withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 30.0),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            key: formKey,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0),
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(16.0),
                                      labelText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.email_rounded,
                                        color: Colors.blue[900],
                                      ),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                              color: Colors.blue[900]))),
                                  validator: Validator.validateEmail,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0),
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(16.0),
                                      labelText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock_open_rounded,
                                        color: Colors.blue[900],
                                      ),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                              color: Colors.blue[900]))),
                                  validator: Validator.validatePassword,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.blue[900],
                                      activeColor: Colors.blue[200],
                                      value: this.rememberMe,
                                      onChanged: (bool value) {
                                        setState(() {
                                          this.rememberMe = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Remember Me',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    RaisedButton(
                                      onPressed: () async {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        FocusScope.of(context).unfocus();
                                        var formState = formKey.currentState;
                                        if (formState.validate()) {
                                          try {
                                            FirebaseAuth firebaseAuth =
                                                FirebaseAuth.instance;
                                            var user = await firebaseAuth
                                                .signInWithEmailAndPassword(
                                                    email: emailController.text,
                                                    password: passwordController
                                                        .text);
                                            if (user != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatScreen(),
                                                ),
                                              );
                                            }
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          } catch (e) {
                                            return e.Message;
                                            // Scaffold.of(context).showSnackBar(snackBar);
                                          }
                                        }
                                      },
                                      elevation: 6.0,
                                      color: Colors.blue[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 8),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.blue[100],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationScreen()));
                                      },
                                      elevation: 6.0,
                                      color: Colors.blue[600],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 8),
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30.0),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                SignInButton(
                                    buttonType: ButtonType.facebook,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    onPressed: () {
                                      print('Login');
                                    }),
                                SizedBox(
                                  height: 5.0,
                                ),
                                SignInButton(
                                    buttonType: ButtonType.google,
                                    onPressed: () {
                                      print('Login');
                                    })
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ] //children
                    ),
          ),
        ),
      ),
    );
  }
}
