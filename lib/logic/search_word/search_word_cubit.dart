// ignore_for_file: must_be_immutable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:one_dictionary/data/data_providers/api_call.dart';
import 'package:one_dictionary/data/models/model.dart';


class SearchWordState extends Equatable {
  DictionaryModel? data;
  SearchWordState({this.data});

  @override
  List<Object> get props => [
        data ?? ""
      ];
}

class SearchWordInitial extends SearchWordState {}

class SearchWordNotFound extends SearchWordState{}
class SearchWordFailed extends SearchWordState{}

class SearchWordCubit extends Cubit<SearchWordState> {
  SearchWordCubit() : super(SearchWordInitial());

  storeData(key) async {
    final data = await ApiCallProvider().getWord(key);
    
    if(data != null){
      emit(SearchWordState(
      data: data,
    ));
    }else{
      emit(SearchWordNotFound());
      print('notfound');
      emit(SearchWordFailed());
    }

  }
}
