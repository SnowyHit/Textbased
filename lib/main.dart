import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebaseinit.dart' ;
import 'QuestionAlgorithm.dart';

void main() {
  runApp(MaterialApp(
    theme : ThemeData.dark() ,
    home: App(),
  ) );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuestionWidget(),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

