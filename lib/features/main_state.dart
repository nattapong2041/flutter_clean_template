part of 'main_cubit.dart';

class MainState extends Equatable{
  final int currentIndex;
  final bool isHideBottomBar;

  const MainState({
    this.currentIndex = 0,
    this.isHideBottomBar = false,
  });

  copyWith({
    int? currentIndex,
    bool? isHideBottomBar,
  }) {
    return MainState(
      currentIndex: currentIndex ?? this.currentIndex,
      isHideBottomBar: isHideBottomBar ?? this.isHideBottomBar,
    );
  }

  @override
  List<Object?> get props => [
    currentIndex,
    isHideBottomBar,];
}