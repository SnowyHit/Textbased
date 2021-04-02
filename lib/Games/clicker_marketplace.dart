
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clicker_Inventory.dart';

class clickerMarketSection extends StatefulWidget {
  @override
  _clickerMarketSectionState createState() => _clickerMarketSectionState();
}

class _clickerMarketSectionState extends State<clickerMarketSection> {
  bool isLoaded =false ;
  int fur = 0 ;
  int meat = 0 ;
  int coin = 0 ;
  int _metre = 0 ;
  String townName = "Default asd asdsa" ;
  int currentTown = 0 ;
  int townSeed = 145928 ;
  List<String> items = [] ;
  List<String> townNames = [
    "Antox" ,
    "Krasin" ,
    "Baili" ,
    "Pyto" ,
    "Antia" ,
    "Inia" ,
    "Oinell" ,
    "Ukuel" ,
    "Tyn" ,


    "Z'tari" ,
    "Folnir" ,
    "Bato" ,
    "Pxti" ,
    "Slynn" ,
    "Dmira" ,
    "Krisia" ,



    "Kails" ,
    "Ryn" ,
    "Setria" ,
  ] ;
  @override
  void initState() {

    super.initState();
    _load();
  }


  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      fur = (prefs.getInt('fur') ?? 0);
      meat = (prefs.getInt('meat') ?? 0);
      coin = (prefs.getInt('coin') ?? 0);
      _metre = (prefs.getInt('clicks') ?? 0);
      items = (prefs.getStringList('items') ?? [] );
      currentTown = (_metre ~/ 10000) % townNames.length ;
    });
  }

  void _save() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('fur', fur);
      prefs.setInt('meat', meat);
    });
  }
  void _sellFur(int Volume , int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(fur >= Volume)
        {
          fur -= Volume ;
          coin += Volume*value ;
        }
      prefs.setInt('fur', fur);
      prefs.setInt('coin', coin);
    });
  }
  void _sellMeat(int Volume , int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(meat >= Volume)
        {
          meat -= Volume ;
          coin += Volume*value ;
        }
      prefs.setInt('meat', meat);
      prefs.setInt('coin', coin);
    });
  }
  void _buy() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

    });
  }
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return !isLoaded ? Scaffold(body: Container(),) : SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 160.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(townNames[currentTown]),
                background: Image(image: AssetImage('assets/items/blacksmith.jpg')),
              ),
            ),
            if(_selectedIndex == 0)SliverGrid( // Buy
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: (townSeed * 2 ) ~/ 3 ,
            ),
            ),
            if(_selectedIndex == 1)SliverGrid( // Buy
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return item(items[index]) ;
                },
                childCount: items.length ,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_rounded),
              label: 'Çanta',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}



