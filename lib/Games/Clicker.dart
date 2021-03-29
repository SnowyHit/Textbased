import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QuestionAlgorithm.dart';
import 'package:flame/game.dart';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';
import 'package:flame/widgets.dart';

class BasicAnimations extends BaseGame {
  ui.Image adventurer;
  SpriteAnimation animation;
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
  Future<void> onLoad() async {
    adventurer = await images.load('adventurer/run.png');

    animation = SpriteAnimation.fromFrameData(
      adventurer,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2.all(50),
        stepTime: 0.15,
      ),
    );

    final spriteSize = Vector2.all(100.0);
    final animationComponent2 = SpriteAnimationComponent(
      animation: animation,
      size: spriteSize,
    );
    animationComponent2.x = 100;
    animationComponent2.y = 200;

    final parallax = await loadParallaxComponent(
      _imageNames,
      fill: LayerFill.height,
      baseVelocity: Vector2(0.5, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    add(parallax);
    add(animationComponent2);
  }

}



class clickerGame extends StatefulWidget {
  @override
  _clickerGameState createState() => _clickerGameState();
}

class _clickerGameState extends State<clickerGame> {
  BasicAnimations game = BasicAnimations() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height : 300 ,
              child: GameWidget(game: game)),
          TextButton(onPressed: ((){
             ;
          }), child: Text("Koşuyorsun .. ")) ,
        ],
      ),
    ) ;
  }
}


class ClickerSection extends StatefulWidget {
  @override
  _ClickerSectionState createState() => _ClickerSectionState();
}

class _ClickerSectionState extends State<ClickerSection> {
  bool isLoaded = false ;
  int promote= 1 ;
  int _clicks = 0;
  bool clickerflag ;
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
  List<String> Textx = [
    "//Rüyaya daldığını hissediyorsun// ** Ofiste uyukluyorsun !",
    "Çalışmaya başladın , karşındaki klavyeye hırs ile vuruyorsun ve ekrandaki yazıları takip ediyorsun !" ,
    "Diğer çalışanlardan daha iyi klavyeye vurdun ! ve artık diğer çalışanlara klavyeye daha hırslı vurmalarını söylüyorsun ." ,
    "Patronun hayranlıkla seni izliyor ve emekli olmanın vakti geldiğini düşünüyor. Artık yeni patron sensin , artık şirketin gidişatını değiştirebilirim diye düşünüdün. Sonra gözlerine bakan çalışanlarına 'DAHA SERT VURUN' diye bağırdın." ,
    "Büyük patronlar seni çok sevdi ve artık yükselmenin vakti geldiğini düşünüyorlar ! Seni ülkenin bütün şirketlerinin başına koydular. Artık işcilere değil , patronlara bağırıyorsun." ,
    "Tek bir ülke yetmez ! dedi şirketlerin sahibi , diğer ülkelerdeki sorumlularada bağırmaya başlıyorsun !" ,
    "Şirket sahibi çok iyi çalıştığın için ortaklık teklif etti , şirketin yarısı artık senin ve Arkana yaslanıyorsun , klavyene bakıp duygulandın ve eski günlerdeki gibi klavyene vurup ekrandaki paranın yükseldiğini görüyorsun." ,
    "Herşey artık senin elinde , şirketlerin para kazanıyor , hiçbirşey yapmak zorunda değilsin  , yada .." ,
  ] ;
  int _promote() {
    int x = 1 ;
    if(_clicks > 100) {x =  2 ; }
    if(_clicks > 1000) {x=  3 ; }
    if(_clicks > 10000) {x =  4 ; }
    if(_clicks > 100000) {x =  5 ; }
    if(_clicks > 1000000) {x =  6 ; }
    if(_clicks > 10000000) {x =  7 ; }
    return x ;
  }

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
      _clicks = (prefs.getInt('clicks') ?? 0);
      promote = (prefs.getInt('promote') ?? 0);
      clickerflag = (prefs.getBool('clickerflag') ?? false);
    });
  }

  _Leave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('promote', promote);
      prefs.setBool('clickerflag', true);
      flag = true ;
    });
  }


  void _incrementClicks() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      promote = _promote() ;
      print(promote);
      _clicks = _clicks + (promote*10);
      prefs.setInt('clicks', _clicks);
      prefs.setInt('promote', promote);
    });
  }


  @override
  Widget build(BuildContext context) {
    if (flag) {
      return QuestionWidget();
    }
    else {
      return !isLoaded ? Container() : Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Ünvanın : ${promotions[promote]}',),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('${Textx[promote]}'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Kazandığın para : $_clicks'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 50,
                child: TextButton.icon(onPressed: () {
                  _incrementClicks();
                  print("Something");
                }, icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.attach_money_rounded),
                ), label: Text("Para Kazan"),),
              ),
            ),
            if(!clickerflag) TextButton.icon(onPressed: () {
                _Leave();
            }, icon: Icon(Icons.airport_shuttle), label: Text("İşi bırak."),)
          ],
        ),
      );
    }
  }
}
