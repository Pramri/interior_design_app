import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final String redirectPage;
  final Function login;

  LoginPage({required this.redirectPage, required this.login});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input?.isEmpty ?? true) {
                  return 'Please type an email';
                }
                return null;
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              validator: (input) {
                if (input?.isEmpty ?? true) {
                  return 'Please type a password';
                }
                return null;
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: signIn,
              child: Text('Sign in'),
            ),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState?.validate() ?? true) {
      _formKey.currentState?.save();
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        Navigator.pushReplacementNamed(context, widget.redirectPage);
      } catch (e) {
        print("Signin failed");
      }
    }
  }

  void signUp() async {
    if (_formKey.currentState?.validate() ?? true) {
      _formKey.currentState?.save();
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        Navigator.pushReplacementNamed(context, widget.redirectPage);
      } catch (e) {
        print(e);
      }
    }
  }
}
