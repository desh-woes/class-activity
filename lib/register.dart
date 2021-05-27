import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'authService.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool signUpFail = false;
  bool _obscureText = true;

  // Text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController merchantNameController = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'RW');

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
                      errorText: signUpFail
                          ? "Incorrect email. Could not sign up."
                          : null,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(20)),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                    },
                    onInputValidated: (bool value) {
                      print(value);
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: phoneNumberController,
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: OutlineInputBorder(),
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
                ],
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(30)),
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
                    await _auth.registerWithEmailAndPassword(
                        merchantNameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        phoneNumberController.text.trim());

                    if (result == null) {
                      setState(() {
                        signUpFail = true;
                      });
                    } else {
                      Navigator.pushNamed(context, "/signOut");
                    }
                  }
                },
                child: Text("Sign Up"),
              )),
          Padding(padding: const EdgeInsets.all(15)),
          Center(
            child: Column(
              children: [
                Text("Already have an account?"),
                Padding(padding: const EdgeInsets.all(5)),
                RichText(
                  key: Key("toggleSignIn"),
                  text: TextSpan(
                      style: TextStyle(color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Sign in!",
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
