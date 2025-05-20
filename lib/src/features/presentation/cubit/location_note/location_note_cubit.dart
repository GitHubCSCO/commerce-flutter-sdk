import 'package:commerce_flutter_sdk/src/features/domain/usecases/location_note_usecase/location_note_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/location_note/location_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LocationNoteCubit extends Cubit<LocationNoteState> {
  final LocationNoteUsecase _locationNoteUsecase;
  Account? account;
  LocationNoteCubit({required LocationNoteUsecase locationNoteUsecase})
      : _locationNoteUsecase = locationNoteUsecase,
        super(LocationNoteInitialState());

  Future<void> loadLocationNote() async {
    final locationNote = _locationNoteUsecase.fetchLocationNote();
    var accountResponse = await _locationNoteUsecase.getCurrentAccount();
    account = (accountResponse is Success)
        ? (accountResponse as Success).value as Account
        : null;
    emit(LocationNoteLoadedState(locationNote: locationNote));
  }

  bool isVmiAdmin() {
    return account?.vmiRole == "VMI_Admin";
  }
}
