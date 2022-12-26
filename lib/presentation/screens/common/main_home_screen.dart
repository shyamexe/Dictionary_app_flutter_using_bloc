import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  blurRadius: 20.w,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.h),
                child: GNav(
                  rippleColor: Theme.of(context).focusColor,
                  hoverColor: Theme.of(context).hoverColor,
                  gap: 8.w,
                  activeColor: Theme.of(context).primaryColor,
                  iconSize: 24.sp,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor:  Theme.of(context).bottomAppBarColor,
                  color: Theme.of(context).primaryColor,
                  tabs: const [
                    GButton(
                      icon: Icons.dashboard_outlined,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Likes',
                    ),
                    GButton(
                      icon: Icons.bookmarks_outlined,
                      text: 'Search',
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
