part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final NavBarItem navBarItem;
  final int currentIndex;

  const NavigationState({
    required this.navBarItem,
    required this.currentIndex,
  });

  @override
  List<Object> get props => [
        navBarItem,
        currentIndex,
      ];
}
