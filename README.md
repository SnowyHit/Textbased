# textbased
https://textbased-c467f.web.app/#/ Web page for this project.
This is a Flutter project for a text based adventure game. It has firestore as it's backend , where you can see firestore documents. Hosting with firebase and using github actions made deploying process quite easy.

![Main Menu](https://github.com/SnowyHit/Textbased/blob/master/assets/Screenshots/Adventure-MainScreen.png)

Shared_preferences used as saving cache . You can save basic types of variables to shared preferences and it is way faster than i imagined. İt is used in every start of a widget , as a gamestate .

Using tree data structure to save questions and see the next question so it can be used as a template for other question programs. See QuestionWidget.dart to take a look at the structure.
Node class for structure for tree and Question class to save questions easier.

Games is added as a new dart file so it can be re-used as a whole new widget - plug and play kinda thing.


TODO : 

-games is too complicated and hardcoded into code if you use core flutter , im going to add  Flame to the project.
-New design is needed.
-Achievement system should be added.
-Cleaner code



