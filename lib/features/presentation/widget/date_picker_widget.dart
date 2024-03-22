import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/date_selection/date_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerWidget extends StatelessWidget {

  final DateTime? maxDate;

  const DatePickerWidget({super.key, required this.maxDate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DateSelectionCubit>(
      create: (context) => sl<DateSelectionCubit>(),
      child: PickDate(maxDate: maxDate),
    );
  }

}

class PickDate extends StatelessWidget {

  final DateTime? maxDate;

  const PickDate({super.key, required this.maxDate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionCubit, DateSelectionState>(
      builder: (context, state) {
        return TextButton(onPressed: () {
          final firstDate = DateTime.now();
          final lastDate = maxDate ?? DateTime(2100);
          _selectRequestDeliveryDate(context, firstDate, lastDate);
        }, child: Text(
          state.dateString,
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ));
      },
    );
  }

  void _selectRequestDeliveryDate(BuildContext context, DateTime firstDate,
      DateTime lastDate) async {
    final initialDate = context
        .read<DateSelectionCubit>()
        .date ?? DateTime.now();

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