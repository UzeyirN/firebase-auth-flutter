import 'package:firebase_test/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Provider.of<Auth>(context, listen: false).signOut();
              print('logout clicked');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
