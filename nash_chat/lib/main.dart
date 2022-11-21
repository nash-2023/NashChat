import 'package:flutter/material.dart';
import 'package:nash_chat/screens/welcome_screen.dart';
import 'package:nash_chat/screens/login_screen.dart';
import 'package:nash_chat/screens/registration_screen.dart';
import 'package:nash_chat/screens/chat_screen.dart';
import 'package:nash_chat/screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
            // body: TextStyle(color: Colors.black54),
            ),
      ),
      home: WelcomeScreen(),
    );
  }
}
