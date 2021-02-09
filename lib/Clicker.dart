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
  int promote= 1 ;
  int _clicks = 0;
  int _counter = 5 ;
  bool clickerflag ;
  List<String> promotions = [
    "Uyuyor",
    "İşçi" ,
    "Bölüm sorumlusu" ,
    "Patron" ,
    "Bölge patronu" ,
    "Uluslararası sorumlu" ,
    "Hissedar" ,
    "Şirket sahibi" ,
  ] ;
  int _promote() {
    int x = 1 ;
    if(_clicks > 100) {x =  2 ; }
    if(_clicks > 1000) {x=  3 ; }
    if(_clicks > 10000) {x =  4 ; }
    if(_clicks > 100000) {x =  5 ; }
    if(_clicks > 1000000) {x =  6 ; }
    if(_clicks > 10000000) {x =  7 ; }
    return x ;
  }
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
      promote = (prefs.getInt('promote') ?? 0);
      clickerflag = (prefs.getBool('clickerflag') ?? false);
    });
  }

  _Leave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('counter', _counter);
      prefs.setInt('promote', promote);
      prefs.setBool('clickerflag', true);
      flag = true ;
    });
  }


  void _incrementClicks() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      promote = _promote() ;
      print(promote);
      _clicks = _clicks + (promote*10);
      prefs.setInt('clicks', _clicks);
      prefs.setInt('promote', promote);
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Ünvanın : ${promotions[promote]}',),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Kazandığın para : $_clicks'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 50,
                child: TextButton.icon(onPressed: () {
                  _incrementClicks();
                  print("Something");
                }, icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.attach_money_rounded),
                ), label: Text("Kazan"),),
              ),
            ),
            if(!clickerflag) TextButton.icon(onPressed: () {
                _Leave();
            }, icon: Icon(Icons.airport_shuttle), label: Text("Yeterli"),)
          ],
        ),
      );
    }
  }
}
