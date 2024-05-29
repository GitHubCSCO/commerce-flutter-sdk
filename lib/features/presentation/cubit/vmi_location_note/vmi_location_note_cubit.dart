import 'package:commerce_flutter_app/features/domain/usecases/vmi_usecase/vmi_location_note_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/vmi_location_note/vmi_location_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMILocationNoteCubit extends Cubit<VmiLocationNoteState> {
  final VmiLocationNoteUsecase _vmiLocationNoteUsecase;
  VMILocationNoteCubit({required VmiLocationNoteUsecase vmilocationNoteUsecase})
      : _vmiLocationNoteUsecase = vmilocationNoteUsecase,
        super(VmiLocationNoteInitialState());

  Future<void> saveLocationNote(String locationNote) async {
    var response = await _vmiLocationNoteUsecase.saveLocationNote(locationNote);

    switch (response) {
      case Success():
        {
          emit(VmiLocationNoteSavedSuccessState());
          break;
        }
      case Failure():
        {
          emit(VmiLocationNoteSavedFailureState());
          break;
        }
    }
  }
}
