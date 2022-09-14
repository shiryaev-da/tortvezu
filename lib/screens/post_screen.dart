import 'package:flutter/material.dart';
import 'package:tortvezu/cards/reuseble_card.dart';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/screens/katolog_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Container(
          height: 40.0,
          width: 40.0,
          child: FittedBox(
            child:  FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => KatologScreen()
                )
                );
              },
              backgroundColor: kMainBackGroundColor,
              child: Icon(Icons.arrow_back_ios ),
              highlightElevation: 10.0,
            ),
          ),
        ),
        backgroundColor: kMainBackGroundColor,
      body: NoPostData()
    );

  }
}
