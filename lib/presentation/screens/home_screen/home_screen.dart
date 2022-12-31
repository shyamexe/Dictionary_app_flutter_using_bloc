import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:one_dictionary/core/constants/widgets.dart';
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

  HomeScreen({Key? key}) : super(key: key);

  onSearch(context) {
    if (searchController.text.isNotEmpty) {
      BlocProvider.of<SearchWordCubit>(context)
          .storeData(searchController.text);
    }
  }

  void createSnackBar(
      {required String message, required BuildContext context}) {
    final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Theme.of(context).canvasColor);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      createSnackBar(message: 'Added to Saved List', context: context);
    }

    if (!isSaved) {
      box.add(wordSave);
    } else {
      createSnackBar(message: 'Already Added !', context: context);
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

  List<WordSave> list = [];

  deleteWord(word) {
    final box = Boxes.getWordToBox();
    box.values.toList().forEach((element) {
      if (word == element.word) {
        box.delete(element.key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<SearchWordCubit, SearchWordState>(
          listener: (context, state) {
            if (state is SearchWordNotFound) {
              var snackBar = SnackBar(
                content: Text(
                  'No results found for ${searchController.text}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Strings.appSoftBlue,
                elevation: 0,
                //size changed
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              FocusScope.of(context).requestFocus(focusNode);
            }
          },
          builder: (context, searchState) {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse
              }),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 50,
                                width: 270,
                                child: TypeAheadField(
                                  hideOnLoading: true,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    onEditingComplete: () {
                                      onSearch(context);
                                      FocusScope.of(context).unfocus();
                                    },
                                    focusNode: focusNode,
                                    controller: searchController,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            searchController.text.isNotEmpty
                                                ? InkWell(
                                                    onTap: () {
                                                      searchController.clear();
                                                      BlocProvider.of<
                                                                  SearchWordCubit>(
                                                              context)
                                                          .onClearText(
                                                              searchController
                                                                  .text);
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 15,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: 0,
                                                  ),
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).canvasColor,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        hintText: 'Search'),
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return await BackendService.getSuggestions(
                                        pattern);
                                  },
                                  itemBuilder: (context,
                                      Map<String, String> suggestion) {
                                    return ListTile(
                                      title: Text(
                                        suggestion['name']!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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
                      height: 20,
                    ),
                    searchState.data == null
                        ? const SizedBox()
                        : SizedBox(
                            width: 360,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SelectableText(
                                  "${searchState.data!.word}",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Text(
                                  searchState.data!.phonetics![0].text
                                      .toString(),
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
                                ValueListenableBuilder<Box<WordSave>>(
                                  valueListenable:
                                      Boxes.getWordToBox().listenable(),
                                  builder: (context, box, _) {
                                    list = box.values.toList().cast<WordSave>();
                                    var contain = list.where((element) =>
                                        element.word ==
                                        searchState.data!.word.toString());
                                    if (contain.isEmpty) {
                                      return IconButton(
                                        onPressed: () {
                                          addWordToBox(
                                              searchState.data!.word.toString(),
                                              context);
                                        },
                                        icon: Icon(
                                          Icons.bookmark_border,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      );
                                    } else {
                                      return IconButton(
                                        icon: Icon(
                                          Icons.bookmark_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          deleteWord(searchState.data!.word
                                              .toString());
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: searchState.data != null
                          ? ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20),
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
                                    searchState.data!.meanings![i]
                                                .definitions![0].example !=
                                            null
                                        ? AppWidgets.sizeHeight10
                                        : const SizedBox(),
                                    searchState.data!.meanings![i]
                                                .definitions![0].example !=
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
              ),
            );
          },
        ),
      ),
    );
  }
}
