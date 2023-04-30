import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProductWidget extends StatelessWidget {
  // Ela é passada por parametro para poder filtrar os produtos
  final String categoryName;

  const HomeProductWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: categoryName)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        return Container(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final productData = snapshot.data!.docs[index];
              // return Text(productData['productName']);

              return Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 170,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            productData['imageUrlList'][0],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        productData['productName'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'R\$ ' + productData['productPrice'].toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, _) {
              return SizedBox(
                width: 15,
              );
            },
            itemCount: snapshot.data!.docs.length,
          ),
        );
      },
    );
  }
}
