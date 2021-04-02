import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
                  return item(items[index]) ;
                },
                childCount: items.length ,
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

Widget item(String ID) {
  return Container(
    alignment: Alignment.center,
    color: Colors.teal[100],
    child: Text('ID : $ID'),
  );
}
//TODO buying items , selling items in your inventory , making inventory uniq(stacking items)