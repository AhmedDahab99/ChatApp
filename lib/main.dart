import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_app/UI/ChatScreen.dart';
import 'package:flash_chat_app/UI/GetStartedScreen.dart';
import 'package:flash_chat_app/UI/LoginScreen.dart';
import 'package:flash_chat_app/UI/RegistrationScreen.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}
class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: GetStartedScreen .id,
      routes: {
        GetStartedScreen.id:(context)=>GetStartedScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}
