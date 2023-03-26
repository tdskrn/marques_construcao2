import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  // Sign up users
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signUpUsers(
    String email,
    String fullname,
    String phoneNumber,
    String password,
  ) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty &&
          fullname.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        // Create User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (error) {}
    return res;
  }
}
