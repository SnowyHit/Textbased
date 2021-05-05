# textbased
https://textbased-c467f.web.app/#/ Web page for this project.
This is a Flutter project for a text based adventure game. I generally started this project just for learning the basics of flutter ,  and bein familiar with the consepts of dart language . Learning things like shared preferences , widget placements , saving data and saving game states , moving between screens and such.   

First thing is to make the main menu and giving out navigations from here . As you can see in the https://github.com/SnowyHit/Textbased/blob/master/lib/main.dart  , this page is the backbone of the app.   

![Main Menu](https://github.com/SnowyHit/Textbased/blob/master/assets/Screenshots/Adventure-MainScreen.png)
![SideBar Menu](https://github.com/SnowyHit/Textbased/blob/master/assets/Screenshots/Adventure%20-%20Menu.png)

After that , i started building the choice system . For that the challange was i didnt know how many answers i was gonna get so i had to make a elastic system. For that i have used the nodes-trees data structure and just linked the parts manually. That is not the best way to implement this , but it answered my requirements. You can see the code here - https://github.com/SnowyHit/Textbased/blob/master/lib/Games/QuestionAlgorithm.dart   

![Choices](https://github.com/SnowyHit/Textbased/blob/master/assets/Screenshots/Adventure%20Choice%20Screen.png)

After finishing coding that next thing was to implement a clicker game in this project. I thought this as a breaking point in choices. For this i choose to work with Flame , a flutter game engine. This was for the animation i wanted when i clicked the run button. After getting those work , i added some mechanics , like hunting for stuff and probabilities. https://github.com/SnowyHit/Textbased/blob/master/lib/Games/Clicker.dart   
![Clicker Game Main](https://github.com/SnowyHit/Textbased/blob/master/assets/Screenshots/Adventure%20Clicker%20Game.png)

Next thing was to implement a shopping system in the clicker game. Again this was not the best way but , it worked for me and i got a basic system of inventory - and having the same ui , i created some marketplace.   
![Clicker Game Inventory](https://github.com/SnowyHit/Textbased/blob/master/assets/Screenshots/Adventure%20Inventory.png)   


This project was a good way to learn my ways in flutter and just to work on what i have learned reading documents , and doing some tutorials. I dont see any future in it so i quitted updating this.

TODO : 

-New design is needed.
-Achievement system should be added.
-Cleaner code



