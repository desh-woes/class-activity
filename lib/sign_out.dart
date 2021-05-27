import 'package:flutter/material.dart';

import 'authService.dart';

class SignOut extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 51.91,
            margin: const EdgeInsets.only(left: 60.0, right: 60.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
              ),
              onPressed: () async {
                await _auth.signOut();
                Navigator.popAndPushNamed(context, "/");
              },
              child: Text("Sign out"),
            )),
      ),
    );
  }
}
