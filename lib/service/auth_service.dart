import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign up method
  Future<User?>signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    print(result.user);
    return result.user;
  }

  // Login Method

  Future<User?>login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    print(result.user);
    return result.user;
  }

}