import 'package:flutter/material.dart';

class ActionGridItemWidget extends StatelessWidget {
  final int type;
  const ActionGridItemWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            child: Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Text(
              getTitle(type),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTitle(int type) {
    return type % 2 == 0 ? "Categories" : "Cafe Valet® Barista Single-Serve Coffee Maker";
    // return "Categories";
  }

}