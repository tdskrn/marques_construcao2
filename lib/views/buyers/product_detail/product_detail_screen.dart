import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marques_construcao/provider/cart_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImage = 0;
  String? _selectedSize;

  // função que formata data
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  msgSize() {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hey, you have the choose one size at least')));
  }

  msgSucessAddProduct() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(widget.productData['productName'] + ' added with success!')));
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.productData['productName'],
            style: TextStyle(
              letterSpacing: 3,
            ),
          ),
          elevation: 2,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: PhotoView(
                      imageProvider: NetworkImage(
                        widget.productData['imageUrlList'][_selectedImage],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['imageUrlList'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImage = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow.shade900,
                                  ),
                                ),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                    widget.productData['imageUrlList'][index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // tem que chamar widget pra acessar variaveis final recebidas por
              // parametro, pois elas estao no mais alto nivel da arvore
              Text(
                'R\$ ' + widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow.shade900,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.productData['productName'],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Product Description',
                      style: TextStyle(
                        color: Colors.yellow.shade900,
                      ),
                    ),
                    Text(
                      'View More',
                      style: TextStyle(
                        color: Colors.yellow.shade900,
                      ),
                    ),
                    //
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.productData['description'],
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey.shade600,
                        letterSpacing: 3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'This Product Will be Shipping On',
                      style: TextStyle(
                        color: Colors.yellow.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      formatedDate(
                        widget.productData['scheduleDate'].toDate(),
                      ),
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                title: Text('Available Size'),
                children: [
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedSize =
                                    widget.productData['sizeList'][index];
                              });
                            },
                            child: Text(widget.productData['sizeList'][index]));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                if (_selectedSize == null) {
                  return msgSize();
                }
                _cartProvider.addProductToCart(
                  widget.productData['productName'],
                  widget.productData['productId'],
                  widget.productData['imageUrlList'],
                  1,
                  widget.productData['quantity'],
                  widget.productData['productPrice'],
                  widget.productData['vendorId'],
                  _selectedSize!,
                  widget.productData['scheduleDate'],
                );

                msgSucessAddProduct();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.cart,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
