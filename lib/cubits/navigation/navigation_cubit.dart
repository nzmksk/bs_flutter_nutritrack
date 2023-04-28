import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

enum NavBarItem { nutrition, exercise, logs, summary, profile }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavBarItem.logs, 2));

  void getNavBarItem(NavBarItem navBarItem) {
    switch (navBarItem) {
      case NavBarItem.nutrition:
        emit(const NavigationState(NavBarItem.nutrition, 0));
        break;
      case NavBarItem.exercise:
        emit(const NavigationState(NavBarItem.exercise, 1));
        break;
      case NavBarItem.logs:
        emit(const NavigationState(NavBarItem.logs, 2));
        break;
      case NavBarItem.summary:
        emit(const NavigationState(NavBarItem.summary, 3));
        break;
      case NavBarItem.profile:
        emit(const NavigationState(NavBarItem.profile, 4));
        break;
    }
  }
}
