import java.util.*;

PImage start, lawn, zombie1, zombie2, sun, pea, cherry, wall, squash, snow, end;
Plant next, peaNext;
ArrayList<Plant> plants;
ArrayList<Zombie> zombies;
Queue<Plant> nextPlants;
Queue<Zombie> nextZombies;
boolean startGame, bover, locked = false;
int time;
int ori_x = 260;
int ori_y = 100;
int w = 99;
int h = 118;
float difx, dify = 0.0;

void makeGrid() {
  noFill();
  pushMatrix();
  translate(ori_x, ori_y);
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 5; j++) {
      rect(i * w, j * h, w, h);
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
      nextPlants.add(new Sunflower(125, 300, sun));
    } else if (rand < 2) {
      nextPlants.add(new Peashooter(125, 300, pea));
    } else if (rand < 3) {
      nextPlants.add(new CherryBomb(125, 300, cherry));
    } else if (rand < 4) {
      nextPlants.add(new WallNut(125, 300, wall));
    } else if (rand < 5) {
      nextPlants.add(new Squash(125, 300, squash));
    } else {
      nextPlants.add(new SnowPea(125, 300, snow));
    }
  }
}

void setup() {
  size(1280, 720);
  start = loadImage("start_screen.png");
  lawn = loadImage("lawn.png");
  zombie1 = loadImage("basiczombie.png");
  zombie2 = loadImage("coneheadzombie.png");
  sun = loadImage("sunflower.png");
  pea = loadImage("peashooter.png");
  cherry = loadImage("cherrybomb.png");
  wall = loadImage("wallnut.png");
  squash = loadImage("squash.png");
  snow = loadImage("snowpea.png");
  end = loadImage("end.png");
  image(start, 0, 0, width, height);
  instZombies();
  instPlants();
  next = nextPlants.remove();
  plants = new ArrayList<Plant>();
  zombies = new ArrayList<Zombie>();
  time = millis();
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
    if (mouseX > (next.x - next.pw / 2) && mouseX < (next.x + next.pw / 2) &&
      mouseY > (next.y - next.pw / 2) && mouseY < (next.y + next.ph / 2)) {
      bover = true;
    }
    else{
      bover = false;
    }
    next.display();
    boolean game_over = false;
    if (millis() > time + 8000) {
      time = millis();
      if (nextZombies.peek() != null) {
        zombies.add(nextZombies.remove());
      }
    }
    for (Zombie zzz : zombies) {
      zzz.display();
      zzz.move();
      if (zzz.hp <= 0) {
        zombies.remove(zzz);
      }
      if (zzz.x < 161) {
        game_over = true;
      }
    }
    for (Plant pla : plants) {
      pla.display();
    }
    if (nextPlants.size() < 1) {
      instPlants();
    }
    if (game_over) {
      noLoop();
      image(end, 0, 0);
    }
  }
}


void mousePressed() {
  //print("pressed " + true);
  //print("bover " + bover);
  if (bover) {
    locked = true;
  } else {
    locked = false;
  }
  difx = mouseX - next.x;
  dify = mouseY - next.y;
}

void mouseDragged() {
  if (locked) {
    next.x = mouseX - difx;
    next.y = mouseY - dify;
  }
}

void mouseReleased() {
  locked = false;
  if (next.x > ori_x && next.x < ori_x + 9 * w && next.y > ori_y && next.y < ori_y + 5 * h){
    next.row = (int)(next.x - ori_x) / w;
    next.col = (int)(next.y - ori_y) / h;
    next.x = ((ori_x + w * next.row) + (ori_x + w * (next.row + 1))) / 2;
    next.y = ((ori_y + h * next.col) + (ori_y + h * (next.col + 1))) / 2;
    plants.add(next);
    next = nextPlants.remove();
  }
  else{
    next.x = 125;
    next.y = 300;
  }
}
