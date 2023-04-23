import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marques_construcao/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List _categories = [];

  getCategories() async {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categories.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    // é assim que chamamos o provider
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Product Name';
                  }
                  if (value.length < 6) {
                    return 'Name is too short';
                  }
                  return null;
                },
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: "Enter Product Name",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Product Price';
                  }
                  if (double.parse(value) < 0) {
                    return 'The value is not accept';
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  _productProvider.getFormData(
                      productPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: "Enter Product Price",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter with a quantity';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Quantity must not be less than 0';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _productProvider.getFormData(quantity: int.parse(value));
                },
                decoration: InputDecoration(
                  labelText: "Enter Product Quantity",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              DropdownButtonFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Selected one category';
                  }

                  return null;
                },
                hint: Text('Select Category'),
                items: _categories.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _productProvider.getFormData(category: value);
                  });
                },
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter with one description';
                  }

                  return null;
                },
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                maxLines: 10,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: 'Enter Product Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(5000))
                            .then((value) {
                          _productProvider.getFormData(scheduleDate: value);
                        });
                      },
                      child: Text('Schedule')),
                  if (_productProvider.productData['scheduleDate'] != null)
                    Text(formatedDate(
                        _productProvider.productData['scheduleDate']))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
