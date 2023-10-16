
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void changeIndex(int index){
    emit(state.copyWith(currentIndex: index));
  }

  void shouldHideBottomBar(bool isHide){
    emit(state.copyWith(isHideBottomBar: isHide));
  }
}
