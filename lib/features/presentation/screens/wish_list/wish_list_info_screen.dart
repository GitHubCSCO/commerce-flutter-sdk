import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_information/wish_list_information_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      body: BlocConsumer<WishListInformationCubit, WishListInformationState>(
        listener: (context, state) {
          if (state.status == WishListStatus.listUpdateSuccess) {
            CustomSnackBar.showListUpdated(context);
            if (widget.onWishListUpdated != null) {
              widget.onWishListUpdated!();
            }
            Navigator.of(context).pop();
          }

          if (state.status == WishListStatus.listUpdateFailure) {
            CustomSnackBar.showUpdateFailed(context);
          }
        },
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: OptiAppColors.backgroundWhite,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListNameInputWidget(
                        listNameController: _listNameEditingController,
                        readOnly: !context
                            .watch<WishListInformationCubit>()
                            .canEditNameDesc,
                      ),
                      const SizedBox(height: 32),
                      ListDetailsWidget(wishList: state.wishList),
                      const SizedBox(height: 32),
                      ListDescriptionInputWidget(
                        listDescriptionController:
                            _listDescriptionEditingController,
                        readOnly: !context
                            .watch<WishListInformationCubit>()
                            .canEditNameDesc,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListInformationBottomSubmitWidget(actions: [
              PrimaryButton(
                text: LocalizationConstants.save,
                isEnabled:
                    context.watch<WishListInformationCubit>().canEditNameDesc,
                onPressed: () {
                  if (_listNameEditingController.text.isEmpty) {
                    displayDialogWidget(
                      context: context,
                      title: LocalizationConstants.error,
                      message: LocalizationConstants.enterListName,
                      actions: [
                        PlainButton(
                          child: const Text(LocalizationConstants.oK),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );

                    return;
                  }

                  context.read<WishListInformationCubit>().updateWishList(
                        name: _listNameEditingController.text,
                        description: _listDescriptionEditingController.text,
                      );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
