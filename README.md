# :collision::collision::collision::collision: MKS22X FINAL PROJECT :collision: :collision::collision::collision:
<p align="center">
	<b>PROJECT NAME: </b> Plant vs. Zombies <br>
	<b> GROUP NAME: </b> Floofy Sleeping Ducks <br>
	<b> GROUP MEMBERS: </b> Peihua Huang, Tammy Chen (Period 5) <br>
</p>

## :bookmark_tabs:TABLE OF CONTENTS 
1. :star:[Project Description](#star-project-description) 
2. :video_game:[Phases of the Game (Project)](#video_game-phases-of-the-game-project) 
3. :memo:[Development Log](#memo-development-log) 

## :star: PROJECT DESCRIPTION 
Our project is an attempt at recreating the game, _Plant vs. Zombies_. It is an interactive user game where the user can collect suns (money), place down plants (Peashooter, Sunflower, WallNut, Cherry Bomb, Snow Pea, and Squash), and remove plants, all in order to defend a house from zombies. There is a cooldown timer for the plants in order to increase the difficulty of the game. The plants placed down on the map will be used to defend/defeat the zombies (zombie/coned zombie), each of which have their attack and hp levels. Zombies will randomly spawn and walk down one of the 5 rows at regular intervals. The user wins when all of the zombies are defeated for that level, and the user loses if a zombie manages to get pass all the levels of defense.

## :video_game: PHASES OF THE GAME (PROJECT) 
![Image of Start Screen](https://github.com/tchen00/PvZ/blob/master/images/plantvszombies%20start%20menu.PNG)
![Image of Menu](https://github.com/tchen00/PvZ/blob/master/images/plantvszombies%20menu.PNG)
![Image of Random Mode](https://github.com/tchen00/PvZ/blob/master/images/plantvszombies%20randommode.PNG)
![Image of Adventure Mode](https://github.com/tchen00/PvZ/blob/master/images/plantvszombies%20startadventuremode.PNG)
![Image of End Screen](https://github.com/tchen00/PvZ/blob/master/images/plantvszombies%20endscreen.PNG)

## :memo: Development Log
### DAY 1: May 16 2019
- **Peihua**  
    Set up the size of the game and start screen. Added transition from start screen to empty lawn, also added the box for the plant menu.
- **Tammy**
    Created the general template for the README + dev log

### DAY 2: May 17 2019
- **Peihua**  
    Instantiated the ArrayList and Queues needed to keep track of zombies and plants on the screen and those that will appear on the screen later.  
    Also started adding constructors to Zombie classes.
- **Tammy**
    Was burnt out after APCS (over studied for the test -- should have listened to Mr. K) : made the test folder

### DAY 3: May 18 2019
- **Peihua**   
    Finished constructors for Zombie classes. Loaded the images in for zombies and added display methods for the zombies.

### DAY 4: May 19 2019
- **Tammy**
    Realized she made bad decisions by studying for the APCS/APUSH exam instead of doing the project so she will make up all the work this week!
    Started to make the plant abstract class and the methods that are inside each plant -- Made the constructor and set the fields for the Plant class and added the methods according to the prototype!

### DAY 5: May 20 2019
- **Tammy**
Started on the final project grind. Continued to work on the Plant classes (specifically the Sunflower and Peashooter classes). Got the display to work for plants. Experimented in the test/experiment folder about different ways to implement timers and mouse-clicks (mousePressed). Also added in plant PNG to the folder    
- **Peihua**  
    Continued working on Zombie display. Had Zombie classes implement interfaces Moveable and Displayable to make draw easier. Made a grid over the law for the purpose of debugging. Allowed for the random spawning of Zombie objects over regular intervals of time. Made draw stop looping once a Zombie gets past the lawn (to be updated with end screen).

### DAY 6: May 21 2019
- **Tammy**
    Experimented with mousePressed and mouseDragged. Got an image of plants to move and release. Also resolved issue with display in Plant class.
- **Peihua**
	  Continued working on Zombies. Removed the interfaces because it was looping over the same list multiple times. Condensed the code in draw and added a field, row, to the Zombie subclasses to make comparisons with plants easier later on. Added an end screen once a Zombie passes through the whole lawn. Wrote an attack method for Zombie subclasses (which will be tested once Plants are added). Fixed the nextPlants queue so that player does not run out of Plants.

### DAY 7: May 22 2019
- **Peihua**  
    Debugged the display in Plants. Experimented with moving Plants in test file. Started implementing it to Driver, will continue working on it tomorrow, after APUSH and AP Mando are over.
- **Tammy**
    Started to work on Projectile class + experimented with Plant movement. Will try implement to implement the Projectile class tomorrow (after APUSH!)

### DAY 8: May 23 2019
- **Tammy**  
    After Peihua successfully moved plant, I edited the display method for each one of the plants (sunflower, peashooter, wallnut, squash, cherry bomb, snow pea) so that it fits accordingly with the size of the lawn. I also added in wallnut and cherry bomb png files.
- **Peihua**  
    Successfully moved Plant(!!!!) and have it snap to grid. Fixed issue with mousePressed code not registering at times (turns out the coordinates were wrong, oops).  

### DAY 9: May 24 2019
- **Peihua**  
    Made plants immovable once placed on the grid and made it so that only one Plant is allowed per box. Starting working on Zombie attack, making the Zombie stop if there is a plant in front of it.
- **Tammy**
    Started to work on Projectile class and wrote the abstract Projectile class + class greenProjectile and blueProjectile for the two different plants

### DAY 10: May 25 2019  
- **Peihua**  
    Found a bug where the timer started before the game started and the Zombie will spawn right away. Finished Zombie attack. Also fixed bug involving removing plants and zombies (I didn't realize I was modifying in the ArrayList I'm removing from, oops).

### DAY 11: May 26 2019
- **Peihua**  
    Updated Zombie attack so Plant dies after 5 bites (one bite per second). Added a cool-down timer for adding plants and a semi-transparent gray rectangle to let the player know when they can add more plants.  

### DAY 12: May 27 2019  
- **Peihua**  
    Continued working on Zombie attack. Fixed the bug where if one Zombie attacks, the whole screen freezes. Also fixed the bug where only one Zombie can attack at a time (because there was only one timer) by moving most of the attack code from the draw method to the actual attack method itself.
- **Tammy**
    Added projectile in the master branch -- still has a bit of technical issues with display (will fix tomorrow)

### DAY 13: May 28 2019  
- **Peihua**  
    Added a Shovel class so that plants can be removed from the grid. Also worked on the normal game mode(player can choose plants instead of it being random). Got the boxes to setup and plants to move (coordinates do not align too well, to be fixed tomorrow).
- **Tammy**
    Got ONLY the peashooter and the snow pea to shoot projectiles (added a type to the plant class) and GOT one (woops) projectile to move with the correct plant.

### DAY 14: May 29 2019
- **Peihua**  
    Found and fixed mistake that caused the coordinates of Plant to not align with the mouse. Decluttered the setup and draw methods. Added Sun Tracker (falling sun to be added later). Also setup game so that clicking start on the left vs right will produce two different game modes.
- **Tammy**
    Started to implement time into the projectile movement + blue projectile

### DAY 15: May 30 2019
- **Tammy**
    Had to uncommit the commits made last night because of BIG MERGE CONFLICT; Will merge everything in today + last two days dev log was also uncommited so updated today!; MISSION ACCOMPLISHED -- got the PROJECTILES to finally SHOOT CONTINUOUSLY + made my code a bit more readible with some comments   
- **Peihua**  
    Added the cost of the Plants to the screen. Updated Plants so that they can only be placed if there is enough suns. Added suns that fall every 10 seconds and disappears 5 seconds later if it is not clicked on. Also got sunflower to produce a sun every 7 seconds after it is placed onto the grid.

### DAY 16: May 31 2019
- **Peihua**  
    Worked on debugging projectile for Peashooter. Got the projectile to not disappear until it reaches the Zombie. Will update the game so that a click of a certain key would put it in demo mode (aka cheat mode).
- **Tammy**
    Worked on debugging projectile for Peashooter. Realized that y-coordinate is irrelevant and made zombies die if the HP is zero.

### DAY 17: June 1 2019
- **Peihua**  
    Removed sunflower from random mode (since that mode has no need for suns). Added menu for players to choose between the two game modes. Also added a button at the death screen allowing the player to return to menu and play again. Switching screen was done with hints from Vivian Huynh (She told me I can use a variable to store the different screens). Also made it possible to switch between demo mode and regular game mode.
- **Tammy**
    Had some issues with merge conflicts

### DAY 18: June 2 2019
- **Peihua**
    Added attack method for CherryBomb (it will explode 1.2 seconds after placed). Changed display so Zombie's head and cone will also fall off as it's hp decreases. Plant will change color every time it is attacked. Added a win screen.

## DAY 19: June 3 2019
- **Tammy**
    Implemented the blue projectile so it would slow done the zombies speed (added a zombie variable); sunflower can now produce suns (Peihua implemented this a while ago - in plant attack()); fixed bugs in projectiles
- **Peihua**  
    Moved the Peashooter and SnowPea's attacking code into their respective attack methods. Fixed bug in CherryBomb so that it can't attack Zombies outside of the grid. Fixed bugs in Squash so that it can't kill Zombies that passed it and so that it can't attack zombies not yet in the grid. Fixed bug in Sunflower so that the timer for producing suns only resets after the previous sun produced is either collected or is dead. Made Zombies turn red when hit by peas.
    
## DAY 20: June 4 2019 
- **Tammy** 
    Made README prettier and made final edits to the prototype 
