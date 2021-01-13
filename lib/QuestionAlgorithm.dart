import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class QuestionWidget extends StatefulWidget {

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int _counter = 0;
  int point = 0 ;
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      point = (prefs.getInt('point') ?? 0);
    });
  }
  _DeleteCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
    });
  }

  //Incrementing counter after click
  _incrementCounter(int x , int y) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = x;
      point = y;
      prefs.setInt('counter', _counter);
      prefs.setInt('point', point);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Points : $point"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(20),
              color : Colors.black12,
              child: Text(
                "${startRoot(_counter).value.line}" ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30  ,
                ),
              )
          ) ,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: startRoot(_counter).value.answers.asMap().entries.map<Widget>((answer) {
                  return FlatButton(
                    onPressed: (){
                      setState(() {
                        if(startRoot(_counter).haschildren)
                          {
                            point = point + startRoot(_counter).value.points[answer.key];
                            _incrementCounter(startRoot(_counter).children[answer.key].index , point) ;
                            print(_counter);
                          }
                      });

                    },
                    padding: EdgeInsets.all(20) ,
                    child : Text(
                      "${answer.value}" ,
                      style: TextStyle(
                        fontSize: 30  ,
                      ),
                    ) ,
                  );
                }).toList(),
              ),
            ],
          )
        ],
      ),

    );
  }
}



Node startRoot(int x){
   Node currentNode ;
   print("askdaslknda");
   Question q1 = new Question("Mesaiye kalır", ["Bara git", "Eve dön"] , [-5,12345678912345678] ) ;
   Question q61 = new Question("Avcıların ana karagahına gidersin sorgulamaya başlarlar",["Cevap 1", "Cevap 2", "Cevap 3", "Cevap 4"] , [1,2,3,4] ) ;
   Question q51 = new Question("Yanına bi araba yanaşır ve kaçırılırsın",["Devam et"] ,[1] ) ;
   Question q42 = new Question("Başka bir iş yapmaya gidersin",[ "Devam et"] , [1]) ;
   Question q41 = new Question("Adrese gidersin",[ "Devam et"], [1]) ;
   Question q22 = new Question("Yardım etmeden devam edersen",["Devam et"] , [1]) ;
   Question q31 = new Question("Evde uyanırsın , cebinde adres bulursun", ["Başka bir iş yap", "Adrese git"] , [1,2]) ;
   Question q21 = new Question("Yardım etmeyi seçerse puan ,adres verir koşmaya başlar",[ "Devam et"] , [1]) ;
   Question q11 = new Question("Eve dönerken ara sokakta yaralı adam görür", ["Yardım etme", "Yardım et"] , [1,2]) ;
   Question q12 = new Question("Bara gidersin", ["Devam et"] , [1]) ;
   Node n61 = new Node.leaf(q61 ,61) ;
   Node n51 = new Node(q51 , [n61] ,51) ;
   Node n42 = new Node(q42 , [n51] ,42) ;
   Node n41 = new Node(q41 , [n61] ,41) ;
   Node n22 = new Node(q22 , [n51], 22) ;
   Node n31 = new Node(q31 , [n42 , n41] ,31) ;
   Node n21 = new Node(q21 , [n31],21) ;
   Node n11 = new Node(q11 , [n22 , n21], 11) ;
   Node n12 = new Node(q12 , [n31] ,12) ;
   Node n1 = new Node(q1 , [n12, n11],1) ;
   List<Node> Allnodes= [n1 , n12 , n11 , n21 , n31 , n22 , n41 , n42 , n51 , n61] ;
   if(x == 0 )
     {
       print(x);
       currentNode = n1 ;
     }
   else {
   for(var node in Allnodes)
     {
       if(node.index == x)
         {
           currentNode = node ;
           print(x);
         }
     }
   }
   return currentNode ;
}

class Question {
  String line ;
  List<String> answers ;
  List<int> points ;
  Question(String line , List<String> answers , List<int> points )
  {
    this.line = line ;
    this.answers = answers ;
    this.points = points ;
  }

}

class Node<Question> {
  int index ;
  Question value;
  bool haschildren ;
  List<Node<Question>> children;
  Node(Question value, List<Node<Question>> children , int index)
  {
    this.index = index ;
    this.value = value ;
    this.children = children ;
    haschildren = true ;
  }
  Node.leaf(Question value , int index)
  {
    this.index = index ;
    this.value = value ;
    haschildren = false ;
  }
}