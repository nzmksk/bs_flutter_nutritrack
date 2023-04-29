import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expandable_fab_state.dart';

class ExpandableFABCubit extends Cubit<ExpandableFABState> {
  ExpandableFABCubit() : super(const ExpandableFABState(isOpened: false));

  void toggleButton() {
    emit(ExpandableFABState(isOpened: !state.isOpened));
  }
}
