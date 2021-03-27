import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/D/Flutter_projects/textbased/lib/Games/QuestionAlgorithm.dart';
import 'dart:math';
import 'dart:async';

class snake extends StatefulWidget {
  @override
  _snakeState createState() => _snakeState();
}

class _snakeState extends State<snake> {
  bool gameflag = false ;
  bool earlyend = false ;

  bool isLoaded = false ;
  bool Leaveflag = false ;
  int snakepoint = 0 ;
  bool snakeflag = false ;
  int snakehiscore = 0 ;
  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      snakeflag = (prefs.getBool('snakeflag') ?? false);
      snakepoint = (prefs.getInt('snakepoint') ?? 0);
      direction = (prefs.getString('direction') ?? "D");
      snakehiscore = (prefs.getInt('snakehiscore') ?? 0);
    });
  }

  _Leave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('snakeflag', true);
      prefs.setInt('snakepoint', (snakepos.length));

      Leaveflag = true ;
    });
  }
  setdirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('direction', direction);
      sethiscore();
    });
  }
  sethiscore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(snakehiscore< (snakepos.length))
      {
        snakehiscore = snakepos.length ;
        prefs.setInt('snakehiscore', snakehiscore);
      }
    });
  }

  static List<int> snakepos = [10 , 20 ] ;
  int numberofsquares = 160 ;
  static var randomnum = Random() ;
  int food = randomnum.nextInt(160) ;
  void generateNewFood() {
    food = randomnum.nextInt(160) ;
  }
  void startGame(){
    earlyend = false ;
    gameflag = true ;
    const duration = const Duration(milliseconds: 150) ;
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if(gameOver())
        {
          snakepoint = snakepos.length ;
          snakepos = [10 , 20 ] ;
          timer.cancel() ;
          if(!earlyend)showGameOverScreen();
        }
    }) ;
  }
  var direction = "D" ;
  void updateSnake(){
    if(this.mounted){
      setState(() {
        switch(direction){
          case 'D':
            if(snakepos.last >150)
            {
              snakepos.add(snakepos.last +10 - 160);
            }
            else
            {
              snakepos.add(snakepos.last + 10) ;
            }
            break ;
          case 'U':
            if(snakepos.last < 10)
            {
              snakepos.add(snakepos.last - 10 + 160);
            }
            else
            {
              snakepos.add(snakepos.last - 10) ;
            }
            break ;
          case 'R':
            if((snakepos.last +1 ) % 10 == 0 )
            {
              snakepos.add(snakepos.last + 1 - 10 );
            }
            else
            {
              snakepos.add(snakepos.last + 1 ) ;
            }
            break ;
          case 'L':
            if(snakepos.last % 10 == 0 )
            {
              snakepos.add(snakepos.last -1 + 10 );
            }
            else
            {
              snakepos.add(snakepos.last -1 ) ;
            }
            break ;
          default :
        }
        if(snakepos.last == food)
        {
          generateNewFood();
        }
        else
        {
          snakepos.removeAt(0);
        }

      });
    }
  }
  bool gameOver()
  {
    if(earlyend)
      {return true; }
    for (int i = 0 ;  i<snakepos.length ; i++)
      {
        int count = 0 ;
        for (int j = 0 ; j < snakepos.length ; j++)
          {
            if (snakepos[i] == snakepos[j])
              {
                count += 1 ;
              }
            if (count == 2 )
            {

              return true;
            }
          }

      }
    return false ;
  }

  void showGameOverScreen(){
    String txt ;
    if(snakepoint > 20)
      {
        txt = "Tıkabasa doydun ($snakepoint)" ;
      }
    else
      {
        txt = "Kendini biraz aç hissediyorsun ($snakepoint)" ;
      }
    showDialog(context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title : Text("Kahvaltı bitti."),
        content:  Text(txt) ,
        actions: <Widget>[
          if(snakeflag) TextButton.icon(onPressed: () {
            startGame();
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_right_sharp), label: Text("Tekrar Oyna"),),
          if(!snakeflag) TextButton.icon(onPressed: () {
            _Leave();
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_right_sharp), label: Text("Arkana yaslan"),)
        ],
      );
    }
    ) ;
  }

  void onBackPressed(){
    earlyend = true ;
    if(snakeflag){Navigator.pop(context);}
  }

  @override
  Widget build(BuildContext context) {
      if (Leaveflag) {
      return WillPopScope(
        onWillPop: () async {
          onBackPressed(); // Action to perform on back pressed
          return false;
        },
        child: QuestionWidget(),
      );
      }
      else {
      return WillPopScope(
        onWillPop: () async {
          onBackPressed(); // Action to perform on back pressed
          return false;
        },
        child: !isLoaded ? Container() :
        Container(
            child: Column(
              children: [
                Expanded(
                    child: GestureDetector(
                      onVerticalDragUpdate: (details){
                        if(direction != 'U' && details.delta.dy > 0 )
                        {direction = 'D' ;
                        setdirect();}
                        else if (direction != 'D' && details.delta.dy < 0 )
                        {direction = 'U' ;
                        setdirect();}
                      } ,
                      onHorizontalDragUpdate: (details){
                        if(direction != 'L' && details.delta.dx > 0 )
                        {direction = 'R' ;
                        setdirect();}
                        else if (direction != 'R' && details.delta.dx < 0 )
                        {direction = 'L' ;
                        setdirect();}
                      } ,
                      child : GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numberofsquares ,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                        itemBuilder: (BuildContext context  , int index){
                          if(snakepos.contains(index))
                          {
                            return Center(
                              child: Container(
                                padding:  EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius:  BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                          if(index == food)
                          {
                            return Container(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child : Container(color: Colors.green,),
                                )
                            ) ;
                          }
                          else{
                            return Container(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child : Container(color: Colors.grey[1200],),
                                )
                            ) ;
                          }
                        } ,
                      ),

                    )),
                Row (
                  children: [
                    if(!gameflag) TextButton.icon(onPressed: () {
                      startGame();
                    }, icon: Icon(Icons.arrow_drop_down_sharp), label: Text("Yemeye başla"),) ,
                    if(gameflag)Text("Yemek: " + snakepos.length.toString()) ,
                    if(!snakeflag) TextButton.icon(
                      onPressed: null ,
                      onLongPress: () {
                      earlyend = true ;
                       _Leave();

                    }, icon: Icon(Icons.arrow_forward_outlined), label: Text("Devam et ..."),)
                  ],
                ) ,

              ],
            )
        ),
      );

    }

  }
}