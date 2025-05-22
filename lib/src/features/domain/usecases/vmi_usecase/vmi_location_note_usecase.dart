import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VmiLocationNoteUsecase extends BaseUseCase {
  VmiLocationNoteUsecase() : super();

  Future<Result<VmiLocationModel, ErrorResponse>> saveLocationNote(
      String vmiLocationNote) async {
    var currentVmiLocation =
        coreServiceProvider.getVmiService().currentVmiLocation;

    currentVmiLocation?.note = vmiLocationNote;
    var response = await commerceAPIServiceProvider
        .getVmiLocationsService()
        .saveVmiLocation(currentVmiLocation!);
    switch (response) {
      case Success(value: final data):
        coreServiceProvider.getVmiService().currentVmiLocation = data;
        return Success(data!);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }
}
