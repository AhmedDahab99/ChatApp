import 'package:flash_chat_app/UI/LoginScreen.dart';
import 'package:flash_chat_app/UI/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetStartedScreen extends StatefulWidget {
  static String id='GetStarted_screen';
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
                Colors.blue[900],
                Colors.blue[500],
                Colors.blue[100],
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Hero(
                      tag:'logo' ,
                      child: Icon(FontAwesomeIcons.comments,color: Colors.blue[900],size: 100,)),
                  SizedBox(height: 15,),
                  Text(
                    'Chatty',
                    style: TextStyle(
                        color: Colors.blue[900].withOpacity(0.7), fontWeight: FontWeight.bold, fontSize: 50.0),
                  ),
                ],
              ),
              SizedBox(height: 60.0,),
             Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: RaisedButton(
                     onPressed: (){
                       Navigator.pushNamed(context, LoginScreen.id);
                     },
                     elevation: 10.0,
                     color: Colors.blue[600],
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(60.0),
                     ),
                     padding: const EdgeInsets.symmetric(horizontal: 82.0,vertical: 3.0),
                     child: Text(
                       'Login',
                       style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.w400,
                           fontSize: 35.0),
                     ),
                   ),
                 ),
                 RaisedButton(
                   onPressed: (){
                     Navigator.pushNamed(context, RegistrationScreen.id);
                   },
                   elevation: 10.0,
                   color: Colors.blue[900],
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(60.0),
                   ),
                   padding: const EdgeInsets.symmetric(horizontal: 60.0,vertical: 3.0),
                   child: Text(
                     'Register',
                     style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.w400,
                         fontSize: 35.0),
                   ),
                 )
               ],
             ),
              SizedBox(height: 60.0,),
              Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.blue[100].withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400, fontSize: 35.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
