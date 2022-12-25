// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final int theme;
  const ThemeState(
    this.theme,
  );

  @override
  List<Object> get props => [theme];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(int theme) : super(theme);
}


class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial(2));

  updateTheme(int index){
    emit(ThemeState(index));
    emit(ThemeInitial(index));
  }
}
