import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_picker_state.dart';

class ListPickerCubit extends Cubit<ListPickerState> {

  int pickerIndex = 0;

  ListPickerCubit() : super(ListPickerState(0));

  Future<void> onInitialSelection(int? index) async {
    pickerIndex = index == -1 ? 0 : index ?? 0;
    emit(ListPickerState(pickerIndex));
  }

  Future<void> onPick(int index) async {
    pickerIndex = index;
    emit(ListPickerState(pickerIndex));
  }
}
