import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Clicker.dart';

class clickerInventory extends StatefulWidget {
  @override
  _clickerInventoryState createState() => _clickerInventoryState();
}

class _clickerInventoryState extends State<clickerInventory> {
  bool isLoaded =false ;
  int fur = 0 ;
  int meat = 0 ;
  int coin = 0 ;
  int luckOfFind ;
  int luckOfHunt ;
  int carryCapacityMultiplier ;
  int speedMod ;
  Map inventory ;
  List<String> items = [] ;
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
      items = (prefs.getStringList('items') ?? [] );
      meat = (prefs.getInt('meat') ?? 0);
      coin = (prefs.getInt('coin') ?? 0);
      luckOfFind = (prefs.getInt('luckOfFind') ?? 1);
      luckOfHunt = (prefs.getInt('luckOfHunt') ?? 1);
      carryCapacityMultiplier = (prefs.getInt('carryCapacityMultiplier') ?? 100);
      speedMod = (prefs.getInt('speedMod') ?? 1);
      coin = (prefs.getInt('coin') ?? 0);
      coin = (prefs.getInt('coin') ?? 0);
      coin = (prefs.getInt('coin') ?? 0);
      inventory =  _getInventory(items) ;
    });
  }

  void _save() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('fur', fur);
      prefs.setInt('meat', meat);
      prefs.setStringList('items', items);
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
                title: Text("Karakter"),
                background: Image(image: AssetImage('assets/items/Potion 1.png')),
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
                  return item(inventory.keys.toList()[index].toString() , inventory.values.toList()[index].toString() , false , 0) ;
                },
                childCount: inventory.length,
              ),
            ),
            if(_selectedIndex == 1)SliverGrid( //Sell
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildListDelegate(
                  [
                    Text("Koşu hızın : $speedMod "),
                    Text("Başarılı Av ihtimali : $luckOfHunt"),
                    Text("Av alanı bulma ihtimali : $luckOfFind"),
                    Text("Taşıma Kapasitesi : $carryCapacityMultiplier"),
                  ]
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business),
              label: 'Kullandıkların',
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

Widget item(String ID , String Amount , bool Sell , int townModifier) {
  Item selectedItem = _getItem(ID) ;
  print(ID) ;
  return Sell ?
  Container(
    alignment: Alignment.center,
    color: Colors.teal[100],
    child: Text(selectedItem.name + " fiyat : " + ((selectedItem.power * (selectedItem.type+1) *( selectedItem.id + 1)* townModifier * 8238149)~/24322342).toString()),
  )
      :
  Container(
    alignment: Alignment.center,
    color: Colors.teal[100],
    child: Text(_getItem(ID).name + " " + Amount),
  );
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

Map _getInventory(List<String> Sitems){
  var elements = Sitems ;
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
class Allitems{
  List<Item> AllitemsList =[
    Item("Kılıç" , 1 , 4 , 0) ,
    Item("Kılıç 2" , 1 , 34 , 1) ,
    Item("Kılıç 3" , 1 , 12 , 2) ,
    Item("Kılıç 4" , 1 , 51 , 3) ,
    Item("Kılıç 5" , 1 , 2 , 4) ,
    Item("Kılıç 6" , 1 , 5 , 5) ,
    Item("Kılıç 7" , 1 , 12 , 6) ,
    Item("Kılıç 8" , 1 , 5 , 7) ,
    Item("Kürk" , 1 , 0 , 8) ,
    Item("Et" , 1 , 0 , 9) ,
    Item("Kılıç 8" , 1 , 5 , 10) ,
  ];
  Item selected = Item("item not found", 0 , 0 , 999);


}
class Item{
  String name ;
  int power ;
  int type ;
  int id ;
  Item(String name , int power , int type , int id)
  {
    this.name = name ;
    this.power = power ;
    this.type = type;
    this.id = id ;
  }
}


//TODO buying items , selling items in your inventory