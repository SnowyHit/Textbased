

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class clickerMarketSection extends StatefulWidget {
  @override
  _clickerMarketSectionState createState() => _clickerMarketSectionState();
}

class _clickerMarketSectionState extends State<clickerMarketSection> {
  bool isLoaded =false ;
  int fur = 0 ;
  int meat = 0 ;
  int coin = 0 ;
  String townName = "Default asd asdsa" ;
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
                title: Text(townName),
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
              delegate: SliverChildListDelegate(
                  [
                    _addCard('Cookie mint', 10 , 'assets/items/Armor 1.png', 1 , 10 ,  context),
                  ]
              ),
              // delegate: SliverChildBuilderDelegate(
              //       (BuildContext context, int index) {
              //     return Container(
              //       alignment: Alignment.center,
              //       color: Colors.teal[100 * (index % 9)],
              //       child: Text('grid item $index'),
              //     );
              //   },
              //   childCount: 20,
              // ),
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
                   TextButton(onPressed: ((){
                     _sellFur(1, 1) ;
                   }), child: Text("Kürk Sat ($fur)")
                   ),
                    TextButton(onPressed: ((){
                      _sellMeat(1, 1) ;
                    }), child: Text("Et Sat ($meat)")
                    ),
                  ]
              ),
              // delegate: SliverChildBuilderDelegate(
              //       (BuildContext context, int index) {
              //     return Container(
              //       alignment: Alignment.center,
              //       color: Colors.teal[100 * (index % 9)],
              //       child: Text('grid item $index'),
              //     );
              //   },
              //   childCount: 20,
              // ),
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
Widget _addCard(String name, int price, String imgPath, int itemType , int power ,  context ) {
  return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
          onTap: () {
            //itempage(name, price , imgPath , itemType , power) ;
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                        tag: imgPath,
                        child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.fill)))),
                    SizedBox(height: 7.0),
                    Text(price.toString() + "Altın",
                        style: TextStyle(
                            color: Color(0xFFCC8053),
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Text(name,
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  ]))));
}

Widget itempage(String name, int price, String imgPath , int itemtype , int power)
{
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(name),
            centerTitle: true,
          ),
          body: Container(),
        )
    ) ;
}
