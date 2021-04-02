import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QuestionAlgorithm.dart';
import 'package:flame/game.dart';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame/widgets.dart';

import 'clicker_marketplace.dart';

class ClickerSection extends StatefulWidget {
  @override
  _ClickerSectionState createState() => _ClickerSectionState();
}

class _ClickerSectionState extends State<ClickerSection> {
  BasicAnimations game = BasicAnimations() ;
  bool isLoaded = false ;
  int _metreRun = 0;
  int _metreRunTemp = 0;
  int luckOfFind = 1 ;
  int luckOfHunt = 1 ;
  int speedMod = 1 ;
  int huntPoint = 0 ;
  int meat = 0 ;
  int fur = 0 ;
  int coin = 0 ;
  bool clickerflag ;
  bool flag = false ;
  int carryCapacityMultiplier = 190;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      print("Loading.. ") ;
      _metreRun = (prefs.getInt('clicks') ?? 0);
      game.metre = _metreRun.toString() ;
      clickerflag = (prefs.getBool('clickerflag') ?? false);
      huntPoint = (prefs.getInt('huntPoint') ?? 0);
      luckOfFind = (prefs.getInt('luckOfFind') ?? 0);
      luckOfHunt = (prefs.getInt('luckOfHunt') ?? 0);
      speedMod = (prefs.getInt('speedMod') ?? 0);
      fur = (prefs.getInt('fur') ?? 0);
      meat = (prefs.getInt('meat') ?? 0);
      coin = (prefs.getInt('coin') ?? 0);
    });
  }

  _Leave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('clickerflag', true);
      flag = true ;
    });
  }


  void _incrementClicks(int speed) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _metreRun += 1 * speed  * speedMod;
      _metreRunTemp += 1* speed * speedMod ;
      if(_metreRunTemp >= 231 && _rollaDice(luckOfFind))
        {
          huntPoint += 1 ;
          _metreRunTemp = 0 ;
        }
      prefs.setInt('clicks', _metreRun);
      game.metre = _metreRun.toString() ;
      prefs.setInt('huntPoint', huntPoint);
      prefs.setInt('fur', fur);
      prefs.setInt('meat', meat);
      prefs.setInt('coin', coin);
    });
  }


  void _Hunt() {
    setState(() {
      _incrementClicks(0);
      if(huntPoint > 0 )
        {
          huntPoint -= 1 ;
          if(_rollaDice(luckOfHunt))
            {
              String animalName = "" ;
              game.hunt = true ;
              int animal = _random() ;
              print(animal);
              if(animal>=97)
                {
                  animalName = "Ayı" ;
                  if(fur + meat < 10 * carryCapacityMultiplier)
                  {
                    fur += 20 ;
                    meat += 50 ;
                  }
                }
              else if(animal >= 90)
                {
                  animalName = "Geyik" ;
                  if(fur + meat < 10 * carryCapacityMultiplier)
                  {
                    fur += 10 ;
                    meat += 20 ;
                  }
                }
              else if(animal >= 80)
                {
                  animalName = "Domuz" ;
                  if(fur + meat < 10 * carryCapacityMultiplier)
                  {
                    fur += 5 ;
                    meat += 10 ;
                  }
                }
              else if(animal >= 30)
                {
                  animalName = "Ördek" ;
                  if(fur + meat < 10 * carryCapacityMultiplier)
                  {
                    fur += 1 ;
                    meat += 1 ;
                  }
                }
              else
                {
                  animalName = "Tavşan" ;
                  if(fur + meat < 10 * carryCapacityMultiplier)
                  {
                    fur += 1 ;
                    meat += 1 ;
                  }
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
  int _random(){
    Random dice = Random() ;
    return dice.nextInt(100) ;
  }



  @override
  Widget build(BuildContext context) {
    if (flag) {
      return QuestionWidget();
    }
    else {
      return !isLoaded ? Container() : Center(
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
                          Text('$huntPoint Avlanılabilecek alan bulundu'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('$meat Kilo et'),
                              Text('$fur Parça Kürk'),
                            ],
                          ),
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

                      if(game.speedModifier > 25.0)
                      {game.speedModifier = 25.0 ; }

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
      );
    }
  }
}


class BasicAnimations extends BaseGame {
  String metre ;
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

    super.update(dt);

    _metresRun.text = metre ;
    playerAnim(speedModifier) ;

    if (0.8 - (0.02 * speedModifier) > 0.1 )
    {
      animationRun.stepTime = 0.6 - (0.02 * speedModifier) ;
    }
    if(speedModifier > 0 )
    {
      speedModifier -= 0.5 ;
    }
    parallax.parallax.baseVelocity.setValues(0.035*speedModifier, 0 ) ;
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
    if(speed > 0)
    {
      this.anim.animation = animationRun ;
       // if(this.anim.position.x < 150)
       // {this.anim.position.x  += speed * 0.2 ;}
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

