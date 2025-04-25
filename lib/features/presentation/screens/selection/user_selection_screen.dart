import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/selection/user_selection/user_selection_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/selection_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class UserSelectionScreen extends StatelessWidget {
  final CatalogTypeSelectingParameter parameter;

  const UserSelectionScreen({
    super.key,
    required this.parameter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserSelectionCubit>()
        ..initialize(
          parameter: parameter,
        ),
      child: const UserSelectionPage(),
    );
  }
}

class UserSelectionPage extends StatelessWidget {
  const UserSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: Text(LocalizationConstants.selectUser.localized()),
        centerTitle: false,
      ),
      body: BlocBuilder<UserSelectionCubit, UserSelectionState>(
        builder: (context, state) {
          if (state.status == UserStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == UserStatus.failiure) {
            return Center(
              child: Text(LocalizationConstants.error.localized()),
            );
          }

          return ListView.separated(
            itemCount: state.userList?.length ?? 0,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final user = state.userList![index];
              return Container(
                color: OptiAppColors.backgroundWhite,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SelectionItemWidget(
                  item: user,
                  label: user.title ?? '',
                  isSelected: user.id == state.selectedId,
                  onCallBack: (context, selectedUser) {
                    context.read<UserSelectionCubit>().setSelectedUser(
                          selectedUser: selectedUser as CatalogTypeDto,
                        );

                    context.pop(selectedUser);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
