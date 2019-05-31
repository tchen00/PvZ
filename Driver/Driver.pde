import java.util.*;
// INSTANCE AND FIELDS 
PImage start, lawn, zombie1, zombie2, sun, pea, cherry, wall, squash, snow, end, shovel, shovel_bg, sun_money, sunTracker;
Plant next, peaNext;
ArrayList<Plant> menu;
ArrayList<Plant> plants;
ArrayList<Plant> plantRemove;
ArrayList<Zombie> zombies;
ArrayList<Zombie> zombieRemove;
ArrayList<Projectile> projectiles; 
ArrayList<Projectile> projectileRemove;
ArrayList<Sun> suns;
ArrayList<Sun> sunRemove;
Queue<Plant> nextPlants;
Queue<Zombie> nextZombies;
boolean startGame, bover, sover, setup, locked, cool, slocked, game_over = false;
Plant[][] hasPlant = new Plant[5][9];
int[] zombieNum = new int[5];
boolean randomMode;
int time, coolT = millis();
int sunT;
int projectileT; 
int[] timess, costs;
int sunSum;
boolean[] overs, locks, cools, hasEnoughSun;
float[][] dxys;
int ori_x = 260;
int ori_y = 100;
int w = 99;
int h = 118;
int proj = -1;
float difx, dify, sdifx, sdify = 0.0;
Shovel s;

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

// MAKING THE GRID ! ! !
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

void updatePlantRowCol() {
  if (randomMode) {
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

void updateXY() {
  if (randomMode) {
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

void updateChangeXY() {
  //print("pressed " + true);
  //print("bover " + bover);
  if (randomMode) {
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

// RANDOMIZING THE ZOMBIES 
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

// RANDOMIZING THE PLANTS 
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
}

void instLists() {
  plants = new ArrayList<Plant>();
  zombies = new ArrayList<Zombie>();
  projectiles = new ArrayList<Projectile>(5); 
  plantRemove = new ArrayList<Plant>();
  zombieRemove = new ArrayList<Zombie>();
  projectileRemove = new ArrayList<Projectile>();
  if (!randomMode) {
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
  }
}

void displayPlantMenu() {
  if (!randomMode) {
    for (int i = 0; i < 6; i++) {
      stroke(0);
      fill(255, 240, 179);
      rect(0, 120 * i, 120, 120);
      Plant p = menu.get(i);
      p.display();
      if (millis() > timess[i] + 6000) {
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

    if (millis() > coolT + 3000) {
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
  if (millis() > time + 8000) {
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
  if (randomMode) {
    if (!cool) {
      rect(0, 0, 150, 200 - (millis() - coolT) / 3000.0 * 200);
    }
  }
  popMatrix();
  if (!randomMode) {
    for (int i = 0; i < 6; i++) {
      if (!cools[i]) {
        rect(0, 120 * i, 120, 120 - (millis() - timess[i]) / 6000.0 * 120);
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
      game_over = true;
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
    if (nextPlants.size() < 1) {
      instPlants();
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
      sunSum += 25; // tammy cheated here  
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

    if ((zombieNum[pla.getRow()] > 0)&& (pla.getType() == 1 || pla.getType() == 2) ) {
      if (pla.firstS()) {
        if (pla.getType() == 1) {
          projectiles.add(new greenProjectile(pla.getX(), pla.getY(), 10));
        } 
        if (pla.getType() == 2) {
          projectiles.add(new blueProjectile(pla.getX(), pla.getY(), 10));
        }
        print(pla.checkTime());
        //hasZombie[1][pla.getRow()] = true; 
        proj++;
        pla.startTime(); 
        pla.firstSetter();
      }
      if (millis() >=  3000 + pla.checkTime() ) {
        print("reached");
        if (pla.getType() == 1) {
          //delay(1);
          print("in here");
          projectiles.add(new greenProjectile(pla.getX(), pla.getY(), 10)); 
          //print(projectiles.size()); 
          pla.resetProjectile(); 
          //print(pla.checkTime());
        }
        if (pla.getType() == 2) {
          print("in blue"); 
          projectiles.add(new blueProjectile(pla.getX(), pla.getY(), 10)); 
          pla.resetProjectile(); 
          //print(pla.checkTime());
        }
        //print("new projectile made");
      }
    }
  }
}

void updateProjectile() {
  // FOR THE PROJECTILES -- IN THE WORKS ATM 
  for (Projectile p : projectiles) {
    //print("projectile");
    p.display(); 
    p.move();
  }
}

void checkMotion() {
  for (Projectile p : projectiles) {
    for (Zombie z : zombies) {
      if ((p.getX() < z.getX() + 3 && p.getX() > z.getX() - 3) || 
        (p.getY() < z.getY() + 3 && p.getY() > z.getY() - 3) ) {
        print(z.getHP() + "\n");
        //print("in this loop");
        z.damage(); 
        projectileRemove.add(p); 
        print(z.getHP());
      }
    }
  }
}

// SETUP METHOD 
void setup() {
  size(1280, 720);
  loadImages();
  image(start, 0, 0, width, height);
  instZombies();
  instPlants();
  next = nextPlants.remove();
  instLists();
  s = new Shovel();
}

// IF MOUSE CLICKED -- LOAD NEXT SCREEN
void mouseClicked() {
  if (!startGame) {
    if (mouseX < width/2) {
      randomMode = true;
    } else {
      randomMode = false;
    }
    startGame = true;
  }
}

// DRAW METHOD 
void draw() {
  // ONCE CLICKED AND ONTO THE NEXT FRAME 
  if (startGame) {
    if (!setup) {
      updateTimes();
      suns.add(new Sun());
      sunT = millis();
    }
    set_bg();
    if (!randomMode) {
      setupSun();
      fallingSuns();
    }
    displayPlantMenu();
    s.display();
    game_over = false;
    spawnZombies();
    updatePlant();
    updateProjectile();
    checkMotion();
    cooldownDisplay();
    zombieAction();
    removeAndUpdatePlantsZombies();
    removeProjectile();
    if (game_over) {
      noLoop();
      image(end, 0, 0);
    }
  }
}


void mousePressed() {
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

boolean checkPlant(int row, int col) {
  return (!(hasPlant[row][col] == null) && zombieNum[row] > 0);
}
