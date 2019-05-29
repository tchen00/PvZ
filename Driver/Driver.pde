import java.util.*;
// INSTANCE AND FIELDS 
PImage start, lawn, zombie1, zombie2, sun, pea, cherry, wall, squash, snow, end, shovel, shovel_bg;
Plant next, peaNext;
ArrayList<Plant> menu;
ArrayList<Plant> plants;
ArrayList<Plant> plantRemove;
ArrayList<Zombie> zombies;
ArrayList<Zombie> zombieRemove;
ArrayList<greenProjectile> projectiles; 
Queue<Plant> nextPlants;
Queue<Zombie> nextZombies;
boolean startGame, bover, sover, setup, locked, cool, slocked = false;
Plant[][] hasPlant = new Plant[5][9];
boolean[][] hasZombie = {{true, true, true, true, true}, {false, false, false, false, false}}; 
boolean randomMode = false;
int time, coolT= millis();
int projectileT; 
int[] timess;
boolean[] overs, locks, cools;
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
    image(img, x, y, img.width / 7.0 * 6, img.height / 7.0 * 6);
    imageMode(CENTER);
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

// RANDOMIZING THE ZOMBIES 
void instZombies() {
  nextZombies = new LinkedList<Zombie>();
  for (int i = 0; i < 10; i++) {
    float rand = random(0, 2);
    if (rand < 1) {
      int random = (int)(random(5)); 
      nextZombies.add(new BasicZombie(width, random, zombie1));
      //print("zombie here");
      hasZombie[0][random] = true; 
      //print(hasZombie[0][random]); 
      //print("basictrue");
    } else {
      int random = (int)(random(5)); 
      nextZombies.add(new ConeheadZombie(width, random, zombie2));
      hasZombie[0][random] = true; 
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

// SETUP METHOD 
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
  shovel = loadImage("Shovel.png");
  shovel_bg = loadImage("Shovel_bg.jpg");
  image(start, 0, 0, width, height);
  instZombies();
  instPlants();
  next = nextPlants.remove();
  plants = new ArrayList<Plant>();
  zombies = new ArrayList<Zombie>();
  projectiles = new ArrayList<greenProjectile>(5); 
  plantRemove = new ArrayList<Plant>();
  zombieRemove = new ArrayList<Zombie>();
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
  }
  s = new Shovel();
}

// IF MOUSE CLICKED -- LOAD NEXT SCREEN
void mouseClicked() {
  startGame = true;
}

// DRAW METHOD 
void draw() {
  // ONCE CLICKED AND ONTO THE NEXT FRAME 
  if (startGame) {
    if (!setup) {
      time = millis();
      coolT = millis();
      projectileT = millis(); 
      setup = true;
      timess = new int[]{millis(), millis(), millis(), millis(), millis(), millis()};
    }
    image(lawn, 0, 0, width, height);
    pushMatrix();
    translate(120, 0);
    image(shovel_bg, 0, 0, 120, 120);
    popMatrix();
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
      s.display();
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
    if (mouseX > (s.x - s.img.width / 2) && mouseX < (s.x + s.img.width / 2) &&
      mouseY > (s.y - s.img.height / 2) && mouseY < (s.y + s.img.height / 2)) {
      sover = true;
    } else {
      sover = false;
    }
    boolean game_over = false;
    if (millis() > time + 8000) {
      time = millis();
      if (nextZombies.peek() != null) {
        zombies.add(nextZombies.remove());
      }
    }

    // FOR THE PLANTS 
    for (Plant pla : plants) {
      pla.display();
      if (pla.health <= 0) {
        hasPlant[pla.row][pla.col] = null;
        plantRemove.add(pla);
      }
      if (hasZombie[0][pla.getRow()] && pla.getType() == 1 ) {
        //print(hasZombie[1][pla.getRow()]); //debugging purposes 
        if (!hasZombie[1][pla.getRow()]) {
          //projectileT = millis(); 
          if (pla.firstS()){
            projectiles.add(new greenProjectile(pla.getX(), pla.getY(), 10)); 
            pla.startTime();
            hasZombie[1][pla.getRow()] = true; 
            proj++;
            pla.firstSetter(); 
          }
          print(pla.checkTime()); 
          if (pla.checkTime() > 50000){
            projectiles.add(new greenProjectile(pla.getX(), pla.getY(), 10)); 
            print("new projectile made"); 

          }
          //print("projectile"); 
           
          //g.display(); 
          //g.get 
          //g.move(); 
          //print(g.getX());
        }
      }
    }
    //boolean active = false; 
    // FOR THE PROJECTILES -- IN THE WORKS ATM 
    for (greenProjectile p : projectiles) {
      p.display(); 
      //background(2);
      // p.clear; 
      //projectiles.remove(p);
      //projectiles.remove(p); 
      //p.move();
      p.setX(5);
      //p.display();
    }
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
      }
    }
    /*
    for (greenProjectile p : projectiles){
     p.display(); 
     p.move(); 
     }
     */
    // ZOMBIES 
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
      for (Zombie z : zombieRemove) {
        if (zombies.contains(z)) {
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
      if (game_over) {
        noLoop();
        image(end, 0, 0);
      }
    }
  }
}


void mousePressed() {
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

void mouseDragged() {
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

void mouseReleased() {
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
      if (p.x > ori_x && p.x < ori_x + 9 * w && 
        p.y > ori_y && p.y < ori_y + 5 * h && hasPlant[roww][coll] == null ) {
        p.row = roww;
        p.col = coll;
        hasPlant[roww][coll] = p;
        p.x = ((ori_x + w * p.col) + (ori_x + w * (p.col + 1))) / 2;
        p.y = ((ori_y + h * p.row) + (ori_y + h * (p.row + 1))) / 2;
        plants.add(p);
        timess[i] = millis();
        cools[i] = false;
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

boolean checkPlant(int row, int col) {
  return (!(hasPlant[row][col] == null) && hasZombie[0][row] == true);
}
