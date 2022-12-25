import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_dictionary/logic/navigator_selection_flag_cubit/navigator_selection_flag_cubit.dart';
import 'package:one_dictionary/logic/random_word/random_quote_cubit.dart';
import 'package:one_dictionary/logic/search_word/search_word_cubit.dart';
import 'package:one_dictionary/presentation/screens/feed_screen/feed_screen.dart';
import 'package:one_dictionary/presentation/screens/home_screen/home_screen.dart';
import 'package:one_dictionary/presentation/screens/save_words_screen/saved_words_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  static List<String> appTitles = ['1Dictionary', '1Dictionary', 'Saved Words'];

  List<Widget> screens = [
    BlocProvider(
      create: (context) => RandomQuoteCubit(),
      child: const FeedScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchWordCubit(),
        ),
        BlocProvider(
          create: (context) => SearchWordCubit(),
        ),
      ],
      child: HomeScreen(),
    ),
    const SavedWordsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorSelectionFlagCubit,
        NavigatorSelectionFlagState>(
      builder: (context, state) {
        return Scaffold(

          drawer: Container(
            color: Colors.red,
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color:  Theme.of(context).primaryColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              appTitles[state.pageValue ?? 1],
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          
          resizeToAvoidBottomInset: false,
          body: screens[state.pageValue ?? 1],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: state.pageValue ?? 1,
            onTap: (index) {
              context.read<NavigatorSelectionFlagCubit>().selectPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), label: "feed"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Dictionary'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmarks_outlined), label: 'saved words'),
            ],
          ),
        );
      },
    );
  }
}
