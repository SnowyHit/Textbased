import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textbased/QuestionAlgorithm.dart';
import 'dart:math';
import 'dart:async';

class snake extends StatefulWidget {
  @override
  _snakeState createState() => _snakeState();
}

class _snakeState extends State<snake> {
  static List<int> snakepos = [10 , 20 ] ;
  int numberofsquares = 180 ;
  static var randomnum = Random() ;
  int food = randomnum.nextInt(180) ;
  void generateNewFood() {
    food = randomnum.nextInt(180) ;
  }
  void startGame(){
    snakepos = [10,20];
    const duration = const Duration(milliseconds: 150) ;
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if(gameOver())
        {
          timer.cancel() ;
        }
    }) ;
  }
  var direction = "D" ;
  void updateSnake(){
    setState(() {
      switch(direction){
        case 'D':
          if(snakepos.last >170)
          {
            snakepos.add(snakepos.last +10 -180);
          }
          else
          {
            snakepos.add(snakepos.last +10) ;
          }
          break ;
        case 'U':
          if(snakepos.last< 10)
          {
            snakepos.add(snakepos.last - 10 + 180);
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
  bool gameOver()
  {
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
  bool isLoaded = false ;
  bool Leaveflag = false ;
  @override
  void initState() {

    super.initState();
    _load();
  }

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      //_clicks = (prefs.getInt('clicks') ?? 0);
    });
  }

  _Leave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //prefs.setInt('counter', _counter);
      Leaveflag = true ;
    });
  }


  void _set() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //prefs.setInt('clicks', _clicks);
    });
  }


  @override
  Widget build(BuildContext context) {
    if (Leaveflag) {
      return QuestionWidget();
    }
    else {
      return !isLoaded ? Container() :
      Container(
        child: Column(
          children: [
            Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: (details){
                    if(direction != 'U' && details.delta.dy > 0 )
                      {direction = 'D' ;}
                    else if (direction != 'D' && details.delta.dy < 0 )
                      {direction = 'U' ;}
                  } ,
                  onHorizontalDragUpdate: (details){
                    if(direction != 'L' && details.delta.dx > 0 )
                    {direction = 'R' ; }
                    else if (direction != 'R' && details.delta.dx < 0 )
                    {direction = 'L' ;}
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
                              child : Container(),
                            )
                        ) ;
                      }
                    } ,
                  ),

            )),  
            Padding(
                padding: EdgeInsets.all(20),
                child : Row (
                  children: [
                    GestureDetector(
                      onTap :  startGame,
                      child:  Text("Başla"),
                    ), 
                     Text("Skor : " + snakepos.length.toString())
                  ],
                ) ,

            )


          ],
        )
      ) ;
    }
  }
}