// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marques_construcao/vendor/views/screens/earnings_screen.dart';
import 'package:marques_construcao/vendor/views/screens/edit_products_screen.dart';
import 'package:marques_construcao/vendor/views/screens/upload_screen.dart';
import 'package:marques_construcao/vendor/views/screens/vendor_logout_screen.dart';
import 'package:marques_construcao/vendor/views/screens/vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.money_dollar,
                ),
                label: 'EARNINGS'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.upload,
                ),
                label: 'UPLOAD'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.edit,
                ),
                label: 'EDIT'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: 'ORDERS'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.logout,
                ),
                label: 'LOGOUT'),
          ]),
      body: Center(child: _pages[_pageIndex]),
    );
  }
}
