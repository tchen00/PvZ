import java.util.*;
/* ------------------------------------------------------------------- 
 VARIABLES AND FIELDS                      
 ------------------------------------------------------------------- */
PImage start, lawn, zombie1, zombie2, sun, pea, cherry, wall, squash, snow, end, shovel, shovel_bg, sun_money, sunTracker, cmenu, starticon, headless, winscreen;
Plant next;
ArrayList<Plant> menu, plants, plantRemove;
ArrayList<Zombie> zombies, zombieRemove;
ArrayList<Projectile> projectiles, projectileRemove;
ArrayList<Sun> suns, sunRemove;
Queue<Plant> nextPlants;
Queue<Zombie> nextZombies;
boolean startGame, bover, sover, setup, locked, cool, slocked = false;
Plant[][] hasPlant;
int[] zombieNum;
int screen = -1, sunT, projectileT, sunSum, demo;
int time, coolT = millis();
int[] timess, costs;
boolean[] overs, locks, cools, hasEnoughSun, hover;
float[][] dxys;
int ori_x = 260;
int ori_y = 100;
int w = 99;
int h = 118;
int proj = -1;
float difx, dify, sdifx, sdify = 0.0;
Shovel s;
/* ------------------------------------------------------------------- 
 SHOVEL CLASS                      
 ------------------------------------------------------------------- */
class Shovel {
  PImage img;
  float x, y;
  int row, col;

  Shovel() {
    img = shovel;
    x = 180;
    y = 60;
    row = -1;
    col = -1;
  }

  /* ------------------------------------------------------------------- 
   DISPLAY METHOD                       
   ------------------------------------------------------------------- */
  void display() {
    imageMode(CENTER);
    image(img, this.x, this.y, img.width / 7.0 * 6, img.height / 7.0 * 6);
    imageMode(CORNER);
    if (mouseX > (s.x - s.img.width / 2) && mouseX < (s.x + s.img.width / 2) &&
      mouseY > (s.y - s.img.height / 2) && mouseY < (s.y + s.img.height / 2)) {
      sover = true;
    } else {
      sover = false;
    }
  }
}

/* ------------------------------------------------------------------- 
 SUN CLASS                      
 ------------------------------------------------------------------- */
class Sun {
  PImage img;
  float x, y;
  float target;
  int deathTime;
  boolean over, lock;
  int speed;

  Sun() {
    img = sun_money;
    x = random(ori_x, ori_x + 9 * w - 100);
    y = 0;
    target = random(ori_y, ori_y + 5 * h - 100);
    deathTime = 5000 + millis();
    speed = 5;
  }

  Sun(float a, float b) {
    img = sun_money;
    x = a;
    y = b;
    speed = 0;
    target = random(ori_y, ori_y + 5 * h - 100);
    deathTime = 5000 + millis();
  }

  void display() {
    image(img, this.x, this.y, 100, 100);
  }

  void move() {
    if (this.y < this.target) {
      this.y += this.speed;
    }
  }
}

/* ------------------------------------------------------------------- 
 MAKE THE GRID                      
 ------------------------------------------------------------------- */
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

/* ------------------------------------------------------------------- 
 UPDATING PLANTS (ROW + COL)                     
 ------------------------------------------------------------------- */
