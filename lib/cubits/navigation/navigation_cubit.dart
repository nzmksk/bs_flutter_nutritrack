import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

enum NavBarItem {
  nutrition,
  exercise,
  logs,
  summary,
  profile,
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(
          const NavigationState(
            navBarItem: NavBarItem.logs,
            currentIndex: 2,
          ),
        );

  void getNavBarItem(NavBarItem navBarItem) {
    switch (navBarItem) {
      case NavBarItem.nutrition:
        emit(
          const NavigationState(
            navBarItem: NavBarItem.nutrition,
            currentIndex: 0,
          ),
        );
        break;
      case NavBarItem.exercise:
        emit(
          const NavigationState(
            navBarItem: NavBarItem.exercise,
            currentIndex: 1,
          ),
        );
        break;
      case NavBarItem.logs:
        emit(
          const NavigationState(
            navBarItem: NavBarItem.logs,
            currentIndex: 2,
          ),
        );
        break;
      case NavBarItem.summary:
        emit(
          const NavigationState(
            navBarItem: NavBarItem.summary,
            currentIndex: 3,
          ),
        );
        break;
      case NavBarItem.profile:
        emit(
          const NavigationState(
            navBarItem: NavBarItem.profile,
            currentIndex: 4,
          ),
        );
        break;
    }
  }
}
