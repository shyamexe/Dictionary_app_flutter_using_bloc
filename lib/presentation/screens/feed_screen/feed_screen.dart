import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_dictionary/core/constants/strings.dart';
import 'package:one_dictionary/core/themes/app_theme.dart';
import 'package:one_dictionary/logic/random_word/random_quote_cubit.dart';
import 'package:share_plus/share_plus.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          '1Dictionary',
          style: TextStyle(color: Strings.appDarkBlue),
        ),
      ),
      body: BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
        builder: (context, state) {
          return state.data != null
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(
                          '  ${state.data!.content}',
                          style: MyTextStyle.bodyText1,
                        ),
                        subtitle: Text(
                          '${state.data!.author}',
                          style: const TextStyle(color: Strings.appBlue),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<RandomQuoteCubit>().generate();
                            },
                            icon: const Icon(Icons.replay,color: Colors.grey),
                          ),
                          IconButton(
                            onPressed: () {
                              Share.share('${state.data!.content} \n - ${state.data!.author}');
                            },
                            icon: const Icon(Icons.ios_share,color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator(color: Strings.appMidGrey,));
        },
      ),
    ));
  }
}
