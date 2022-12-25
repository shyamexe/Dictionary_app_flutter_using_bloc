import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import 'package:one_dictionary/core/constants/widgets.dart';
import 'package:one_dictionary/core/themes/app_theme.dart';
import 'package:one_dictionary/data/data_providers/box.dart';
import 'package:one_dictionary/data/data_providers/data_suggestion.dart';
import 'package:one_dictionary/data/models/model.dart';
import 'package:one_dictionary/data/models/word_save_model.dart';
import 'package:one_dictionary/logic/search_word/search_word_cubit.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/constants/strings.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final searchController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  var focusNode = FocusNode();
  onSearch(context) {
    if (searchController.text.isNotEmpty) {
      BlocProvider.of<SearchWordCubit>(context)
          .storeData(searchController.text);
    }
  }

  addWordToBox(String word, context) {
    final box = Boxes.getWordToBox();
    bool isSaved = false;
    final wordSave = WordSave()
      ..word = word
      ..saveDate = DateTime.now();

    List<WordSave> wordlist = box.values.toList();

    for (var i = 0; i < wordlist.length; i++) {
      if (word == wordlist[i].word) {
        isSaved = true;
        continue;
      }
    }

    if (!isSaved) {
      box.add(wordSave);
    } else {
      // var snackBar = const SnackBar(content: Text('Already Added !'));

      var snackBar = SnackBar(
        content: const Text(
          'Already Added !',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Strings.appSoftBlue,
        elevation: 0,
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.4.h,
            horizontal: 20.w),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  player(List<Phonetics> list) async {
    String? url;
    for (var i = 0; i < list.length; i++) {
      if (list[i].audio != null) {
        url = list[i].audio.toString();
        continue;
      }
    }
    await audioPlayer.play(url ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '1Dictionary',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocConsumer<SearchWordCubit, SearchWordState>(
          listener: (context, state) {
            if (state is SearchWordNotFound) {
              var snackBar = SnackBar(
                content: Text(
                  'No results found for ${searchController.text}',
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Strings.appSoftBlue,
                elevation: 0,
                //size changed
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              FocusScope.of(context).requestFocus(focusNode);
            }
          },
          builder: (context, searchState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50.h,
                              //sdhgiuadgfiuadg
                              width: 270.w,
                              child: TypeAheadField(
                                hideOnLoading: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  onEditingComplete: () {
                                    onSearch(context);
                                    FocusScope.of(context).unfocus();
                                  },
                                  focusNode: focusNode,
                                  controller: searchController,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context).canvasColor,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.w),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.w),
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.w),
                                          borderSide: BorderSide.none),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.w),
                                          borderSide: BorderSide.none),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.w),
                                          borderSide: BorderSide.none),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.w),
                                          borderSide: BorderSide.none),
                                      hintStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      hintText: 'Search'),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return await BackendService.getSuggestions(
                                      pattern);
                                },
                                itemBuilder:
                                    (context, Map<String, String> suggestion) {
                                  return ListTile(
                                    title: Text(
                                      suggestion['name']!,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  );
                                },
                                onSuggestionSelected:
                                    (Map<String, String> suggestion) {
                                  searchController.text = suggestion['name']!;
                                  onSearch(context);
                                },
                              )),
                          // InkWell(
                          //   onTap: () {
                          //     onSearch(context);
                          //     FocusScope.of(context).unfocus();
                          //   },
                          //   child: Container(
                          //     color: Strings.appDarkBlue,
                          //     height: 50,
                          //     width: 55,
                          //     child: const Icon(
                          //       Icons.check,
                          //       color: Color(0xFFFFFFFF),
                          //     ),
                          //   ),
                          // )
                        ],
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  searchState.data == null
                      ? const SizedBox()
                      : SizedBox(
                          width: 360.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SelectableText(
                                "${searchState.data!.word}",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Text(
                                searchState.data!.phonetics![0].text.toString(),
                                style: Theme.of(context).textTheme.headline1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              IconButton(
                                onPressed: () {
                                  player(searchState.data!.phonetics!);
                                },
                                icon: Icon(
                                  Icons.volume_up_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  addWordToBox(
                                      searchState.data!.word.toString(),
                                      context);
                                },
                                icon: Icon(
                                  Icons.bookmark_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    child: searchState.data != null
                        ? ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: searchState.data!.meanings!.length,
                            itemBuilder: (context, i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppWidgets.sizeHeight10,
                                  SelectableText(
                                    '${searchState.data!.meanings![i].partOfSpeech}',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  AppWidgets.sizeHeight10,
                                  SelectableText(
                                    '${searchState.data!.meanings![i].definitions![0].definition}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  searchState.data!.meanings![i].definitions![0]
                                              .example !=
                                          null
                                      ? AppWidgets.sizeHeight10
                                      : const SizedBox(),
                                  searchState.data!.meanings![i].definitions![0]
                                              .example !=
                                          null
                                      ? SelectableText(
                                          'Example - ${searchState.data!.meanings![i].definitions![0].example}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        )
                                      : const SizedBox(),
                                ],
                              );
                            },
                          )
                        : LottieBuilder.asset('assets/meditating.json'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