void updatePlantRowCol() {
  if (screen == 1) {
    locked = false;
    int coll = (int)(next.x - ori_x) / w;
    int roww = (int)(next.y - ori_y) / h;
    if (next.x > ori_x && next.x < ori_x + 9 * w && 
      next.y > ori_y && next.y < ori_y + 5 * h && hasPlant[roww][coll] == null ) {
      next.row = roww;
      next.col = coll;
      hasPlant[roww][coll] = next;
      next.x = ((ori_x + w * next.col) + (ori_x + w * (next.col + 1))) / 2;
      next.y = ((ori_y + h * next.row) + (ori_y + h * (next.row + 1))) / 2;
      plants.add(next);
      coolT = millis();
      cool = false;
      if (nextPlants.size() < 1) {
        instPlants();
      }
      next = nextPlants.remove();
    } else {
      next.x = 125;
      next.y = 300;
    }
  } else {
    for (int i = 0; i < 6; i++) {
      locks[i] = false;
      Plant p = menu.get(i);
      int coll = (int)(p.x - ori_x) / w;
      int roww = (int)(p.y - ori_y) / h;
      if (sunSum >= costs[i] && p.x > ori_x && p.x < ori_x + 9 * w && 
        p.y > ori_y && p.y < ori_y + 5 * h && hasPlant[roww][coll] == null) {
        p.row = roww;
        p.col = coll;
        hasPlant[roww][coll] = p;
        p.x = ((ori_x + w * p.col) + (ori_x + w * (p.col + 1))) / 2;
        p.y = ((ori_y + h * p.row) + (ori_y + h * (p.row + 1))) / 2;
        plants.add(p);
        p.time = millis();
        timess[i] = millis();
        cools[i] = false;
        sunSum -= costs[i];
        if (i == 0) {
          menu.set(i, new Sunflower(60, 60, sun));
        } else if (i == 1) {
          menu.set(i, new Peashooter(60, 180, pea));
        } else if (i == 2) {
          menu.set(i, new CherryBomb(60, 300, cherry));
        } else if (i == 3) {
          menu.set(i, new WallNut(60, 420, wall));
        } else if (i == 4) {
          menu.set(i, new Squash(60, 540, squash));
        } else {
          menu.set(i, new SnowPea(60, 660, snow));
        }
      } else {
        p.x = 60;
        p.y = 60 + 120 * i;
      }
    }
  }
}
/* ------------------------------------------------------------------- 
 UPDATING SHOVEL                     
 ------------------------------------------------------------------- */
void updateShovelRowCol() {
  slocked = false;
  int ccol = (int)(s.x - ori_x) / w;
  int rrow = (int)(s.y - ori_y) / h;
  if (s.x > ori_x && s.x < ori_x + 9 * w && 
    s.y > ori_y && s.y < ori_y + 5 * h && !(hasPlant[rrow][ccol] == null) ) {
    plants.remove(hasPlant[rrow][ccol]);
    hasPlant[rrow][ccol] = null;
  }
  s = new Shovel();
}

/* ------------------------------------------------------------------- 
 UPDATING X AND Y COORDINATES 
 ------------------------------------------------------------------- */

void updateXY() {
  if (screen == 1) {
    if (locked) {
      next.x = mouseX - difx;
      next.y = mouseY - dify;
    }
  } else {
    for (int i = 0; i < 6; i++) {
      if (locks[i]) {
        menu.get(i).x = mouseX - dxys[0][i];
        menu.get(i).y = mouseY - dxys[1][i];
      }
    }
  }
  if (slocked) {
    s.x = mouseX - sdifx;
    s.y = mouseY - sdify;
  }
}


/* ------------------------------------------------------------------- 
 UPDATE CHANGE IN X AND Y                      
 ------------------------------------------------------------------- */
void updateChangeXY() {
  //print("pressed " + true);
  //print("bover " + bover);
  if (screen == 1) {
    if (bover) {
      locked = true;
    } else {
      locked = false;
    }
    difx = mouseX - next.x;
    dify = mouseY - next.y;
  } else {
    for (int i = 0; i < 6; i++) {
      if (overs[i]) {
        locks[i] = true;
      } else {
        locks[i] = false;
      }
      dxys[0][i] = mouseX - menu.get(i).x;
      dxys[1][i] = mouseY - menu.get(i).y;
    }
  }

  if (sover) {
    slocked = true;
  } else {
    slocked = false;
  }
  sdifx = mouseX - s.x;
  sdify = mouseY - s.y;
}

/* ------------------------------------------------------------------- 
 RANDOMIZING THE ZOMBIES                      
 ------------------------------------------------------------------- */
void instZombies() {
  nextZombies = new LinkedList<Zombie>();
  for (int i = 0; i < 10; i++) {
    float rand = random(0, 2);
    if (rand < 1) {
      int random = (int)(random(5)); 
      nextZombies.add(new BasicZombie(width, random, zombie1));
      //print("zombie here");
      zombieNum[random]++; 
      //print(hasZombie[0][random]); 
      //print("basictrue");
    } else {
      int random = (int)(random(5)); 
      nextZombies.add(new ConeheadZombie(width, random, zombie2));
      zombieNum[random]++; 
      //print("true");
    }
  }
}

/* ------------------------------------------------------------------- 
 RANDOMIZING THE PLANTS                       
 ------------------------------------------------------------------- */
