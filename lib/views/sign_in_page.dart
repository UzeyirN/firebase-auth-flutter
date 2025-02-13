import 'package:firebase_test/views/email_sign_in.dart';
import 'package:firebase_test/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  Future<void> _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Auth>(context, listen: false).signInAnonymously();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInGoogle() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).signInWithGoogle();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Provider.of<Auth>(context, listen: false).signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SIGN IN PAGE',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              onPressed: _isLoading ? null : _signInAnonymously,
              color: Colors.orangeAccent,
              child: Text(
                'Sign in anonymously',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailSignInPage(),
                        ),
                      );
                    },
              color: Colors.yellow,
              child: Text(
                'Sign in Email/Password',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              onPressed: _isLoading ? null : _signInGoogle,
              color: Colors.blueAccent,
              child: Text(
                'Google sign in',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
