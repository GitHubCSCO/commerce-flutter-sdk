abstract class LocationNoteState {}

class LocationNoteInitialState extends LocationNoteState {}

class LocationNoteLoadingState extends LocationNoteState {}

class LocationNoteLoadedState extends LocationNoteState {
  final String locationNote;
  LocationNoteLoadedState({
    required this.locationNote,
  });

  get locationNoteDataEntity => null;
}