void instPlants() {
  nextPlants = new LinkedList<Plant>();
  for (int i = 0; i < 10; i++) {
    float rand = random(0, 5);
    if (rand < 1) {
      nextPlants.add(new Peashooter(125, 300, pea));
    } else if (rand < 2) {
      nextPlants.add(new CherryBomb(125, 300, cherry));
    } else if (rand < 3) {
      nextPlants.add(new WallNut(125, 300, wall));
    } else if (rand < 4) {
      nextPlants.add(new Squash(125, 300, squash));
    } else {
      nextPlants.add(new SnowPea(125, 300, snow));
    }
  }
}

/* ------------------------------------------------------------------- 
 SETUP - time, background, images, lists, menu                      
 ------------------------------------------------------------------- */
void updateTimes() {
  time = millis();
  coolT = millis();
  projectileT = millis(); 
  setup = true;
  timess = new int[]{millis(), millis(), millis(), millis(), millis(), millis()};
}

void set_bg() {
  image(lawn, 0, 0, width, height);
  pushMatrix();
  translate(120, 0);
  image(shovel_bg, 0, 0, 120, 120);
  popMatrix();
}

void loadImages() {
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
  shovel = loadImage("Shovel.png");
  shovel_bg = loadImage("Shovel_bg.jpg");
  sun_money = loadImage("sun.png");
  sunTracker = loadImage("sunTracker.png");
  cmenu = loadImage("menu.jpg");
  starticon = loadImage("icon.png");
  headless = loadImage("headless.png");
  winscreen = loadImage("winscreen.jpg");
}

void instLists() {
  zombieNum = new int[5];
  hasPlant = new Plant[5][9];
  plants = new ArrayList<Plant>();
  zombies = new ArrayList<Zombie>();
  projectiles = new ArrayList<Projectile>(5); 
  plantRemove = new ArrayList<Plant>();
  zombieRemove = new ArrayList<Zombie>();
  projectileRemove = new ArrayList<Projectile>();
  menu = new ArrayList<Plant>();
  menu.add(new Sunflower(60, 60, sun));
  menu.add(new Peashooter(60, 180, pea));
  menu.add(new CherryBomb(60, 300, cherry));
  menu.add(new WallNut(60, 420, wall));
  menu.add(new Squash(60, 540, squash));
  menu.add(new SnowPea(60, 660, snow));
  overs = new boolean[6];
  dxys = new float[2][6];
  locks = new boolean[6];
  cools = new boolean[6];
  //sunSum = 100;
  costs = new int[]{50, 100, 150, 50, 50, 175};
  suns = new ArrayList<Sun>();
  sunRemove = new ArrayList<Sun>();
  hasEnoughSun = new boolean[6];
  hover = new boolean[4];
}

void displayPlantMenu() {
  if (screen == 2) {
    for (int i = 0; i < 6; i++) {
      stroke(0);
      fill(255, 240, 179);
      strokeWeight(1);
      rect(0, 120 * i, 120, 120);
      Plant p = menu.get(i);
      p.display();
      if (millis() > timess[i] + 6000 - 4000 * demo) {
        cools[i] = true;
      }
      hasEnoughSun[i] = (sunSum >= costs[i]);
      if (cools[i] && mouseX > (p.x - p.pw / 2) && mouseX < (p.x + p.pw / 2) &&
        mouseY > (p.y - p.ph / 2) && mouseY < (p.y + p.ph / 2)) {
        overs[i] = true;
      } else {
        overs[i] = false;
      }
    }
  } else {
    pushMatrix();
    fill(255, 240, 179);
    stroke(0);
    translate(50, 200);
    rect(0, 0, 150, 200);
    popMatrix();
    //makeGrid();

    if (millis() > coolT + 3000 - 2000 * demo) {
      cool = true;
    }
    if (cool && mouseX > (next.x - next.pw / 2) && mouseX < (next.x + next.pw / 2) &&
      mouseY > (next.y - next.ph / 2) && mouseY < (next.y + next.ph / 2)) {
      bover = true;
    } else {
      bover = false;
    }
    next.display();
  }
}

void spawnZombies() {
  if (millis() > time - 6000 * demo + 8000) {
    time = millis();
    if (nextZombies.peek() != null) {
      zombies.add(nextZombies.remove());
    }
  }
}

