import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:marques_construcao/vendor/views/auth/vendor_login_screen.dart';
// import 'package:marques_construcao/vendor/views/auth/vendor_register_screen.dart';

import 'package:marques_construcao/vendor/views/screens/landind_screen.dart';

class VendorAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // KeysApp _key = KeysApp();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return VendorLoginScreen();
        }

        // Render your application if authenticated
        return LandingScreen();
      },
    );
  }
}
