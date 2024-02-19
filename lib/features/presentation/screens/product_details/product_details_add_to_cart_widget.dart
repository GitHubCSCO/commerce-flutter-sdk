import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsAddToCartWidget extends StatelessWidget {
  final ProductDetailAddtoCartEntity detailsAddToCartEntity;

  const ProductDetailsAddToCartWidget({required this.detailsAddToCartEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: AppStyle.neutral00,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return state.status == AuthStatus.authenticated
                  ? AddToCartSignInWidget()
                  : AddToCartNotSignedInWidget();
            },
          ),
        ),
      ),
    );
  }
}

class AddToCartSignInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                Container(
                  child: Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.grayBackgroundColor,
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Input(
                              onTapOutside: (context) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.grayBackgroundColor,
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('U/M'),
                      Text('E/A',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0))
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Subtotal'),
                      Text(
                        '11,44.00',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          PrimaryButton(
            child: const Text(LocalizationConstants.addToCart),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class AddToCartNotSignedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      child: const Text(LocalizationConstants.signInForAddToCart),
      onPressed: () {
        // context.push(AppRoute.login.path);
        AppRoute.login.navigate(context);
      },
    );
  }
}
