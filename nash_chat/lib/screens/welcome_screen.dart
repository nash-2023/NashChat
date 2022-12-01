import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nash_chat/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../components/roundedButton.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? ctrl;
  Animation? anim;

  @override
  void initState() {
    ctrl = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      // upperBound: 100.0,
    );
    anim = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(ctrl!);
    ctrl!.forward();
    ctrl!.addListener(() {
      setState(() {});
      // print(anim!.value);
    });
    super.initState();
    Firebase.initializeApp();
  }

  @override
  void dispose() {
    ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: anim!.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                SizedBox(width: 5.0),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      speed: Duration(milliseconds: 100),
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              clr: Colors.lightBlueAccent,
              onTap: () {
                Navigator.pushNamed(context, Pages_router.login);
              },
            ),
            RoundedButton(
              title: 'Register',
              clr: Colors.blueAccent,
              onTap: () {
                Navigator.pushNamed(context, Pages_router.registr);
              },
            ),
          ],
        ),
      ),
    );
  }
}





 // anim = CurvedAnimation(
    //   parent: ctrl!,
    //   curve: Curves.easeIn,
    // );
// ctrl!.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     ctrl!.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     ctrl!.forward();
    //   }
    //   print(status);
    // });

    // '${(ctrl!.value * 100).toInt()}%',