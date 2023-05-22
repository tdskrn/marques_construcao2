import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../vendorProductDetail/vendor_product_detail_screen.dart';

class UnpublishedTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorProductsStream = FirebaseFirestore
        .instance
        .collection('products')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where(
          'approved',
          isEqualTo: false,
        )
        .snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _vendorProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Colors.yellow.shade900,
            );
          }

          return Container(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final vendorProductData = snapshot.data!.docs[index];
                return Slidable(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VendorProductDetailScreen(
                              productData: vendorProductData,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.network(
                                vendorProductData['imageUrlList'][0]),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                vendorProductData['productName'],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "R\$ " +
                                    vendorProductData['productPrice']
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    dismissible: DismissiblePane(
                      onDismissed: () {},
                    ),
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          await _firestore
                              .collection('products')
                              .doc(vendorProductData['productId'])
                              .update({
                            'approved': true,
                          });
                        },
                        backgroundColor: Colors.yellow.shade900,
                        foregroundColor: Colors.white,
                        icon: Icons.approval_sharp,
                        label: 'Published',
                      ),
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          await _firestore
                              .collection('products')
                              .doc(vendorProductData['productId'])
                              .delete();
                        },
                        backgroundColor: Colors.red.shade900,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
