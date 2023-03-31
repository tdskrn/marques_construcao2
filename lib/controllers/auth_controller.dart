import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Sign up users
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signUpUsers(
    String email,
    String fullName,
    String phoneNumber,
    String password,
  ) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        // Create User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _firestore.collection('buyers').doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'buyerId': cred.user!.uid,
          'address': '',
        }).whenComplete(() {
          res = 'success';
          return res;
        });
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (error) {}
    return res;
  }
}
