import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class QuestionWidget extends StatefulWidget {
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Node root =  startRoot();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(20),
              color : Colors.black12,
              child: Text(
                "${root.value.line}" ,
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
                children: root.value.answers.asMap().entries.map<Widget>((answer) {
                  return FlatButton(
                    onPressed: (){
                      setState(() {
                        if(root.haschildren)
                          {root = root.children[answer.key] ; }

                        print(answer.key);
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

Node startRoot(){
   Question q1 = new Question.twoAnswers("Mesaiye kalır", "Bara git", "Eve dön") ;
   Question q61 = new Question("Avcıların ana karagahına gidersin sorgulamaya başlarlar", "Cevap 1", "Cevap 2", "Cevap 3", "Cevap 4") ;
   Question q51 = new Question.oneWay("Yanına bi araba yanaşır ve kaçırılırsın", "Devam et") ;
   Question q42 = new Question.oneWay("Başka bir iş yapmaya gidersin", "Devam et") ;
   Question q41 = new Question.oneWay("Adrese gidersin", "Devam et") ;
   Question q22 = new Question.oneWay("Yardım etmeden devam edersen", "Devam et") ;
   Question q31 = new Question.twoAnswers("Evde uyanırsın , cebinde adres bulursun", "Başka bir iş yap", "Adrese git") ;
   Question q21 = new Question.oneWay("Yardım etmeyi seçerse puan ,adres verir koşmaya başlar", "Devam et") ;
   Question q11 = new Question.twoAnswers("Eve dönerken ara sokakta yaralı adam görür", "Yardım etme", "Yardım et") ;
   Question q12 = new Question.oneWay("Bara gidersin", "Devam et") ;
   Node n61 = new Node.leaf(q61) ;
   Node n51 = new Node(q51 , [n61]) ;
   Node n42 = new Node(q42 , [n51]) ;
   Node n41 = new Node(q41 , [n61]) ;
   Node n22 = new Node(q22 , [n51]) ;
   Node n31 = new Node(q31 , [n42 , n41]) ;
   Node n21 = new Node(q21 , [n31]) ;
   Node n11 = new Node(q11 , [n22 , n21]) ;
   Node n12 = new Node(q12 , [n31]) ;
   Node n1 = new Node(q1 , [n12, n11]) ;
   return n1 ;
}

class Question {
  String line ;
  List<String> answers ;
  Question(String line , String answer1 ,String answer2 ,String answer3 ,String answer4  )
  {
    this.line = line ;
    answers = [answer1 , answer2 , answer3 , answer4 ];
  }
  Question.twoAnswers(String line , String answer1 ,String answer2)
  {
    this.line = line ;
    answers = [answer1 , answer2];
  }
  Question.threeAnswers(String line , String answer1 , String answer2 ,String answer3)
  {
    this.line = line ;
    answers = [answer1 , answer2 , answer3 ];
  }
  Question.oneWay(String line , String answer1)
  {
    this.line = line ;
    answers = [answer1 ];
  }

}

class Node<Question> {
  Question value;
  bool haschildren ;
  List<Node<Question>> children;
  Node(Question value, List<Node<Question>> children)
  {
    this.value = value ;
    this.children = children ;
    haschildren = true ;
  }
  Node.leaf(Question value)
  {
    this.value = value ;
    haschildren = false ;
  }
}