import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth change user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  // Method to allow sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult registerResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return registerResult.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method to register with email and password (Sign up)
  Future registerWithEmailAndPassword(String merchantName, String email,
      String password, String phoneNumber) async {
    try {
      AuthResult registerResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return registerResult.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method to Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
