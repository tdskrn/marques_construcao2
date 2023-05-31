import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marques_construcao/firebase_options.dart';
import 'package:marques_construcao/provider/cart_provider.dart';
import 'package:marques_construcao/provider/product_provider.dart';
// import 'package:marques_construcao/vendor/views/auth/vendor_auth.dart';
// import 'package:marques_construcao/vendor/views/screens/main_vendor_screen.dart';
import 'package:marques_construcao/views/buyers/auth/login_screen.dart';
// import 'package:marques_construcao/views/buyers/main_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marques Construção',
        theme:
            ThemeData(primarySwatch: Colors.orange, fontFamily: 'Brand-Bold'),
        home: LoginScreen(),
        // home: VendorAuthScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
