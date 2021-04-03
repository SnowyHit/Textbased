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
  List<String> equippedItems ;
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
      items = (prefs.getStringList('items') ?? [] );
      equippedItems = (prefs.getStringList('equippedItems')  ?? ["0" ,"1","2","3"]) ;
      inventory =  _getInventory(items) ;
      coin = (prefs.getInt('coin') ?? 0);
      luckOfFind = _getItem(equippedItems[3]).power;
      luckOfHunt = _getItem(equippedItems[2]).power;
      carryCapacityMultiplier = _getItem(equippedItems[1]).power;
      speedMod = _getItem(equippedItems[0]).power;
    });
  }

  _unequip( int Type ,String ID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;

    equippedItems[Type] = "-1" ;
    items.add(ID) ;
    setState(() {

      prefs.setStringList('equippedItems', equippedItems) ;
      prefs.setStringList('items', items) ;
      if(inventory.containsKey(ID))
          {
            inventory[ID] += 1 ;
          }
      else
         {
           inventory[ID] = 1 ;
         }

      luckOfFind = _getItem(equippedItems[3]).power;
      luckOfHunt = _getItem(equippedItems[2]).power;
      carryCapacityMultiplier = _getItem(equippedItems[1]).power;
      speedMod = _getItem(equippedItems[0]).power;

    });
  }
  _equipItem(int Type , String ID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(int.parse(equippedItems[Type])>= 0 ) { _unequip(Type , equippedItems[Type]) ; }
    isLoaded = true;
    equippedItems[Type] = ID ;
    setState(() {
     prefs.setStringList('equippedItems', equippedItems) ;
     prefs.setStringList('items', items) ;
     items.remove(ID) ;
     inventory[ID] -= 1 ;
     if(inventory[ID] <= 0)
     {
       inventory.remove(ID);
     }
     luckOfFind = _getItem(equippedItems[3]).power;
     luckOfHunt = _getItem(equippedItems[2]).power;
     carryCapacityMultiplier = _getItem(equippedItems[1]).power;
     speedMod = _getItem(equippedItems[0]).power;
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
                  return item(inventory.keys.toList()[index].toString() , inventory.values.toList()[index].toString() , false , 0 , _equipItem) ;
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
                    if(int.parse(equippedItems[0]) >= 0)Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100],
                      child: Column(
                        children: [
                          Text(_getItem(equippedItems[0]).name),
                          TextButton(onPressed: ((){
                              _unequip( _getItem(equippedItems[0]).type , equippedItems[0] ) ;
                            }
                          ), child: Text("Çıkar")) ,
                        ],
                      ),
                    ),
                     if(int.parse(equippedItems[1]) > 0)Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100],
                      child: Column(
                        children: [
                          Text(_getItem(equippedItems[1]).name),
                          TextButton(onPressed: ((){
                              _unequip( _getItem(equippedItems[1]).type , equippedItems[1] ) ;
                            }
                          ), child: Text("Çıkar")) ,
                        ],
                      ),
                    ),
                     if(int.parse(equippedItems[2]) > 0)Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100],
                      child: Column(
                        children: [
                          Text(_getItem(equippedItems[2]).name),
                          TextButton(onPressed: ((){
                              _unequip( _getItem(equippedItems[2]).type , equippedItems[2] ) ;
                            }
                          ), child: Text("Çıkar")) ,
                        ],
                      ),
                    ),
                     if(int.parse(equippedItems[3]) > 0)Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100],
                      child: Column(
                        children: [
                          Text(_getItem(equippedItems[3]).name),
                          TextButton(onPressed: ((){
                              _unequip( _getItem(equippedItems[3]).type , equippedItems[3] ) ;
                            }
                          ), child: Text("Çıkar")) ,
                        ],
                      ),
                    ),

                    Text("Koşu hızın : ${speedMod}"),
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
          selectedItemColor: Colors.lightGreen,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

Widget item(String ID , String Amount , bool Sell , int townModifier , onTap) {
  Item selectedItem = _getItem(ID) ;
  return Sell ? //TODO if selected item type == 1 == 2 == 3 == 0 then its equipable
  Container(
    alignment: Alignment.center,
    color: Colors.teal[100],
    child: Column(
      children: [
        Text(selectedItem.name + "adet : $Amount fiyat : " + ((selectedItem.power * (selectedItem.type+1) *( selectedItem.id + 1)* townModifier * 8238149)~/24322342).toString()),
        TextButton(onPressed: ((){
          if(onTap != null){
            onTap(ID) ;
          }
        }), child: Text("Sat")) ,
      ],
    ),
  ) :
  Container(
    alignment: Alignment.center,
    color: Colors.teal[100],
    child: Column(
      children: [
        Text(selectedItem.name + " adet : $Amount "),
        if(selectedItem.type < 4)TextButton(onPressed: ((){
          if(onTap != null){
          onTap(selectedItem.type , ID ) ;
          }
        }), child: Text("Giy")) ,
      ],
    ),
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
    Item("Çıplak" , 1 , 0 , -1) ,
    Item("Çöp ayakkabı" , 2 , 0 , 0) ,
    Item("Dandik Sihirli Çanta" , 2 , 1 , 1) ,
    Item("Basit Kılıç" , 10 , 2 , 2) ,
    Item("Basit Gözlük" , 10 , 3 , 3) ,
    Item("Basit item 1" , 1 , 5 , 4) ,
    Item("Basit item 2" , 1 , 5 , 5) ,
    Item("Basit item 3" , 1 , 5 , 6) ,
    Item("Basit item 4" , 1 , 5 , 7) ,
    Item("Kürk" , 1 , 5 , 8) ,
    Item("Et" , 1 , 5 , 9) ,
    Item("Basit item 5" , 1 , 5 , 10) ,
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