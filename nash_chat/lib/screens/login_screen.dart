import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/roundedButton.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpin = false;
  String? my_email;
  String? my_password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(height: 48.0),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  my_email = value;
                },
                decoration:
                    KTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(height: 8.0),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    my_password = value;
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              SizedBox(height: 24.0),
              RoundedButton(
                title: 'Log In',
                clr: Colors.lightBlueAccent,
                onTap: () async {
                  setState(() {
                    showSpin = true;
                  });
                  try {
                    final new_user = await _auth.signInWithEmailAndPassword(
                        email: my_email!, password: my_password!);
                    if (new_user != null) {
                      Navigator.pushNamed(context, Pages_router.chat);
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpin = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
