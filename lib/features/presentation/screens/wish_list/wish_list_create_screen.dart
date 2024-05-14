import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_create/wish_list_create_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListCreateScreen extends StatelessWidget {
  const WishListCreateScreen({
    super.key,
    this.onWishListCreated,
    this.addToCartCollection,
  });

  final void Function()? onWishListCreated;
  final WishListAddToCartCollection? addToCartCollection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WishListCreateCubit>(),
      child: WishListCreatePage(
        onWishListCreated: onWishListCreated,
        addToCartCollection: addToCartCollection,
      ),
    );
  }
}

class WishListCreatePage extends StatefulWidget {
  final void Function()? onWishListCreated;
  final WishListAddToCartCollection? addToCartCollection;

  const WishListCreatePage({
    super.key,
    this.onWishListCreated,
    this.addToCartCollection,
  });

  @override
  State<WishListCreatePage> createState() => _WishListCreatePageState();
}

class _WishListCreatePageState extends State<WishListCreatePage> {
  final TextEditingController _listNameEditingController =
      TextEditingController();
  final TextEditingController _listDescriptionEditingController =
      TextEditingController();

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
        title: const Text(LocalizationConstants.createNewList),
      ),
      body: BlocConsumer<WishListCreateCubit, WishListCreateState>(
        listener: (context, state) {
          if (state.status == WishListStatus.listCreateSuccess) {
            CustomSnackBar.showSnackBarMessage(
              context,
              LocalizationConstants.listCreated,
            );
            if (widget.onWishListCreated != null) {
              widget.onWishListCreated!();
            }
            context.pop();
          }

          if (state.status == WishListStatus.listCreateFailure) {
            displayDialogWidget(
              context: context,
              title: LocalizationConstants.error,
              message: LocalizationConstants.somethingWentWrong,
              actions: [
                PlainBlackButton(
                  child: const Text(LocalizationConstants.oK),
                  onPressed: () => context.pop(),
                ),
              ],
            );
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
                      ),
                      const SizedBox(height: 32),
                      ListDescriptionInputWidget(
                        listDescriptionController:
                            _listDescriptionEditingController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListInformationBottomSubmitWidget(
              actions: [
                SecondaryButton(
                  child: const Text(LocalizationConstants.cancel),
                  onPressed: () {
                    context.pop();
                  },
                ),
                PrimaryButton(
                  text: LocalizationConstants.create,
                  onPressed: () {
                    context.read<WishListCreateCubit>().createWishList(
                          name: _listNameEditingController.text,
                          description: _listDescriptionEditingController.text,
                          addToCartCollection: widget.addToCartCollection,
                        );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
