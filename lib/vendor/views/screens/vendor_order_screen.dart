import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormat = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormat.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.yellow.shade900,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14,
                      child: document['accepted'] == true
                          ? Icon(
                              Icons.delivery_dining,
                            )
                          : Icon(
                              Icons.access_time,
                            ),
                    ),
                    title: document['accepted'] == true
                        ? Text(
                            'Accepted',
                            style: TextStyle(color: Colors.yellow.shade900),
                          )
                        : Text(
                            'Not Accepted',
                            style: TextStyle(color: Colors.red),
                          ),
                    trailing: Text(
                      'Amount ' +
                          'R\$ ' +
                          document['productPrice'].toStringAsFixed(2),
                      style: TextStyle(fontSize: 17, color: Colors.blue),
                    ),
                    subtitle: Text(
                      formatedDate(document['orderDate'].toDate()),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Order Details',
                      style: TextStyle(
                        color: Colors.yellow.shade900,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text('View Order Details'),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(document['productImage'][0]),
                        ),
                        title: Text(document['productName']),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  ('Quantity'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(document['quantity'].toString())
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
