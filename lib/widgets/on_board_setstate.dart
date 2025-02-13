import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/views/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../views/home_page.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({super.key});

  @override
  State<OnBoardWidget> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoardWidget> {
  bool? _isLogged;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _isLogged = false;
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        _isLogged = true;
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLogged == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _isLogged!
            ? HomePage()
            : SignInPage();
  }
}
