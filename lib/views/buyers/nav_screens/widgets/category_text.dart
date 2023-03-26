import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categoryLabel = [
    'food',
    'vegan',
    'egg',
    'meet',
    'food',
    'vegan',
    'egg',
    'meet',
    'food',
    'vegan',
    'egg',
    'meet'
  ];

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryLabel.length,
                    itemBuilder: (context, index) {
                      return ActionChip(
                        backgroundColor: Colors.orange,
                        onPressed: () {},
                        label: Text(
                          _categoryLabel[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
