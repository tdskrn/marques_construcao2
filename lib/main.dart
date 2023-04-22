import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marques_construcao/firebase_options.dart';
import 'package:marques_construcao/vendor/views/screens/main_vendor_screen.dart';
import 'package:marques_construcao/views/buyers/auth/login_screen.dart';
import 'package:marques_construcao/views/buyers/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // deixa barra transparente
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marques Construção',
      theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'Brand-Bold'),
      home: LoginScreen(),
    );
  }
}
