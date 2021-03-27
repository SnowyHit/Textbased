import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Games/QuestionAlgorithm.dart';
import '../Games/Clicker.dart';
import '../Games/snake.dart';
import 'package:provider/provider.dart';
import 'ad_unit.dart';
import 'settings.dart' ;


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
  @override

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Homescreen(),
    Settings(),
    QuestionWidget(),
    Help() ,
    SPrefs() ,
    Games(),
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
        child: _widgetOptions[_selectedIndex] ,
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
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Anasayfa'),
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(0);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Ayarlar'),
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ) ,
              ListTile(
                title: Text('Hikaye'),
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Yardım'),
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(3);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('SPREFS'),
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(4);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Oyunlar'),
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(5);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

            ],
          ),
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
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Image(
            image : AssetImage('Assets/gifs/book.gif'),
            width: 200.0,
            height: 200.0
        ),
        if(newPlayerFlag)
          Card(
            child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Araştırma oyununa hoşgeldiniz. Verdiğiniz her karak ajbnqwjodnmqpölfqğwfğ qkqmw fklqnkjn qkje nqwk nqken qwkjne jkqnwjnkqne kqwne kjqw"),
              ) ,
          )
        else
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Hikayeye devam edin , istatistik falan filan Hikayeye devam edin , istatistik falan filan Hikayeye devam edin , istatistik falan filan Hikayeye devam edin , istatistik falan filan Hikayeye devam edin , istatistik falan filan Hikayeye devam edin , istatistik falan filan "),
            ) , ),
          ) ,
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
    );
  }
}

class Games extends StatefulWidget {
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  bool isLoaded = false ;
  bool clickerflag ;
  bool snakeflag ;
  void initState() {

    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      clickerflag = (prefs.getBool('clickerflag') ?? false);
      snakeflag = (prefs.getBool('snakeflag') ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded? Container() : Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,//.horizontal
              child: new Text(
                "Şuana kadar oynadığınız oyunlar. tekrar oynamak için tıklayın.",
              ),
            ),
          ),

        ),
        if(clickerflag) Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(body : ClickerSection()) ;
                    }),
                  );

                }),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Clicker",
                  ),
                ),
              )
          ),

        ),
        if(snakeflag) Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(body : snake()) ;
                    }),
                  );

                }),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Snake",
                  ),
                ),
              )
          ),

        ),

      ],
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










