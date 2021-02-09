import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textbased/QuestionAlgorithm.dart';

class snake extends StatefulWidget {
  @override
  _snakeState createState() => _snakeState();
}

class _snakeState extends State<snake> {
  bool isLoaded = false ;
  bool Leaveflag = false ;
  @override
  void initState() {

    super.initState();
    _load();
  }

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      //_clicks = (prefs.getInt('clicks') ?? 0);
    });
  }

  _Leave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //prefs.setInt('counter', _counter);
      Leaveflag = true ;
    });
  }


  void _set() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //prefs.setInt('clicks', _clicks);
    });
  }


  @override
  Widget build(BuildContext context) {
    if (Leaveflag) {
      return QuestionWidget();
    }
    else {
      return !isLoaded ? Container() : Container() ;
    }
  }
}