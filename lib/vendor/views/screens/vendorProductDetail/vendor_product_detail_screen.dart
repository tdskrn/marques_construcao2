import 'package:flutter/material.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  VendorProductDetailScreen({super.key, required this.productData});

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final TextEditingController _productNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData['productName']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
