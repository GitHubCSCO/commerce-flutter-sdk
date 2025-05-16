import 'dart:async';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_information/wish_list_information_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_information/wish_list_tags_controller_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WishListInformationScreen extends BaseStatelessWidget {
  const WishListInformationScreen({
    super.key,
    required this.wishList,
  });

  final WishListEntity wishList;

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = sl<WishListInformationCubit>();
            unawaited(cubit.initialize(wishList: wishList));
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => sl<WishListTagsControllerCubit>()
            ..initialize(
              wishListTags: wishList.wishListTags ?? [],
            ),
        ),
      ],
      child: WishListInformationPage(
        wishList: wishList,
      ),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() {
    return AnalyticsEvent(
      AnalyticsConstants.eventViewListInformation,
      AnalyticsConstants.screenNameListDetail,
    ).withProperty(
      name: AnalyticsConstants.eventPropertyListId,
      strValue: wishList.id,
    );
  }
}

class WishListInformationPage extends StatefulWidget {
  final WishListEntity wishList;

  const WishListInformationPage({
    super.key,
    required this.wishList,
  });

  @override
  State<WishListInformationPage> createState() =>
      _WishListInformationPageState();
}

class _WishListInformationPageState extends State<WishListInformationPage> {
  late final TextEditingController _listNameEditingController;
  late final TextEditingController _listDescriptionEditingController;
  late FocusNode _tagInputFocusNode;

  @override
  void initState() {
    super.initState();
    _listNameEditingController =
        TextEditingController(text: widget.wishList.name);
    _listDescriptionEditingController =
        TextEditingController(text: widget.wishList.description);
    _initFocusNode();
  }

  void _initFocusNode() {
    _tagInputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _listNameEditingController.dispose();
    _listDescriptionEditingController.dispose();
    _disposeFocusNode();
    super.dispose();
  }

  void _disposeFocusNode() {
    if (_tagInputFocusNode.hasListeners) {
      _tagInputFocusNode.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: OptiAppColors.backgroundWhite,
        title: Text(LocalizationConstants.listInformation.localized()),
      ),
      body: Container(
        color: OptiAppColors.backgroundWhite,
        child: SafeArea(
          child:
              BlocConsumer<WishListInformationCubit, WishListInformationState>(
            listener: (context, state) {
              if (state.status == WishListStatus.listUpdateSuccess) {
                CustomSnackBar.showSnackBarMessage(
                  context,
                  LocalizationConstants.listUpdated.localized(),
                );

                context.pop(true);
              }

              if (state.status == WishListStatus.listUpdateFailure) {
                CustomSnackBar.showSnackBarMessage(
                  context,
                  LocalizationConstants.updateFailed.localized(),
                );
              }
            },
            builder: (context, state) => Stack(
              children: [
                Column(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              const SizedBox(height: 32),
                              Stack(
                                children: [
                                  Input(
                                    label:
                                        LocalizationConstants.tags.localized(),
                                    hintText: LocalizationConstants
                                        .searchOrAddTag
                                        .localized(),
                                  ),
                                  Positioned.fill(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        context
                                            .read<WishListTagsControllerCubit>()
                                            .startEditing();
                                        // Make sure we have a valid focus node
                                        if (!_tagInputFocusNode.hasListeners) {
                                          _initFocusNode();
                                        }
                                        // Request focus on the second input field
                                        _tagInputFocusNode.requestFocus();
                                      },
                                      // Transparent overlay that covers the entire Input
                                      child: Container(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              if (state.wishList.wishListTags != null &&
                                  state.wishList.wishListTags!.isNotEmpty)
                                _WishListTagsWidget(context: context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListInformationBottomSubmitWidget(
                      actions: [
                        PrimaryButton(
                          text: LocalizationConstants.save.localized(),
                          isEnabled: context
                              .watch<WishListInformationCubit>()
                              .canEditNameDesc,
                          onPressed: () {
                            if (_listNameEditingController.text.isEmpty) {
                              displayDialogWidget(
                                context: context,
                                title: LocalizationConstants.error.localized(),
                                message: LocalizationConstants.enterListName
                                    .localized(),
                                actions: [
                                  PlainButton(
                                    text: LocalizationConstants.oK.localized(),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );

                              return;
                            }

                            unawaited(
                              context
                                  .read<WishListInformationCubit>()
                                  .updateWishList(
                                    name: _listNameEditingController.text,
                                    description:
                                        _listDescriptionEditingController.text,
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (context.watch<WishListTagsControllerCubit>().state
                    is WishListTagsControllerEditing)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: OptiAppColors.backgroundWhite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Input(
                                  label: LocalizationConstants.tags.localized(),
                                  hintText: LocalizationConstants.searchOrAddTag
                                      .localized(),
                                  autoFocusNode: _tagInputFocusNode,
                                  onTap: () {
                                    CustomSnackBar.showSnackBarMessage(
                                      context,
                                      'Coming Soon',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListInformationBottomSubmitWidget(
                          actions: [
                            SecondaryButton(
                              text: LocalizationConstants.cancel.localized(),
                              onPressed: () {
                                // Safely dispose the focus node before removing from the tree
                                _disposeFocusNode();
                                _initFocusNode();

                                context
                                    .read<WishListTagsControllerCubit>()
                                    .initialize(
                                      wishListTags:
                                          widget.wishList.wishListTags ?? [],
                                    );
                              },
                            ),
                            PrimaryButton(
                              text: LocalizationConstants.save.localized(),
                              isEnabled: true,
                              onPressed: () {
                                CustomSnackBar.showSnackBarMessage(
                                  context,
                                  'Coming Soon',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WishListTagsWidget extends StatelessWidget {
  final BuildContext context;

  const _WishListTagsWidget({
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListInformationCubit, WishListInformationState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocalizationConstants.assignedTags.localized()),
            const SizedBox(height: 8),
            ListView.builder(
              itemCount: state.wishList.wishListTags!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AssetConstants.iconTag),
                          const SizedBox(width: 16),
                          Text(
                            state.wishList.wishListTags![index].tag ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          CustomSnackBar.showSnackBarMessage(
                            context,
                            'Tag Cleared',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AssetConstants.iconXmark,
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
