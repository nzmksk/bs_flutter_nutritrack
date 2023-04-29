part of 'expandable_fab_cubit.dart';

class ExpandableFABState extends Equatable {
  final bool isOpened;

  const ExpandableFABState({required this.isOpened});

  @override
  List<Object> get props => [isOpened];
}
