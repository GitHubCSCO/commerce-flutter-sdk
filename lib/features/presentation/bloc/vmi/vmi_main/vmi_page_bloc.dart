import 'package:commerce_flutter_sdk/features/domain/usecases/vmi_usecase/vmi_main_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/vmi/vmi_main/vmi_page_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/vmi/vmi_main/vmi_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMIPageBloc extends Bloc<VMIPageEvent, VMIPageState> {
  final VMIMainUseCase _vmiMainUseCase;

  VMIPageBloc({required VMIMainUseCase vmiMainUseCase})
      : _vmiMainUseCase = vmiMainUseCase,
        super(VMIPageInitialState()) {
    on<VMIPageLoadEvent>(_onVMIPageLoadEvent);
    on<VMILoacationLoadEvent>(_onVMILocationLoadEvent);
  }

  Future<void> _onVMIPageLoadEvent(
      VMIPageLoadEvent event, Emitter<VMIPageState> emit) async {
    emit(VMIPageLoadingState());
    var result = await _vmiMainUseCase.loadData();
    switch (result) {
      case Success(value: final data):
        emit(VMIPageLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        emit(VMIPageFailureState(errorResponse.errorDescription ?? ''));
    }
  }

  Future<void> _onVMILocationLoadEvent(
      VMILoacationLoadEvent event, Emitter<VMIPageState> emit) async {
    await _vmiMainUseCase.getClosestVmiLocation();
    emit(VMILoacationLoadedState());
  }
}
