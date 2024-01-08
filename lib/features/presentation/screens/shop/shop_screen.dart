import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopBloc = BlocProvider.of<ShopPageBloc>(context);
    shopBloc.add(
        const ShopPageLoadEvent()); // Add this line to call the event at first

    return BlocConsumer<ShopPageBloc, ShopPageState>(
      listener: (context, state) {
        // Add your listener logic here
      },
      builder: (context, state) {
        // Add your builder logic here
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                // Add your button's onPressed logic here
              },
              child: const Text('shop'),
            ),
          ),
        );
      },
    );
  }
}
