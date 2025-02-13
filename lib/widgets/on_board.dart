import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/views/home_page.dart';
import 'package:firebase_test/views/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({super.key});

  @override
  State<OnBoardWidget> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoardWidget> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStatus(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null ? HomePage() : SignInPage();
        } else {
          return SizedBox(
            height: 300,
            width: 300,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
