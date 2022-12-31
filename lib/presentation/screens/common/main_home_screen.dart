import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:one_dictionary/logic/navigator_selection_flag_cubit/navigator_selection_flag_cubit.dart';
import 'package:one_dictionary/logic/random_word/random_quote_cubit.dart';
import 'package:one_dictionary/logic/search_word/search_word_cubit.dart';
import 'package:one_dictionary/presentation/screens/feed_screen/feed_screen.dart';
import 'package:one_dictionary/presentation/screens/home_screen/home_screen.dart';
import 'package:one_dictionary/presentation/screens/save_words_screen/saved_words_screen.dart';

import 'widgets/app_drawer.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width > 600) {
      return Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2,2),
                  color: Theme.of(context).backgroundColor.withOpacity(.2),
                  blurRadius: 2,
                  spreadRadius: 5
                )
              ]
            ),
            padding: const EdgeInsets.only(
              bottom: 15,
              top: 5,
              left: 5,
              right: 5,
            ),
            child: SizedBox(
              width: 360,
              height: 690,
              child: MainWidget(),
            ),
          ),
        ),
      );
    } else {
      return MainWidget();
    }
  }
}

class MainWidget extends StatelessWidget {
  MainWidget({
    Key? key,
  }) : super(key: key);

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
          drawer: const AppDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              appTitles[state.pageValue ?? 1],
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: screens[state.pageValue ?? 1],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: GNav(
                  rippleColor: Theme.of(context).focusColor,
                  hoverColor: Theme.of(context).hoverColor,
                  gap: 8,
                  activeColor: Theme.of(context).primaryColor,
                  iconSize: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Theme.of(context).bottomAppBarColor,
                  color: Theme.of(context).primaryColor,
                  tabs: [
                    const GButton(
                      icon: Icons.dashboard_outlined,
                      text: 'Home',
                      iconSize: 18,
                      textSize: 10,
                    ),
                    const GButton(
                      icon: Icons.search,
                      text: 'Likes',
                      iconSize: 18,
                      textSize: 10,
                    ),
                    const GButton(
                      icon: Icons.bookmarks_outlined,
                      text: 'Search',
                      iconSize: 18,
                      textSize: 10,
                    ),
                  ],
                  selectedIndex: state.pageValue ?? 1,
                  onTabChange: (index) {
                    context
                        .read<NavigatorSelectionFlagCubit>()
                        .selectPage(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
