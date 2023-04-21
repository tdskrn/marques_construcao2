import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorLogoutScreen extends StatelessWidget {
  const VendorLogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Logout Screen'),
          ),
          TextButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text('Signout'))
        ],
      ),
    );
  }
}
