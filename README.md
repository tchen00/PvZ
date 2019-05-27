# Plant vs. Zombies
mks22x-final project: floofy sleeping ducks

## :star: Project Description
recreation of the plant vs zombies game - tbd [will be updated at a later time :sleepy:]

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

## DAY 10: May 25 2019  
- **Peihua**  
    Found a bug where the timer started before the game started and the Zombie will spawn right away. Finished Zombie attack. Also fixed bug involving removing plants and zombies (I didn't realize I was modifying in the ArrayList I'm removing from, oops).

## DAY 11: May 26 2019
- **Peihua**  
    Updated Zombie attack so Plant dies after 5 bites (one bite per second). Added a cool-down timer for adding plants and a semi-transparent gray rectangle to let the player know when they can add more plants.
