import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: Home() ,

  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("The game") ,
        centerTitle: true,
        backgroundColor: Colors.red[300],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal : 10 , vertical : 20),
        color: Colors.red[100] ,
        child: Text("KkK"), 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {} ,
        child: Text("askdks") ,
        backgroundColor: Colors.black12,
      ) ,
    );
  }
}

