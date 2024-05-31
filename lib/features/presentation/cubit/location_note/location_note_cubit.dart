import 'package:commerce_flutter_app/features/domain/usecases/location_note_usecase/location_note_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/location_note/location_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationNoteCubit extends Cubit<LocationNoteState> {
  final LocationNoteUsecase _locationNoteUsecase;
  LocationNoteCubit({required LocationNoteUsecase locationNoteUsecase})
      : _locationNoteUsecase = locationNoteUsecase,
        super(LocationNoteInitialState());

  Future<void> loadLocationNote() async {
    final locationNote = _locationNoteUsecase.fetchLocationNote();
    emit(LocationNoteLoadedState(locationNote: locationNote));
  }
}
