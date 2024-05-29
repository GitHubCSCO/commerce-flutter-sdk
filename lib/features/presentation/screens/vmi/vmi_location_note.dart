// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/vmi_location_note/vmi_location_note_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/vmi_location_note/vmi_location_note_state.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';

class VmiLocationNoteScreen extends StatelessWidget {
  final void Function() onVMILocationNoteUpdated;
  const VmiLocationNoteScreen({
    Key? key,
    required this.onVMILocationNoteUpdated,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<VMILocationNoteCubit>(),
        child: VmiLocationNotePage(
          onVMILocationNoteUpdated: onVMILocationNoteUpdated,
        ));
  }
}

class VmiLocationNotePage extends StatelessWidget {
  final void Function() onVMILocationNoteUpdated;
  VmiLocationNotePage({
    Key? key,
    required this.onVMILocationNoteUpdated,
  }) : super(key: key);
  final TextEditingController noteDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Location Note'),
        ),
        body: BlocListener<VMILocationNoteCubit, VmiLocationNoteState>(
          listener: (context, state) {
            if (state is VmiLocationNoteSavedSuccessState) {
              CustomSnackBar.showVMILocationNoteSaved(context);
              onVMILocationNoteUpdated();
              Navigator.pop(context);
            }
            if (state is VmiLocationNoteSavedFailureState) {
              CustomSnackBar.showVMILocationNoteNotSaved(context);
            }
          },
          child: BlocBuilder<VMILocationNoteCubit, VmiLocationNoteState>(
              builder: (context, state) {
            if (state is VmiLocationNoteLoadingState) {
              return Container(
                child: CircularProgressIndicator(),
              );
            } else if (state is VmiLocationNoteInitialState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Input(
                        label: LocalizationConstants.locationNote,
                        controller: noteDescriptionController,
                        onTapOutside: (p0) => context.closeKeyboard(),
                        onEditingComplete: () => context.closeKeyboard(),
                      ),
                    ),
                  ),
                  ListInformationBottomSubmitWidget(actions: [
                    SecondaryButton(
                      child: const Text(LocalizationConstants.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    PrimaryButton(
                      text: LocalizationConstants.save,
                      onPressed: () {
                        context.read<VMILocationNoteCubit>().saveLocationNote(
                              noteDescriptionController.text,
                            );
                      },
                    ),
                  ])
                ],
              );
            } else
              return Container();
          }),
        ));
  }
}
