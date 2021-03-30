import 'package:shared_preferences/shared_preferences.dart';
import '../Games/Clicker.dart';
import '../Games/snake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Games extends StatefulWidget {
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  bool isLoaded = false ;
  bool clickerflag ;
  bool snakeflag ;
  void initState() {

    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      clickerflag = (prefs.getBool('clickerflag') ?? false);
      snakeflag = (prefs.getBool('snakeflag') ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded? Container() : Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,//.horizontal
              child: new Text(
                "Şuana kadar oynadığınız oyunlar. tekrar oynamak için tıklayın.",
              ),
            ),
          ),

        ),
        if(true) Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(body : ClickerSection()) ;
                    }),
                  );

                }),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Clicker",
                  ),
                ),
              )
          ),

        ),
        if(snakeflag) Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(body : snake()) ;
                    }),
                  );

                }),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Snake",
                  ),
                ),
              )
          ),
        ),
      ],
    );
  }
}