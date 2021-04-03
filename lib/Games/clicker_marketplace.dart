
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'clicker_Inventory.dart';
import 'Clicker.dart';

class clickerMarketSection extends StatefulWidget {
  @override
  _clickerMarketSectionState createState() => _clickerMarketSectionState();
}

class _clickerMarketSectionState extends State<clickerMarketSection> {
  bool isLoaded =false ;
  int coin = 0 ;
  int _metre = 0 ;
  String townName = "Default asd asdsa" ;
  int currentTown = 0 ;
  int townSeed = 14 ;
  List<String> items = [] ;
  Map inventory ;
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
      coin = (prefs.getInt('coin') ?? 0);
      _metre = (prefs.getInt('clicks') ?? 0);
      items = (prefs.getStringList('items') ?? [] );
      inventory =  _getInventory(items) ;
      if(currentTown < (_metre ~/ 10000) % townNames.length)
      {
        currentTown = (_metre ~/ 10000) % townNames.length;
        townSeed = _random(39) ;
      }


    });
  }
  int _random(int Range){
    Random dice = Random() ;
    return dice.nextInt(Range);
  }

  void _buy() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

    });
  }
  void _sellItem(String ID) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Item selectedItem = _getItem(ID) ;
    items.remove(ID) ;
    coin += ((selectedItem.power * (selectedItem.type+1) *( selectedItem.id + 1)* (townSeed+currentTown) * 8238149)~/24322342) ;
    setState(() {
        prefs.setInt('coin', coin);
        prefs.setStringList('items', items) ;
        inventory[ID] -= 1 ;
        if(inventory[ID] <= 0)
          {
            inventory.remove(ID);
          }
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
                  return item(inventory.keys.toList()[index].toString() , inventory.values.toList()[index].toString() , true , townSeed+currentTown , _sellItem) ;
                },
                childCount: inventory.length ,
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


Map _getInventory(List<String> itemsList){
  var elements = itemsList ;
  var map = Map();

  elements.forEach((element) {
    if(!map.containsKey(element)) {
      map[element] = 1;
    } else {
      map[element] +=1;
    }
  });

  return map ;
}


Item _getItem(String ID){
  Item selected = itemList.selected ;
  itemList.AllitemsList.forEach((element) {
    if(element.id == int.parse(ID))
    {
      selected =  element  ;
    }
  }
  ) ;
  return selected ;
}



