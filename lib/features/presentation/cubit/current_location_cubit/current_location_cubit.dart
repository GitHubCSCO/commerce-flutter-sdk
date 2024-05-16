import 'package:commerce_flutter_app/features/domain/usecases/curent_location_usecase/current_location_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  final CurrentLocationUseCase _currentLocationUseCase;

  CurrentLocationCubit({required CurrentLocationUseCase currentLocationUseCase})
      : _currentLocationUseCase = currentLocationUseCase,
        super(CurrentLocationInitialState());

  Future<void> onLoadLocationData() async {}
}
