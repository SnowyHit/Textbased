import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QuestionAlgorithm.dart';
import 'package:flame/game.dart';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame/widgets.dart';

class ClickerSection extends StatefulWidget {
  @override
  _ClickerSectionState createState() => _ClickerSectionState();
}

class _ClickerSectionState extends State<ClickerSection> {
  BasicAnimations game = BasicAnimations() ;
  bool isLoaded = false ;
  int promote= 1 ;
  int _metreRun = 0;
  int _metreRunTemp = 0;
  int huntPoint = 0 ;
  bool clickerflag ;
  bool flag = false ;

  @override
  void initState() {

    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      _metreRun = (prefs.getInt('clicks') ?? 0);
      clickerflag = (prefs.getBool('clickerflag') ?? false);
      huntPoint = (prefs.getInt('huntPoint') ?? 0);
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
      _metreRun += 1 * speed ;
      _metreRunTemp += 1* speed ;
      if(_metreRunTemp >= 231)
        {
          huntPoint += 1 ;
          _metreRunTemp = 0 ;
        }
      prefs.setInt('clicks', _metreRun);
      prefs.setInt('huntPoint', huntPoint);
      prefs.setInt('huntPoint', _metreRunTemp);
    });
  }


  void _Hunt() {
    setState(() {
      if(huntPoint > 0 )
        {
          huntPoint -= 1 ;
        }

    });

    //TODO : random chance to get items , fur , meat , get a snackbar with info
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

            Text('$_metreRun metre'),
            Text('$huntPoint Avlanılabilecek alan bulundu'),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: TextButton(onPressed: ((){
                      _Hunt();
                      //TODO add hunting animation trigger
                    }), child: Text("A V L A N")),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: TextButton(onPressed: ((){
                      game.speedModifier += 1.0 ;

                      if(game.speedModifier > 25.0)
                      {game.speedModifier = 25.0 ; }

                      _incrementClicks(game.speedModifier.toInt());

                    }), child: Text("K O Ş")),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

class BasicAnimations extends BaseGame {
  var speedModifier = 1.0 ;
  var tempSpeedModifier = 1.0 ;
  ui.Image adventurerrun;
  ui.Image adventureridle;
  // TODO hunting animation
  SpriteAnimation animationRun;
  SpriteAnimation animationIdle;
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
    // TODO: implement update
    super.update(dt);

    playerAnim(speedModifier) ;

    if (0.8 - (0.02 * speedModifier) > 0.1 )
    {
      animationRun.stepTime = 0.6 - (0.02 * speedModifier) ;
    }
    if(speedModifier > 0 )
    {
      speedModifier -= 0.05 ;
    }
    parallax.parallax.baseVelocity.setValues(0.035*speedModifier, 0 ) ;
  }
  @override
  Future<void> onLoad() async {
    adventurerrun = await images.load('adventurer/run.png');
    adventureridle = await images.load('adventurer/idle.png');

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
    }
    // TODO Hunting animation trigger
  }


}

