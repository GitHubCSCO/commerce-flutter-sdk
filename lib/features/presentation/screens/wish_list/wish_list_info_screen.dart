import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_information/wish_list_information_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListInformationScreen extends StatelessWidget {
  const WishListInformationScreen({
    super.key,
    required this.wishList,
    this.onWishListUpdated,
  });

  final WishListEntity wishList;
  final void Function()? onWishListUpdated;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<WishListInformationCubit>()..initialize(wishList: wishList),
      child: WishListInformationPage(
        wishList: wishList,
      ),
    );
  }
}

class WishListInformationPage extends StatefulWidget {
  final WishListEntity wishList;
  final void Function()? onWishListUpdated;

  const WishListInformationPage({
    super.key,
    required this.wishList,
    this.onWishListUpdated,
  });

  @override
  State<WishListInformationPage> createState() =>
      _WishListInformationPageState();
}

class _WishListInformationPageState extends State<WishListInformationPage> {
  late final TextEditingController _listNameEditingController;
  late final TextEditingController _listDescriptionEditingController;

  @override
  void initState() {
    super.initState();
    _listNameEditingController =
        TextEditingController(text: widget.wishList.name);
    _listDescriptionEditingController =
        TextEditingController(text: widget.wishList.description);
  }

  @override
  void dispose() {
    _listNameEditingController.dispose();
    _listDescriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text(LocalizationConstants.listInformation),
      ),
      body: Container(
        color: OptiAppColors.backgroundWhite,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListNameInputWidget(
              listNameController: _listNameEditingController,
              readOnly:
                  !context.watch<WishListInformationCubit>().canEditNameDesc,
            ),
            const SizedBox(height: 32),
            ListDetailsWidget(wishList: widget.wishList),
            const SizedBox(height: 32),
            ListDescriptionInputWidget(
              listDescriptionController: _listDescriptionEditingController,
              readOnly:
                  !context.watch<WishListInformationCubit>().canEditNameDesc,
            ),
          ],
        ),
      ),
    );
  }
}
