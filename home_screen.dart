import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => auth.logout(),
          )
        ],
      ),
      body: Center(child: Text('You are logged in!', style: TextStyle(fontSize: 24))),
    );
  }
}


import 'package:flutter/material.dart';
import 'firebase_auth_service.dart'; // Assume you have this service for Firebase Auth

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuthService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuthService.logout();
              Navigator.pushReplacementNamed(context, '/auth'); // Navigate back to AuthScreen
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          user != null ? 'Hello, ${user.displayName}!' : 'You are logged in!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

