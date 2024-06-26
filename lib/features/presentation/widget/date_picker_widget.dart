import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/date_selection/date_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerWidget extends StatelessWidget {
  final void Function(BuildContext context, DateTime dateTime)? callback;
  final DateTime? selectedDateTime;
  final DateTime? maxDate;

  const DatePickerWidget(
      {super.key,
      required this.maxDate,
      required this.selectedDateTime,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DateSelectionCubit>(
      create: (context) =>
          sl<DateSelectionCubit>()..onInitialDateSelect(selectedDateTime),
      child: PickDate(maxDate: maxDate, callback: callback),
    );
  }
}

class PickDate extends StatelessWidget {
  final void Function(BuildContext context, DateTime dateTime)? callback;
  final DateTime? maxDate;

  const PickDate({super.key, required this.maxDate, required this.callback});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DateSelectionCubit, DateSelectionState>(
      listener: (context, state) {
        if (callback != null) {
          callback!(context, state.dateTime!);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            final firstDate = DateTime.now();
            final lastDate = maxDate ?? DateTime(2100);
            _selectRequestDeliveryDate(context, firstDate, lastDate);
          },
          child: Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors
                      .white), // Optional: Add a border to make the area more visible
              borderRadius:
                  BorderRadius.circular(4.0), // Optional: Add a border radius
            ),
            child: BlocBuilder<DateSelectionCubit, DateSelectionState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.dateString,
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.body,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _selectRequestDeliveryDate(
      BuildContext context, DateTime firstDate, DateTime lastDate) async {
    final initialDate =
        context.read<DateSelectionCubit>().date ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      Future.delayed(const Duration(seconds: 0), () {
        context.read<DateSelectionCubit>().onDateSelect(pickedDate);
      });
    }
  }
}
