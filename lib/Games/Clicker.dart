import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textbased/Games/clicker_Inventory.dart';
import 'QuestionAlgorithm.dart';
import 'package:flame/game.dart';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame/widgets.dart';
import 'clicker_marketplace.dart';

Allitems itemList = Allitems() ;

class ClickerSection extends StatefulWidget {
  @override
  _ClickerSectionState createState() => _ClickerSectionState();
}

class _ClickerSectionState extends State<ClickerSection> {
  List<String> equippedItems ;
  BasicAnimations game = BasicAnimations() ;
  bool isLoaded = false ;
  int _metreRun = 0;
  int _metreRunTemp = 0;
  int luckOfFind  ;
  int luckOfHunt  ;
  int speedMod = 1 ;
  int huntPoint = 0 ;
  int coin = 0 ;
  bool clickerflag ;
  bool flag = false ;
  int carryCapacityMultiplier;
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
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      print("Loading.. ");
      _metreRun = (prefs.getInt('clicks') ?? 0);
      game.metre = _metreRun.toString();
      clickerflag = (prefs.getBool('clickerflag') ?? false);
      equippedItems =
      (prefs.getStringList('equippedItems') ?? ["0", "1", "2", "3"]);
      huntPoint = (prefs.getInt('huntPoint') ?? 0);
      luckOfFind = _getItem(equippedItems[3]).power;
      luckOfHunt = _getItem(equippedItems[2]).power;
      carryCapacityMultiplier = _getItem(equippedItems[1]).power;
      speedMod = _getItem(equippedItems[0]).power;
      coin = (prefs.getInt('coin') ?? 0);
    });
  }

  void _incrementClicks(int speed) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _metreRun += (1 * speed  * speedMod).toInt();
      _metreRunTemp += (1 * speed  * speedMod).toInt() ;
      if(_metreRunTemp >= 231 && _rollaDice(100-luckOfFind))
        {
          huntPoint += 1 ;
          _metreRunTemp = 0 ;
        }
      prefs.setInt('clicks', _metreRun);
      game.metre = _metreRun.toString() ;
      prefs.setInt('huntPoint', huntPoint);
      prefs.setInt('coin', coin);
    });
  }


  void _Hunt() {
    setState(() {
      _incrementClicks(0);
      if(huntPoint > 0 )
        {
          huntPoint -= 1 ;
          if(_rollaDice(100-luckOfHunt.toInt()))
            {
              String animalName = "" ;
              game.hunt = true ;
              int animal = _random(100) ;
              if(animal>=97)
                {
                  animalName = "Ayı" ;
                  _finditem(_random(itemList.AllitemsList.length-1) , 1) ;
                  _finditem(8 , _random(15)+7) ;
                  _finditem(9 , _random(20)+10) ;
                }
              else if(animal >= 90)
                {
                  animalName = "Geyik" ;
                  _finditem(_random(itemList.AllitemsList.length-1) , 1) ;
                  _finditem(8 , _random(10)+3) ;
                  _finditem(9 , _random(12)+5) ;
                }
              else if(animal >= 80)
                {
                  animalName = "Domuz" ;
                  _finditem(_random(itemList.AllitemsList.length-1) , 1) ;
                  _finditem(8 , _random(8)+3) ;
                  _finditem(9 , _random(10)+2) ;
                }
              else if(animal >= 30)
                {
                  animalName = "Ördek" ;
                  _finditem(_random(itemList.AllitemsList.length-1) , 1);
                  _finditem(8 , _random(2)+1) ;
                  _finditem(9 , _random(2)+1) ;
                }
              else
                {
                  animalName = "Tavşan" ;
                  _finditem(_random(itemList.AllitemsList.length-1) , 1) ;
                  _finditem(8 , _random(2)+1) ;
                  _finditem(9 , _random(2)+1) ;

                }

              final snackBar = SnackBar(
                  duration: const Duration(milliseconds: 150),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('$animalName Avlandı !'),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

        }

    });

  }
  void _finditem(int ID  , int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = (prefs.getStringList("items") ?? []) ;
    if(!(items.length >= 10*carryCapacityMultiplier)) {
      for (var i = amount; i >= 1; i--) {
        items.add(ID.toString());
      }
      setState(() {
        prefs.setStringList("items", items);
      });
    }
  }

  bool _rollaDice(int roll){
    Random dice = Random() ;
    if(dice.nextInt(100) > roll)
    {
      return true ;
    }
    else
    {
      return false ;
    }
  }
  int _random(int Range){
    Random dice = Random() ;
    return dice.nextInt(Range) ;
  }



  @override
  Widget build(BuildContext context) {
    if (flag) {
      return QuestionWidget();
    }
    else {
      return !isLoaded ? Container() : Center(
        child: Container(
          color: Colors.black12 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                  height : 300 ,
                  child: GameWidget(game: game)),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                 Text('${townNames[(_metreRun ~/10000) % townNames.length]} '),
                                 Expanded(child: LinearProgressIndicator(
                                   value: 1- ((10000 - (_metreRun % 10000 ))/10000),
                                   minHeight: 20,
                                 ),
                                 ),
                                 Text(' ${townNames[((_metreRun ~/10000) + 1) % townNames.length]}(${10000 - (_metreRun % 10000 )})'),
                                ],
                              ),
                            ),
                            Text('$huntPoint Avlanılabilecek alan bulundu'),
                            Text('$coin Altın'),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    color : Colors.white10,
                                    child: TextButton(onPressed: ((){
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => clickerMarketSection(),),
                                        ).then((value) {
                                          _loadCounter();
                                        });
                                      });
                                    }), child: Text("Market")),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    color : Colors.white10,
                                    child: TextButton(onPressed: ((){
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => clickerInventory(),),
                                        ).then((value) {
                                          _loadCounter();
                                        });
                                      });
                                    }), child: Text("Çanta")),
                                  ),
                                ),
                              ],
                            ) ,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: TextButton(onPressed: ((){
                        _Hunt();
                      }), child: Text("A V L A N")),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: TextButton(onPressed: ((){
                        game.speedModifier += 4.0 ;
                        _incrementClicks(game.speedModifier.toInt());

                      }), child: Text("K O Ş")),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50 ,
                  child: Container()
              ),
            ],
          ),
        ),
      );
    }
  }
}


