import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic userData;

  const EditProfileScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 6,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.yellow.shade900,
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.photo,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: userData['fullName'],
                  decoration: InputDecoration(
                    labelText: 'Enter Full Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: userData['email'],
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: userData['phoneNumber'],
                  decoration: InputDecoration(
                    labelText: 'Enter PhoneNumber',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: userData['address'],
                  decoration: InputDecoration(
                    labelText: 'Enter Address',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
