import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

enum FormStatus { signIn, register, reset }

class EmailSignInPage extends StatefulWidget {
  const EmailSignInPage({super.key});

  @override
  State<EmailSignInPage> createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  FormStatus formStatus = FormStatus.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: formStatus == FormStatus.signIn
          ? buildEmailSignInForm()
          : formStatus == FormStatus.register
              ? buildEmailRegisterForm()
              : buildResetForm(),
    );
  }

  Widget buildEmailSignInForm() {
    final signInFormKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email sign in',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              validator: (input) {
                if (!EmailValidator.validate(input!)) {
                  return 'Please fill the correct field';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              validator: (input) {
                if (input!.length <= 6) {
                  return 'Please write a password that more than 6';
                } else {
                  return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (signInFormKey.currentState!.validate()) {
                  final auth = Provider.of<Auth>(context, listen: false);
                  final user = await auth.signInWithEmailAndPassword(
                      emailController.text, passwordController.text);

                  if (!user!.emailVerified) {
                    await _showMyDialog();
                    await auth.signOut();
                  }

                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('Sign in'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  formStatus = FormStatus.register;
                });
              },
              child: Text('Click for new registration'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  formStatus = FormStatus.reset;
                });
              },
              child: Text('Forget password'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResetForm() {
    final resetFormKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: resetFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset password',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              validator: (input) {
                if (!EmailValidator.validate(input!)) {
                  return 'Please fill the correct field';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (resetFormKey.currentState!.validate()) {
                  final auth = Provider.of<Auth>(context, listen: false);

                  await auth.sendPasswordResetEmail(emailController.text);

                  await _showResetDialog();
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmailRegisterForm() {
    final regFormKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: regFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email register',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              validator: (input) {
                if (!EmailValidator.validate(input!)) {
                  return 'Please fill the correct field';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              validator: (input) {
                if (input!.length <= 6) {
                  return 'Please write a password that more than 6';
                } else {
                  return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordConfirmController,
              validator: (input) {
                if (input != passwordController.text) {
                  return 'Not matches';
                } else {
                  return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'Re-password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (regFormKey.currentState!.validate()) {
                    final auth = Provider.of<Auth>(context, listen: false);
                    final user = await auth.createUserWithEmailAndPassword(
                        emailController.text, passwordController.text);
                    if (user != null && !user.emailVerified) {
                      await user.sendEmailVerification();
                    }

                    await _showMyDialog();
                    await auth.signOut();

                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  print('Error is caught in Register form: ${e.message}');

                  // alert dialog ola bilerdi : e.message
                }
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  formStatus = FormStatus.signIn;
                });
              },
              child: Text('Are you already registered? Click on'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('APPROVAL REQUIRED'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hello,Please check your mail'),
                Text(
                    'You must click on the confirmation link and log in again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('GOT IT'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('RESET PASSWORD'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hello,Please check your mail'),
                Text(
                    'You must click on the reset password link and log in again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('GOT IT'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
