import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QuestionAlgorithm.dart';
import 'package:toast/toast.dart';



void main()  {
    runApp(MaterialApp(
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

    ));
  }

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Homescreen(
        key : PageStorageKey("HomeScreen")
    ),
    Settings(
        key : PageStorageKey("Settings")
    ),
    QuestionWidget(
        key : PageStorageKey("QuestionWidget")
    ),
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
      body: PageStorage(
        child: _widgetOptions[_selectedIndex] ,
        bucket: bucket ,
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_outlined),
            label: 'Hikaye',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onItemTapped,
      ),

    );
  }
}
class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key) ;
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _DeleteCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
    });
    Toast.show("Silindi.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP  , backgroundColor : Colors.white10);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10 , 20, 10),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: null,
                onLongPress: _DeleteCounter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text("Kaydı sil."),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
class Homescreen extends StatefulWidget {
  const Homescreen({Key key}) : super(key: key) ;
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int promote ;
  bool isLoaded = false ;
  int _clicks ;
  List<String> promotions = [
    "Uyuyor",
    "İşçi" ,
    "Bölüm sorumlusu" ,
    "Patron" ,
    "Bölge patronu" ,
    "Uluslararası sorumlu" ,
    "Hissedar" ,
    "Şirket sahibi" ,
  ] ;

  void initState() {

    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      _clicks = (prefs.getInt('clicks') ?? 0);
      promote = (prefs.getInt('promote') ?? 0);
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
                " Double moon drive'a hoşgeldiniz. Burası Anasayfada yazılan yazıları içerir.",
              ),
            ),
          ),

        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,//.horizontal
              child: new Text(
                "Paran :  ${_clicks}",
              ),
            ),
          ),

        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,//.horizontal
              child: new Text(
                "Ünvanın :  ${promotions[promote]}",
              ),
            ),
          ),

        ),
      ],
    );
  }
}








