import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textbased/QuestionAlgorithm.dart';

class ClickerSection extends StatefulWidget {
  @override
  _ClickerSectionState createState() => _ClickerSectionState();
}

class _ClickerSectionState extends State<ClickerSection> {
  bool isLoaded = false ;
  int _clicks = 0;
  int _counter = 5 ;
  bool flag = false ;
  @override
  void initState() {

    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      _clicks = (prefs.getInt('clicks') ?? 0);
    });
  }

  _Leave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('counter', _counter);
      flag = true ;
    });
  }


  void _incrementClicks() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _clicks++;
      prefs.setInt('clicks', _clicks);
      print(_clicks);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      return QuestionWidget();
    }
    else {
      return !isLoaded ? Container() : Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kazandığın para.',
            ),
            Text(
              '$_clicks',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
            TextButton.icon(onPressed: () {
              _incrementClicks();
            }, icon: Icon(Icons.attach_money_rounded), label: Text("Kazan"),),
            TextButton.icon(onPressed: () {
                _Leave();
            }, icon: Icon(Icons.airport_shuttle), label: Text("Yeterli"),)
          ],
        ),
      );
    }
  }
}
