import 'package:commerce_flutter_app/features/domain/usecases/platform_usecase/platform_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'load_website_url_event.dart';
part 'load_website_url_state.dart';

class LoadWebsiteUrlBloc extends Bloc<LoadWebsiteUrlEvent, LoadWebsiteUrlState> {
  final PlatformUseCase _platformUsecase;

  LoadWebsiteUrlBloc({required PlatformUseCase platformUsecase})
      : _platformUsecase = platformUsecase,
        super(LoadWebsiteUrlInitialState()) {
    on<LoadWebsiteUrlLoadEvent>(_onLoadWebsiteUrlLoadEvent);
  }

  Future<void> _onLoadWebsiteUrlLoadEvent(
      LoadWebsiteUrlLoadEvent event, Emitter<LoadWebsiteUrlState> emit) async {
    emit(LoadWebsiteUrlInitialState());
    var result = await _platformUsecase.getAuthorizedURL(event.redirectUrl);
    if(result!=null){
      emit(LoadWebsiteUrlLoadedState(authorizedURL: result));
    }else{
      emit(LoadWebsiteUrlFailureState('Failed to load url'));
    }
  }
}
