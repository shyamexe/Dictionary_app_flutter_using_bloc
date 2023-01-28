import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_dictionary/data/models/word_save_model.dart';
import 'package:one_dictionary/logic/theme_cubit/theme_cubit.dart';
import 'core/themes/app_theme.dart';
import 'presentation/router/app_router.dart';

List theme = [
  ThemeMode.dark,
  ThemeMode.light,
  ThemeMode.system,
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordSaveAdapter());
  await Hive.openBox<WordSave>('WordSave');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: theme[state.theme],
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