void cooldownDisplay() {
  pushMatrix();
  fill(10, 80);
  noStroke();
  translate(50, 200);
  if (screen == 1) {
    if (!cool) {
      rect(0, 0, 150, 200 - (millis() - coolT) / (3000.0 - 2000 * demo) * 200);
    }
  }
  popMatrix();
  if (screen == 2) {
    for (int i = 0; i < 6; i++) {
      if (!cools[i]) {
        rect(0, 120 * i, 120, 120 - (millis() - timess[i]) / (6000.0 - 4000 * demo) * 120);
      }
      if (!hasEnoughSun[i]) {
        rect(0, 120 * i, 120, 120);
      }
    }
  }
}

void zombieAction() {
  for (Zombie zzz : zombies) {
    zzz.display();
    zzz.move();
    zzz.attack();
    for (Plant pla : plants) {
      if (plants.contains(pla) && (pla.row  == zzz.row) && 
        (zzz.x <= pla.x + pla.pw / 2) && (zzz.x >= pla.x - pla.pw / 2)) {
        if (zzz.target == null) {
          zzz.target = pla;
        }
      }
    }
    if (zzz.hp <= 0) {
      zombieRemove.add(zzz);
    }
    if (zzz.x < 161) {
      screen = 0;
    }
  }
}

void removeAndUpdatePlantsZombies() {
  for (Zombie z : zombieRemove) {
    if (zombies.contains(z)) {
      zombieNum[z.row]--;
      zombies.remove(z);
    }
  }
  if (plantRemove.size() > 100 || zombieRemove.size() > 100) {
    zombieRemove = new ArrayList<Zombie>();
    plantRemove = new ArrayList<Plant>();
  }
  for (Plant p : plantRemove) {
    if (plants.contains(p)) {
      plants.remove(p);
    }
  }
}

void removeProjectile() {
  for (Projectile p : projectileRemove) {
    if (projectiles.contains(p)) {
      projectiles.remove(p);
    }
  }
} 

void setupSun() {
  float sunH = sunTracker.height * 120.0 / sunTracker.width;
  image(sunTracker, 120, 120, 120, sunH);
  fill(255, 240, 179);
  stroke(0);
  rect(120, 120 + sunH, 120, 240);
  textAlign(CENTER);
  textSize(30);
  fill(0);
  text(sunSum, 180, 242);
  textSize(18);
  text("Cost", 180, sunH + 140);
  textAlign(LEFT);
  textSize(12);
  text("Sunflower: 50 \n\nPeashooter: 100 \n\nCherry Bomb: 150 \n\nWall Nut: 50 \n\nSquash: 50 \n\nSnow Pea: 175", 130, sunH + 160);
}

void fallingSuns() {
  if (millis() > sunT + 10000) {
    suns.add(new Sun());
    sunT = millis();
  }
  for (Sun sss : suns) {
    sss.move();
    sss.display();
    if (millis() > sss.deathTime) {
      sunRemove.add(sss);
    }
    if (mouseX > (sss.x) && mouseX < (sss.x + 100) &&
      mouseY > (sss.y) && mouseY < (sss.y + 100)) {
      sss.over = true;
    } else {
      sss.over = false;
    }
  }
  for (Sun ss : sunRemove) {
    suns.remove(ss);
  }
  if (sunRemove.size() > 100) {
    sunRemove = new ArrayList<Sun>();
  }
}

void collectSun() {
  for (Sun sss : suns) {
    if (sss.over) {
      sunSum += 500; // tammy cheated here  
      sunRemove.add(sss);
    }
  }
}

void updatePlant() {
  // FOR THE PLANTS 
  for (Plant pla : plants) {
    pla.display();
    pla.attack();
    if (pla.health <= 0) {
      hasPlant[pla.row][pla.col] = null;
      plantRemove.add(pla);
    }
    /*
    if (pla.type == 3){
     if (millis() > sunT + 10000) {
     suns.add(new Sun(pla.x, pla.y));
     sunT = millis();
     }
     for (Sun sss : suns) {
     sss.move();
     sss.display();
     if (millis() > sss.deathTime) {
     sunRemove.add(sss);
     }
     if (mouseX > (sss.x) && mouseX < (sss.x + 100) &&
     mouseY > (sss.y) && mouseY < (sss.y + 100)) {
     sss.over = true;
     } else {
     sss.over = false;
     }
     }
     for (Sun ss : sunRemove) {
     suns.remove(ss);
     }
     if (sunRemove.size() > 100) {
     sunRemove = new ArrayList<Sun>();
     }
     }
     */
  }
}

