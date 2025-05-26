import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isLogin = true;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void submit() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    try {
      if (isLogin) {
        await auth.login(emailCtrl.text, passCtrl.text);
      } else {
        await auth.signUp(emailCtrl.text, passCtrl.text);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submit, child: Text(isLogin ? 'Login' : 'Sign Up')),
            TextButton(onPressed: toggleForm, child: Text(isLogin ? 'Create Account' : 'Have an account? Login')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'firebase_auth_service.dart'; // Assume you have this service for Firebase Auth

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isLogin = true;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void submit() async {
    try {
      if (isLogin) {
        await FirebaseAuthService.login(emailCtrl.text, passCtrl.text);
      } else {
        await FirebaseAuthService.signUp(
          nameCtrl.text,
          emailCtrl.text,
          passCtrl.text,
        );
      }
      // Navigate to HomeScreen after successful login/signup
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!isLogin)
              TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submit, child: Text(isLogin ? 'Login' : 'Sign Up')),
            TextButton(onPressed: toggleForm, child: Text(isLogin ? 'Create Account' : 'Have an account? Login')),
          ],
        ),
      ),
    );
  }
}
