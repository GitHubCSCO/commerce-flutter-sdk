import 'package:flutter/material.dart';

class PromoCodeWidget extends StatelessWidget {
  final String code;
  final String description;

  const PromoCodeWidget({
    required this.code,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                code,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(description),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Add your onTap code here
              },
              child: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
