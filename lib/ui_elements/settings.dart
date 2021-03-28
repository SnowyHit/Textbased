import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key) ;
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _DeleteCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('counter');
      prefs.remove('point');
    });

    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 50),
        content: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text('Başarılı'),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  _Delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
    });

    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 50),
        content: Padding(
      padding: const EdgeInsets.all(13.0),
      child: Text('Başarılı'),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10 , 20, 10),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: null,
                onLongPress: _DeleteCounter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text("Hikayeyi başa sar."),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10 , 20, 10),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: null,
                onLongPress: _Delete,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text("Herşeyi sil."),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}