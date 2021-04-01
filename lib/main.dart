import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Games/Clicker.dart';
import 'Games/QuestionAlgorithm.dart';
import 'package:provider/provider.dart';
import 'ui_elements/ad_unit.dart';
import 'ui_elements/settings.dart' ;
import 'ui_elements/Games.dart' ;


void main()  {
    WidgetsFlutterBinding.ensureInitialized();
    final initFuture = MobileAds.instance.initialize();
    final adState = AdState(initFuture);
    runApp(
        Provider.value(
          value: adState,
          builder: (context , child) => Matapp(),
        )
    );
  }

class Matapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        theme : ThemeData.dark().copyWith(
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
            ),
          ),
          textTheme: TextTheme(
            button: TextStyle(
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              color : Colors.white ,
              fontSize: 20 ,
            ),
          ),
        ),
        home : Home(),


      ) ;

  }
}


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BannerAd banner;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context) ;
    adState.initialization.then((status){
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId ,
          size: AdSize.banner ,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }
  @override

  int _selectedIndex = 0;
  String fabtext = "" ;
  bool newPlayerFlag = true ;
  void initState() {

    super.initState();
    _load();
  }

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      newPlayerFlag = (prefs.getBool('clickerflag') ?? true);
      if(newPlayerFlag){
        fabtext = "Hikayeye Başla !" ;
      }
      else{
        fabtext = "Devam et .." ;
      }
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Homescreen(),
    Settings(),
    Help() ,
    Games(),
    SPrefs() ,
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title: Text("A R A Ş T I R M A"), centerTitle: true,),
      body: PageStorage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _widgetOptions[_selectedIndex],
            if(banner == null)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 100,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(
                  height: 50,
                  child: AdWidget(ad:banner),
                ),
              ) ,

          ],
        ) ,
        bucket: bucket ,
      ) ,
      drawer: SafeArea(
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(height: 200,) ,
              Card(
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Anasayfa'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(0);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              Card(
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Ayarlar'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(1);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ) ,

              Card(
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Yardım'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(2);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.all_inclusive),
                  title: Text('Oyunlar'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(3);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('Sprefs'),
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(4);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

            ],
          ),
        ),

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50 ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Scaffold(
                    body : QuestionWidget() ,
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return  Home() ;
                          }),
                        );
                      },
                      child: const Icon(Icons.home),
                      backgroundColor: Colors.lightGreen,
                    ),
                ) ;
              }),
            );
          },
          label: Text(fabtext),
          icon: Icon(Icons.arrow_forward_ios_outlined),
          backgroundColor: Colors.lightGreen,
        ),
      ),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key key}) : super(key: key) ;
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool newPlayerFlag = true ;
  void initState() {

    super.initState();
    _load();
  }

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      newPlayerFlag = (prefs.getBool('clickerflag') ?? true);
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Image(
              image : AssetImage('assets/gifs/book.gif'),
              width: 200.0,
              height: 200.0
          ),
          if(newPlayerFlag)
            Card(
              child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Araştırma oyununa hoşgeldiniz.Bu seçim üzerine kurulu hikaye oyununda , yaptığınız seçimler hikayenin gidişatını belirleyecek. Aynı seçimlere göre karşınıza çıkan zorlukları'da yenmek zorunda kalacaksınız. Eğer hazırsan .."),
                ) ,
            )
          else
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Şuana kadar yaptığın şeyler ; \n - Hikayeye başladın."),
              ) , ),
            ) ,
        ],
      ),
    );
  }
}


class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child:
    Center(
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
                "Oyun Hikaye kısmından ilerler , seçim yapmak için seçiminize basılı tutmanız yeterli. \n\n Oyunlar Butonunda hikaye içinde kilidini açtığınız oyunları görebilirsiniz " ,
              ),
            ),
          )

    );
  }
}

class SPrefs extends StatelessWidget {
  Future<List<Widget>> getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .map<Widget>((key) => ListTile(
      title: Text(key),
      subtitle: Text(prefs.get(key).toString()),
    ))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Widget>>(
          future: getAllPrefs(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return ListView(
              children: snapshot.data,
            );
          }),
    );
  }
}