class BasicAnimations extends BaseGame {
  String metre ;
  double speed ;
  TextComponent _metresRun ;
  var speedModifier = 1.0 ;
  var tempSpeedModifier = 1.0 ;
  var hunt = false ;
  ui.Image adventurerrun;
  ui.Image adventureridle;
  ui.Image adventurerAttack;
  // TODO hunting animation
  SpriteAnimation animationRun;
  SpriteAnimation animationIdle;
  SpriteAnimation animationAttack;
  SpriteAnimationComponent anim ;
  ParallaxComponent parallax ;
  final _imageNames = [
    'parallax/Layer_0010_1.png',
    'parallax/Layer_0009_2.png',
    'parallax/Layer_0008_3.png',
    'parallax/Layer_0007_Lights.png',
    'parallax/Layer_0006_4.png',
    'parallax/Layer_0005_5.png',
    'parallax/Layer_0004_Lights.png',
    'parallax/Layer_0003_6.png',
    'parallax/Layer_0002_7.png',
    'parallax/Layer_0001_8.png',
    'parallax/Layer_0000_9.png',
  ];

  @override
  void update(double dt) {

    if(speedModifier > 100.0)
    {speedModifier = 100.0 ; }
    super.update(dt);
    speed = 1 - (0.01 * speedModifier) ;
    _metresRun.text = metre ;
    playerAnim(speed) ;
    if(speed >= 0.001)
      {
        print(speed);
        animationRun.stepTime = speed ;
      }
    if(speedModifier > 0 )
    {
      speedModifier -= 0.3 ;
    }
    parallax.parallax.baseVelocity.setValues(0.003*speedModifier, 0 ) ;
  }
  @override
  void onResize(Vector2 canvasSize) {
    // TODO: implement onResize
    super.onResize(canvasSize);
    if(_metresRun != null){
      _metresRun.position = Vector2((canvasSize.x/2) - _metresRun.width/2 , 40 ) ;
    }
  }
  @override
  Future<void> onLoad() async {
    adventurerrun = await images.load('adventurer/run.png');
    adventureridle = await images.load('adventurer/idle.png');
    adventurerAttack = await images.load('adventurer/attack1.png');

    animationIdle = SpriteAnimation.fromFrameData(
      adventureridle,
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(50),
        stepTime: 0.15 ,
      ),
    );
    animationRun = SpriteAnimation.fromFrameData(
      adventurerrun,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2.all(50),
        stepTime: 0.15 ,
      ),
    );
    animationAttack = SpriteAnimation.fromFrameData(
      adventurerAttack,
      SpriteAnimationData.sequenced(
        loop:false ,
        amount: 5,
        textureSize: Vector2.all(50),
        stepTime: 0.15 ,
      ),
    );


    final spriteSize = Vector2.all(100.0);
    anim = SpriteAnimationComponent(
      position: Vector2(100 , 204),
      animation: animationIdle,
      size: spriteSize,
    );



    parallax = await loadParallaxComponent(
      _imageNames,
      fill: LayerFill.height,
      baseVelocity: Vector2(0.3, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );

    add(parallax);
    add(anim);
    _metresRun = TextComponent(metre) ;
    add(_metresRun) ;
  }

  void playerAnim(double speed)
  {
    if(speed <= 1.0)
    {
      this.anim.animation = animationRun ;
       // if(this.anim.position.x < 150)
       // {this.anim.position.x  += speed * 0.2 ;}
      if(speed <= 0.30)
        {
          this.anim.position.x += 1 ;
          if(this.anim.position.x >= 500)
            {
              this.anim.position.x = -100 ;
            }
        }
      if(speed <= 0.05)
      {
        this.anim.position.x += 5 ;
        if(this.anim.position.x >= 500)
        {
          this.anim.position.x = -100 ;
        }
      }
    }
    else
    {
      this.anim.animation = animationIdle ;
       // if(this.anim.position.x > 0)
       //  {this.anim.position.x  -= 3 ;}
      if(hunt)
      {
        this.anim.animation = animationAttack ;
        if(this.anim.animation.done()){
          animationAttack.reset() ;
          hunt =false ;
        }
      }
    }

  }



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






