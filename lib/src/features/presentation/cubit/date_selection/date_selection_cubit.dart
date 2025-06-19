import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/utils/date_provider_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'date_selection_state.dart';

class DateSelectionCubit extends Cubit<DateSelectionState> {
  DateTime? date;

  DateSelectionCubit()
      : super(DateSelectionState(
            LocalizationConstants.selectDate.localized(), DateTime(0)));

  Future<void> onInitialDateSelect(DateTime? selectedDate) async {
    if (selectedDate != null) {
      var formattedDate = formatDateByLocale(selectedDate);
      date = selectedDate;
      emit(DateSelectionState(formattedDate, selectedDate));
    } else {
      emit(DateSelectionState(
          LocalizationConstants.selectDate.localized(), DateTime(0)));
    }
  }

  Future<void> onDateSelect(DateTime selectedDate) async {
    var formattedDate = formatDateByLocale(selectedDate);
    date = selectedDate;
    emit(DateSelectionState(formattedDate, selectedDate));
  }
}
