part of 'appbar_title_cubit.dart';

class AppBarTitleState extends Equatable {
  final String appBarTitle;
  final int currentIndex;

  const AppBarTitleState({
    required this.appBarTitle,
    required this.currentIndex,
  });

  @override
  List<Object> get props => [
        appBarTitle,
        currentIndex,
      ];
}