void updateProjectile() {
  // FOR THE PROJECTILES -- IN THE WORKS ATM 
  for (Projectile p : projectiles) {
    //print("projectile");
    if (zombies.contains(p.target)) {
      if (p.x < p.target.x + 3) {
        //print(zombieNum[p.row]);
        p.display(); 
        p.move();
      } else {
        if (p.type == 2) {
          p.target.speed = 0.6;
        }
        p.target.hurt = true;
        p.target.displayed = false;
        p.target.hp -= p.damage;
        projectileRemove.add(p);
      }
    }
  }
}

void setupMenu() {
  textSize(60);
  image(cmenu, 0, 0);
  rectMode(CENTER);
  stroke(160, 82, 45);
  fill(255, 240, 179);
  if (mouseX > 390 && mouseX < 890 && mouseY > 130 && mouseY < 230) {
    strokeWeight(5);
    hover[0] = true;
  } else {
    strokeWeight(1);
    hover[0] = false;
  }
  rect(640, 180, 500, 100);
  textAlign(CENTER);
  if (mouseX > 390 && mouseX < 890 && mouseY > 490 && mouseY < 590) {
    strokeWeight(5);
    hover[1] = true;
  } else {
    strokeWeight(1);
    hover[1] = false;
  }
  rect(640, 540, 500, 100);
  rectMode(CORNER);
  fill(0);
  text("Random Mode", 640, 205);
  text("Adventure Mode", 640, 565);
}

void enterGame() {
  if (hover[0] == true) {
    screen = 1;
  }
  if (hover[1] == true) {
    screen = 2;
  }
  if (hover[2] == true || hover[3] == true) {
    reset();
    screen = 3;
  }
}

void reset() {
  instLists();
  instZombies();
  instPlants();
  setup = false;
  sunSum = 0;
}

void tryAgain() {
  textSize(60);
  rectMode(CENTER);
  stroke(160, 82, 45);
  fill(255, 240, 179);
  if (mouseX > 390 && mouseX < 890 && mouseY > 540 && mouseY < 640) {
    strokeWeight(5);
    hover[2] = true;
  } else {
    strokeWeight(1);
    hover[2] = false;
  }
  textAlign(CENTER);
  rect(640, 600, 500, 80);
  rectMode(CORNER);
  fill(0);
  text("Return to Menu", 640, 630);
}

void startGame() {
  if (mouseX > 200 && mouseX < 1030 && mouseY > 630 && mouseY < 710) {
    hover[3] = true;
  } else {
    hover[3] = false;
  }
  if (hover[3]) {
    image(starticon, 0, 0, width, height);
  } else {
    image(start, 0, 0, width, height);
  }
}

// SETUP METHOD 
void setup() {
  size(1280, 720);
  loadImages();
  image(start, 0, 0, width, height);
  reset();
  next = nextPlants.remove();
  s = new Shovel();
}

// DRAW METHOD 
void draw() {
  // ONCE CLICKED AND ONTO THE NEXT FRAME 
  if (screen == -1) {
    startGame();
  }
  if (screen == 3) {
    setupMenu();
  }
  if (screen == 4) {
    image(winscreen, 0, 0);
    tryAgain();
  }
  if (screen == 1 || screen == 2) {
    if (nextZombies.size() == 0 && zombies.size() == 0) {
      screen = 4;
    }
    if (!setup) {
      updateTimes();
      suns.add(new Sun());
      sunT = millis();
    }
    set_bg();
    if (screen == 2) {
      setupSun();
      fallingSuns();
    }
    displayPlantMenu();
    s.display();
    spawnZombies();
    updatePlant();
    updateProjectile();
    cooldownDisplay();
    zombieAction();
    removeAndUpdatePlantsZombies();
    removeProjectile();
  }
  if (screen == 0) {
    image(end, 0, 0);
    tryAgain();
  }
}


void mousePressed() {
  enterGame();
  updateChangeXY();
  collectSun();
}

void mouseDragged() {
  updateXY();
}

void mouseReleased() {
  updatePlantRowCol();
  updateShovelRowCol();
}

void keyPressed() {
  if (key == 'D' || key == 'd') {
    demo = 1;
    sunSum = 1000;
  }
  if (key == 'R' || key == 'r') {
    demo = 0;
    sunSum = 0;
  }
}

boolean checkPlant(int row, int col) {
  return (!(hasPlant[row][col] == null) && zombieNum[row] > 0);
}
