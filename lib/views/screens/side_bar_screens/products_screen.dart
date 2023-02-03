import 'package:flutter/material.dart';


class ProductScreen extends StatelessWidget {
  static const String routeName = '/products';


  Widget _rowHeader(String text, int flex){
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.yellow.shade900,
          border: Border.all(
            color: Colors.grey.shade700,
          ),
        ),
        child: Center(child: Text(text,style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),

          Row(
            children: [
              _rowHeader("IMAGE", 1),
              _rowHeader("NAME", 3),
              _rowHeader("PRICE", 2),
              _rowHeader("QUANTITY", 2),
              _rowHeader("ACTION", 1),
              _rowHeader("VIEW mORE", 1),
            ],
          ),

        ],
      ),
    );
  }
}
