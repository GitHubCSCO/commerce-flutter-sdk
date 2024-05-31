import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class LocationNoteUsecase extends BaseUseCase {
  LocationNoteUsecase() : super();

  String fetchLocationNote() {
    return coreServiceProvider.getVmiService().currentVmiLocation?.note ?? "";
  }
}
