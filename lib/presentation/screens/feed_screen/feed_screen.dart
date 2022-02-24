import 'package:flutter/material.dart';
import 'package:one_dictionary/core/constants/strings.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('1Dictionary',style: TextStyle(color: Strings.appDarkBlue),),
        ),
        ) 
    );
  }
}