import 'package:flutter/material.dart';

class CartContentProductImageWidget extends StatelessWidget {
  final String imagePath;
  const CartContentProductImageWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26.0, 22.0, 0.0, 0.0),
      child: Container(
        width: 65,
        height: 65,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFD6D6D6)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.network(
            imagePath,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
