import 'package:flutter_bloc/flutter_bloc.dart';

part 'domain_selection_state.dart';

class DomainSelectionCubit extends Cubit<DomainSelectionState> {
  DomainSelectionCubit() : super(DomainSelectionInitial());
}
