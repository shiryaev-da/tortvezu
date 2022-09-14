import 'package:flutter/material.dart';
import 'screens/start_screen.dart';
import 'package:tortvezu/screens/katolog_screen.dart';
import 'constants.dart';
import 'package:tortvezu/screens/test_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 // runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TORTVEZU',
      theme: ThemeData.dark().copyWith(
        primaryColor: kMainBackGroundColor,
        scaffoldBackgroundColor: kMainBackGroundColor,
      ),
      //home: SecondRoute(),
       home: StartScreen(),
      //home: MyApp123(),
    );
  }
}
