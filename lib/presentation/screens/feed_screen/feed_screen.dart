import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_dictionary/core/constants/strings.dart';
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
        title:  Text(
          '1Dictionary',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
        builder: (context, state) {
          return state.data != null
              ? Padding(
                  padding:  EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: SelectableText(
                          '  ${state.data!.content}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: SelectableText(
                          '${state.data!.author}',
                          style: Theme.of(context).textTheme.bodyText1,
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
                            icon:  Icon(Icons.replay,color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                            onPressed: () {
                              Share.share('${state.data!.content} \n - ${state.data!.author}');
                            },
                            icon:  Icon(Icons.ios_share,color: Theme.of(context).primaryColor),
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
