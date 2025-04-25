import 'dart:async';

import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/location_note_widget_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/location_note/location_note_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/location_note/location_note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LocationNoteWidget extends StatelessWidget {
  LocationNoteWidgetEntity locationNoteWidgetEntity;

  LocationNoteWidget({super.key, required this.locationNoteWidgetEntity});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationNoteCubit, LocationNoteState>(
        builder: (context, state) {
      if (state is LocationNoteLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LocationNoteLoadedState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                locationNoteWidgetEntity.title ?? "",
                style: OptiTextStyles.titleSmall,
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: state.locationNote.isNotEmpty,
                      child: Text(
                        state.locationNote,
                        style: OptiTextStyles.body,
                      ),
                    ),
                    Visibility(
                      visible: context.read<LocationNoteCubit>().isVmiAdmin() &&
                          state.locationNote.isEmpty,
                      child: Center(
                        child: Text(
                          LocalizationConstants.enterLocationNote
                              .localized()
                              .format([
                            LocalizationConstants.editLocationNote.localized()
                          ]),
                          style: OptiTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: context.read<LocationNoteCubit>().isVmiAdmin(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TertiaryButton(
                          borderColor: OptiAppColors.grayBackgroundColor,
                          backgroundColor: OptiAppColors.grayBackgroundColor,
                          text: LocalizationConstants.editLocationNote
                              .localized(),
                          onPressed: () async {
                            final result = await context.pushNamed(
                              AppRoute.vmilocaitonote.name,
                            );

                            if (result == true && context.mounted) {
                              unawaited(context
                                  .read<LocationNoteCubit>()
                                  .loadLocationNote());
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
