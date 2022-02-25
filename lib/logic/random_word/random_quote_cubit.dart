import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:one_dictionary/data/data_providers/api_call.dart';
import 'package:one_dictionary/data/models/random_quote_model.dart';

class RandomQuoteState extends Equatable {
  RandomQuoteModel? data;
  RandomQuoteState({this.data});

  @override
  List<Object> get props => [data??""];
}

class RandomQuoteInitial extends RandomQuoteState {}


class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  RandomQuoteCubit() : super(RandomQuoteInitial()){
    generate();
  }

  generate()async{
    emit(RandomQuoteState(data:await ApiCallProvider().getQuote()));
  }
}
