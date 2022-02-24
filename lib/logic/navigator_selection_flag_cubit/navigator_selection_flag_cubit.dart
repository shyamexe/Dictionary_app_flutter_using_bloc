import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigatorSelectionFlagState extends Equatable {
  int? pageValue;
   NavigatorSelectionFlagState({this.pageValue});

  @override
  List<Object> get props => [pageValue??1];
}

class NavigatorSelectionFlagInitial extends NavigatorSelectionFlagState {}

class NavigatorSelectionFlagCubit extends Cubit<NavigatorSelectionFlagState> {
  NavigatorSelectionFlagCubit() : super(NavigatorSelectionFlagState(pageValue: 1));

  selectPage(int page){
    emit(NavigatorSelectionFlagState(pageValue: page));
  }
}
