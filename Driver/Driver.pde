import java.util.*;

PImage start, lawn, zombie1, zombie2, plant1, end;
ArrayList<Plant> plants;
ArrayList<Zombie> zombies;
Queue<Plant> nextPlants;
Queue<Zombie> nextZombies;
boolean startGame;
int time;

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
      nextZombies.add(new BasicZombie(width, (int)(random(5)), zombie1));
    } else {
      nextZombies.add(new ConeheadZombie(width, (int)(random(5)), zombie2));
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
  end = loadImage("end.png");
  image(start, 0, 0, width, height);
  instZombies();
  instPlants();
  plants = new ArrayList<Plant>();
  zombies = new ArrayList<Zombie>();
  time = millis();
}

void mouseClicked() {
  startGame = true;
}

void mousePressed(){
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
    boolean game_over = false;
    if (millis() > time + 8000) {
      time = millis();
      if (nextZombies.peek() != null) {
        zombies.add(nextZombies.remove());
      }
    }
    for (Zombie zzz: zombies){
      zzz.display();
      zzz.move();
      if (zzz.hp <= 0){
        zombies.remove(zzz);
      }
      if (zzz.x < 161){
        game_over = true;
      }
    }
    for (Plant pla: plants){
      pla.display();
    }
    if (nextPlants.poll() == null){
      instPlants();
    }
    Sunflower c = new Sunflower(60, 250, plant1); 
    c.display();
    if (game_over){
      noLoop();
      image(end, 0, 0);
    }
  }
}