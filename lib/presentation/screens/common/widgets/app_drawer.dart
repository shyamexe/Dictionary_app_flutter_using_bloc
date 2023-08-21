import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_dictionary/logic/theme_cubit/theme_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  static List<String> themeStrigs = ['Dark', 'Light', 'Sync with mobile'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData(
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Theme.of(context).primaryColor,
              expansionTileTheme: ExpansionTileThemeData(
                iconColor: Theme.of(context).primaryColor,
                collapsedIconColor: Theme.of(context).primaryColor,
              )),
          child: Container(
            width: 260,
            color: Theme.of(context).canvasColor,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      'Theme',
                      style: Theme.of(context).textTheme.bodyText2,
                      // style: TextStyle(
                      //   color: Theme.of(context).primaryColor
                      // ),
                    ),
                    children: [
                      Column(
                        children: List.generate(themeStrigs.length, (index) {
                          return InkWell(
                            onTap: () {
                              context.read<ThemeCubit>().updateTheme(index);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Row(
                                children: [
                                  Radio(
                                    activeColor: Theme.of(context).primaryColor,
                       
                                    value: themeStrigs[index],
                                    groupValue: themeStrigs[state.theme],
                                    onChanged: (value) {},
                                  ),
                                  Text(themeStrigs[index]),
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
