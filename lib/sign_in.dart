import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'authService.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loginFail = false;
  bool _obscureText = true;

  // Form Text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Toggles the password show status
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 60.0, right: 60.0, top: 100.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value.isEmpty || !value.contains("@")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(20)),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a valid password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Password",
                        errorText: loginFail
                            ? "Incorrect email or password. Could not sign in."
                            : null,
                        suffixIcon: IconButton(
                          iconSize: 18.0,
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black87,
                          ),
                          onPressed: _toggleObscureText,
                        )),
                    obscureText: _obscureText,
                  ),
                  Padding(padding: const EdgeInsets.all(20)),
                ],
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(10)),
          Container(
              height: 51.91,
              margin: const EdgeInsets.only(left: 60.0, right: 60.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.brown),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {

                    dynamic result =
                    await _auth.signInWithEmailAndPassword(
                        emailController.text.trim(),
                        passwordController.text.trim());
                    if (result == null) {
                      setState(() {
                        loginFail = true;
                      });
                    } else {
                      Navigator.pushNamed(context, "/signOut");
                    }
                  }
                },
                child: Text("Sign in"),
              )),
          Padding(padding: const EdgeInsets.all(15)),
          Center(
            child: Column(
              children: [
                Text("Forgot Password?"),
                Padding(padding: const EdgeInsets.all(5)),
                RichText(
                  key: Key("toggleSignUp"),
                  text: TextSpan(
                      style: TextStyle(color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(text: "New User? "),
                        TextSpan(
                            text: "Sign Up!",
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => widget.toggleView())
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
