import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marques_construcao/vendor/views/auth/vendor_auth.dart';

class VendorLogoutScreen extends StatelessWidget {
  const VendorLogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_auth.currentUser!.uid),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text('Logout Screen'),
          ),
          TextButton(
              onPressed: () {
                _auth.signOut().whenComplete(() {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return VendorAuthScreen();
                    },
                  ));
                });
              },
              child: Text('Signout'))
        ],
      ),
    );
  }
}
