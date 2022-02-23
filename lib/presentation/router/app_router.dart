import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_dictionary/logic/search_word/search_word_cubit.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String home = '/';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchWordCubit(),
              ),
              
            ],
            child: HomeScreen(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
