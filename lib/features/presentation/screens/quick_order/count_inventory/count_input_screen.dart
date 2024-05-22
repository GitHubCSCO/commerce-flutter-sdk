import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CountInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountInputPage();
  }
}

class CountInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundGray,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(

      ),
    );
  }
}
