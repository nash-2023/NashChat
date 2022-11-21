import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nash_chat/screens/chat_screen.dart';
import 'package:nash_chat/screens/login_screen.dart';
import 'package:nash_chat/screens/registration_screen.dart';
import 'package:nash_chat/screens/welcome_screen.dart';

import 'constants.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
            // body: TextStyle(color: Colors.black54),
            ),
      ),
      initialRoute: Pages_router.welcome,
      routes: {
        Pages_router.welcome: (context) => WelcomeScreen(),
        Pages_router.login: (context) => LoginScreen(),
        Pages_router.registr: (context) => RegistrationScreen(),
        Pages_router.chat: (context) => ChatScreen(),
      },
    );
  }
}
