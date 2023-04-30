import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appbar_title_state.dart';

List<String> titles = [
  'Nutrition Info',
  'Exercise Info',
  'Calorie Logs',
  'Summary',
  'Profile',
];

class AppBarTitleCubit extends Cubit<AppBarTitleState> {
  AppBarTitleCubit()
      : super(
          AppBarTitleState(
            appBarTitle: titles[2],
            currentIndex: 2,
          ),
        );

  void getAppBarTitle(int index) {
    emit(
      AppBarTitleState(
        appBarTitle: titles[index],
        currentIndex: index,
      ),
    );
  }
}
