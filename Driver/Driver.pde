import java.util.*;

PImage start, lawn, zombie1, zombie2, plant1, plant2, end;
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
      //nextPlants.add(new Sunflower());
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
  plant1 = loadImage("wallnut.png"); 
  //plant2 = loadImage("peashooter.png"); 
  end = loadImage("end.png");
  next = new WallNut(125, 300, plant1);
  //peaNext = new Peashooter(200, 300, plant2); 
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

void draw() {
  if (startGame) {
    image(lawn, 0, 0, width, height);
    pushMatrix();
    fill(255, 240, 179);
    translate(50, 200);
    rect(0, 0, 150, 200);
    popMatrix();
    makeGrid();
    if (mouseX > (next.x) && mouseX < (next.x + next.img.width / 10.0) &&
      mouseY > (next.y) && mouseY < (next.y + next.img.height / 10.0)) {
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
    if (nextPlants.poll() == null) {
      instPlants();
    }
    if (game_over) {
      noLoop();
      image(end, 0, 0);
    }
  }
}


void mousePressed() {
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
  }
  else{
    next.x = 125;
    next.y = 300;
  }
}
