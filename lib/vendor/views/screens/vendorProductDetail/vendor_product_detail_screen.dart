import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  VendorProductDetailScreen({super.key, required this.productData});

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _brandNameController.text = widget.productData['brandName'];
      _productDescriptionController.text = widget.productData['description'];
      _quantityController.text = widget.productData['quantity'].toString();
      _productPriceController.text =
          widget.productData['productPrice'].toStringAsFixed(2);
      _productCategoryController.text = widget.productData['category'];
    });

    super.initState();
  }

  // double? productPrice;
  // int? productQuantity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData['productName']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _brandNameController,
                decoration: InputDecoration(
                  labelText: 'Brand Name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _productPriceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLength: 800,
                maxLines: 3,
                controller: _productDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: false,
                controller: _productCategoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: InkWell(
        onTap: () async {
          EasyLoading.show(status: 'Waiting');
          await _firestore
              .collection('products')
              .doc(widget.productData['productId'])
              .update({
            'productName': _productNameController.text,
            'brandName': _brandNameController.text,
            'quantity': int.parse(_quantityController.text),
            'productPrice': double.parse(_productPriceController.text),
            'description': _productDescriptionController.text,
          }).whenComplete(() {
            EasyLoading.dismiss();
            Navigator.pop(context);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.yellow.shade900,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Center(
              child: Text(
                'UPDATE PRODUCT',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
