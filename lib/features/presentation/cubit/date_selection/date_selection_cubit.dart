import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'date_selection_state.dart';

class DateSelectionCubit extends Cubit<DateSelectionState> {
  DateTime? date;

  DateSelectionCubit() : super(DateSelectionState(LocalizationConstants.selectDate, DateTime(0)));

  Future<void> onDateSelect(DateTime selectedDate) async {
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    date = selectedDate;
    emit(DateSelectionState(formattedDate, selectedDate));
  }

}
