import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String Question = "akjnsdkjnasnjkdaskjndkqjwndnq9wndıqnıdnqıdnıqndıqwndıasndbuynıjmokölşçvygbuhnjmklöşçasidqywubdhjqlşdiq" ;
  List answers = ["Answer uno" , "Answer Zwei" , "Answer Trio" ,"Answer Foro"] ;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.all(20),
            color : Colors.black12,
            child: Text(
              "$Question" ,
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
              children: answers.map((answer) {
                return FlatButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(20) ,
                  child : Text(
                    "$answer" ,
                    style: TextStyle(
                      fontSize: 30  ,
                    ),
                  ) ,
                );
              }).toList() ,


            )
            ,
          ],
        )
      ],
    );
  }
}


class Question {
  String line ;
  List answers ;
  Question(String line , String answer1 ,String answer2 ,String answer3 ,String answer4  )
  {
    this.line = line ;
    if(answer1 != null)
      {answers.add(answer1); }
    if(answer2 != null)
      {answers.add(answer1); }
    if (answer3 != null)
      {answers.add(answer1); }
    if (answer4 != null)
      {answers.add(answer1); }
  }
  Question.twoAnswers(String line , String answer1 ,String answer2) : this(line , answer1 , answer2 , null , null);
  Question.threeAnswers(String line , String answer1 ,String answer2,String answer3) : this(line , answer1 , answer2 ,answer3 , null);

  int QuestionNumber()
  {
    return answers.length ;
  }
}