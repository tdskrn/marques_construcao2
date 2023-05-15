import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marques_construcao/views/buyers/nav_screens/category_screen.dart';
import 'package:marques_construcao/views/buyers/nav_screens/widgets/home_products.dart';
import 'package:marques_construcao/views/buyers/nav_screens/widgets/main_products_widget.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading categories');
              }
              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // assim eu pego o tamanho da lista da stream
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // assim que se pega em uma stream
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ActionChip(
                              backgroundColor: _selectedCategory ==
                                      categoryData['categoryName']
                                  ? Colors.red
                                  : Colors.orange,
                              onPressed: () {
                                setState(() {
                                  _selectedCategory ==
                                          categoryData['categoryName']
                                      ? _selectedCategory = null
                                      : _selectedCategory =
                                          categoryData['categoryName'];
                                });
                              },
                              label: Text(
                                categoryData['categoryName'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CategoryScreen();
                          },
                        ));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          _selectedCategory != null
              ? HomeProductWidget(categoryName: _selectedCategory!)
              : MainProductsScreen(),
        ],
      ),
    );
  }
}
