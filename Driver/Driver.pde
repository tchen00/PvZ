import java.util.*;
// INSTANCE AND FIELDS 
PImage start, lawn, zombie1, zombie2, sun, pea, cherry, wall, squash, snow, end;
Plant next, peaNext;
ArrayList<Plant> plants;
ArrayList<Plant> plantRemove;
ArrayList<Zombie> zombies;
ArrayList<Zombie> zombieRemove;
ArrayList<greenProjectile> projectiles; 
Queue<Plant> nextPlants;
Queue<Zombie> nextZombies;
boolean startGame, bover, setup, locked, cool = false;
boolean[][] hasPlant = new boolean[5][9];
boolean[][] hasZombie = {{true, true, true, true, true},{false, false, false, false, false}}; 
int time, coolT, projectileT = millis();
int ori_x = 260;
int ori_y = 100;
int w = 99;
int h = 118;
float difx, dify = 0.0;
int proj = -1;
// MAKING THE GRID !!!
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
  image(start, 0, 0, width, height);
  instZombies();
  instPlants();
  next = nextPlants.remove();
  plants = new ArrayList<Plant>();
  zombies = new ArrayList<Zombie>();
  projectiles = new ArrayList<greenProjectile>(5); 
  plantRemove = new ArrayList<Plant>();
  zombieRemove = new ArrayList<Zombie>();
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
    }
    image(lawn, 0, 0, width, height);
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
      mouseY > (next.y - next.pw / 2) && mouseY < (next.y + next.ph / 2)) {
      bover = true;
    } else {
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

    // FOR THE PLANTS 
    for (Plant pla : plants) {
      pla.display();
      if (pla.health <= 0) {
        plantRemove.add(pla);
      }
      if (hasZombie[0][pla.getRow()]){
        //print(hasZombie[1][pla.getRow()]); //debugging purposes 
        if (!hasZombie[1][pla.getRow()]){
          projectiles.add(new greenProjectile(pla.getX(), pla.getY(), 10)); 
          hasZombie[1][pla.getRow()] = true; 
          print("projectile"); 
          proj++; 
          //g.display(); 
          //g.get 
          //g.move(); 
          //print(g.getX()); 
        }
      }
      
    }
    //boolean active = false; 
    // FOR THE PROJECTILES -- IN THE WORKS ATM 
    for (greenProjectile p: projectiles){
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
    if (!cool) {
      rect(0, 0, 150, 200 - (millis() - coolT) / 3000.0 * 200);
    }
    popMatrix();
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
        if (plants.contains(pla) && (pla.row  == zzz.row) && (zzz.x <= pla.x + pla.pw / 2)) {
          if (zzz.target == null){
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
      if (plantRemove.size() > 100 || zombieRemove.size() > 100){
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
  int coll = (int)(next.x - ori_x) / w;
  int roww = (int)(next.y - ori_y) / h;
  if (next.x > ori_x && next.x < ori_x + 9 * w && 
    next.y > ori_y && next.y < ori_y + 5 * h && !hasPlant[roww][coll] ) {
    next.row = roww;
    next.col = coll;
    hasPlant[roww][coll] = true;
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
}

boolean checkPlant(int row, int col){
  return (hasPlant[row][col] == true && hasZombie[0][row] == true);
}
