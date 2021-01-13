import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QuestionAlgorithm.dart';

void main() {
  runApp(MaterialApp(
    theme : ThemeData.dark() ,
    routes: {
      "/" : (context) => Home() ,
      "/questions" : (context) => QuestionWidget() ,
    },

  ) );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text("Oyuna Hoşgeldiniz.") ,
        centerTitle: true,
      ) ,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex:9 ,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Text("Oyun hakkında kısa bir açıklama ve önsöz. Sağ Taraftan Oyunu başlatabilirsiniz", )
                ),
              ],
            ),
          ),
          Expanded(
            flex:1 ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(

                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context , "/questions");
                      },
                      child: Icon(Icons.arrow_forward_outlined,
                        size: 20 ,
                        color: Colors.black ,
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}


