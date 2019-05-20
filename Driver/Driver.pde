interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

import java.util.*;

PImage start, lawn, zombie1, zombie2, plant1;
ArrayList<Plant> plants;
ArrayList<Zombie> zombies;
Queue<Plant> nextPlants;
Queue<Zombie> nextZombies;
boolean startGame;

void makeGrid() {
  noFill();
  pushMatrix();
  translate(260, 100);
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 5; j++) {
      rect(i * 99, j * 118, 99, 118);
    }
  }
  popMatrix();
}

void instZombies() {
  nextZombies = new LinkedList<Zombie>();
  for (int i = 0; i < 10; i++) {
    float rand = random(0, 2);
    if (rand < 1) {
      nextZombies.add(new BasicZombie( width - 10, (int)(random(5)), zombie1));
    } else {
      nextZombies.add(new ConeheadZombie( width - 10, (int)(random(5)), zombie2));
    }
  }
}

void instPlants() {
  nextPlants = new LinkedList<Plant>();
  for (int i = 0; i < 10; i++) {
    float rand = random(0, 6);
    if (rand < 1) {
      nextPlants.add(new Sunflower());
    } else if (rand < 2) {
      //nextPlants.add(new Peashooter());
    } else if (rand < 3) {
      //nextPlants.add(new CherryBomb());
    } else if (rand < 4) {
      //nextPlants.add(new WallNut());
    } else if (rand < 5) {
      //nextPlants.add(new Squash());
    } else {
      //nextPlants.add(new SnowPea());
    }
  }
}

void setup() {
  size(1280, 720);
  start = loadImage("start_screen.png");
  lawn = loadImage("lawn.png");
  zombie1 = loadImage("basiczombie.png");
  zombie2 = loadImage("coneheadzombie.png");
  plant1 = loadImage("sunflower.png"); 
  image(start, 0, 0, width, height);
  instZombies();
  instPlants();
  plants = new ArrayList<Plant>();
  zombies = new ArrayList<Zombie>();
  zombies.add(new BasicZombie(width - 100, (int)(random(5)) * 100 + 80, zombie1));
  zombies.add(new ConeheadZombie(width - 100, (int)(random(5)) * 100 + 70, zombie2));
}

void mouseClicked() {
  startGame = true;
}

void draw() {
  if (startGame) {
    image(lawn, 0, 0, width, height);
    pushMatrix();
    fill(255, 240, 179);
    translate(50, 200);
    rect(0, 0, 150, 200);
    popMatrix();
    makeGrid();
    for (Displayable thing : zombies) {
      thing.display();
    }
    for (Moveable thing : zombies) {
      thing.move();
    }
    Sunflower c = new Sunflower(1000, 1000, plant1); 
    c.display();
  }
}
