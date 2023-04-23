import 'package:flutter/material.dart';
import 'package:marques_construcao/provider/product_provider.dart';
import 'package:marques_construcao/vendor/views/screens/upload_tab_screens/attributes_screen.dart';
import 'package:marques_construcao/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:marques_construcao/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:marques_construcao/vendor/views/screens/upload_tab_screens/shipping_screen.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade900,
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('General'),
                ),
                Tab(
                  child: Text('Shipping'),
                ),
                Tab(
                  child: Text('Attributes'),
                ),
                Tab(
                  child: Text('Images'),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            GeneralScreen(),
            ShippingScreen(),
            AttributesTabScreen(),
            ImagesTabScreen(),
          ]),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('tudo validado');
                }
              },
              child: Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}
