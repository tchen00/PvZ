abstract class Plant {
  PImage img; 
  int price, cooldown, row, col, health, type; 
  float x, y, x_co, y_co, ph, pw; 
  boolean is_planted = false; 
  int projectileT, placed; 
  boolean firstShot = true; 

  Plant() {
  }


  Plant(PImage img1, int price1, int cooldown1, float x_cor, float y_cor, float pwA, float phA, int health) {
    img = img1; 
    price = price1; 
    cooldown = cooldown1;
    x = x_cor; 
    y = y_cor; 
    row = -1;
    col = -1;
    ph = phA;
    pw = pwA;
    this.health = health; 
    type = 0; 
    //is_planted = true;
  }

  abstract void display(); 
  void getDamage() {
    health -= 5;
  }

  int getRow() {
    return row;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  int getType() {
    return type;
  }

  void startTime() {
    projectileT = millis(); 
    print("time started");
  }

  int checkTime() {
    return projectileT;
  }

  boolean firstS() {
    return firstShot;
  }

  void firstSetter() {
    firstShot = false;
  }

  void resetProjectile() {
    projectileT = 0; 
    projectileT = millis();
  }

  abstract void attack();
}

class Sunflower extends Plant {
  int speed, time, cost;
  //PImage img; 
  void attack() {
    if (this.time == 0) {
      this.time = millis();
    }
    if (millis() > this.time + 7000) {
      suns.add(new Sun(this.x, this.y));
      this.time = millis();
    }
  }

  Sunflower(float x_co, float y_co, PImage imgx) {
    super(imgx, 50, 5, x_co, y_co, imgx.width * 1/10, imgx.height * 1/10, 200);
    type = 3;
  }
  /*
  Sunflower(){
   PImage imgx = loadImage("sunflower.png"); 
   img = imgx; 
   speed = 3; 
   time = 0; 
   cost = 50; 
   }
   */
  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }
}

class Peashooter extends Plant {
  int speed; 
  void attack() {
  }
  Peashooter() {
    //super(imgx, 100, 5, x_co, y_co);
  }

  Peashooter(float x_co, float y_co, PImage imgx) {
    super(imgx, 100, 5, x_co, y_co, imgx.width * 2/10, imgx.height * 2/10, 200);
    type = 1;
  }

  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  int getType() {
    return type;
  }
}

class CherryBomb extends Plant {
  int time; 
  void attack() {
    if (millis() > placed + 1200 ) {
      for (Zombie zzz : zombies) {
        if ((zzz.row == this.row || zzz.row + 1 == this.row || zzz.row -1 == this.row) &&
          zzz.x > this.x - w * 3 / 2 - 20 && zzz.x < this.x + w * 3 / 2 ) {
          tint(255, 0, 0);
          zzz.hp = 0;
          zzz.display();
          noTint();
        }
      }
      this.health = 0;
    }
  }

  CherryBomb() {
    //super(imgx, 150, 5, x_co, y_co);
  }

  CherryBomb(float x_co, float y_co, PImage imgx) {
    super(imgx, 150, 5, x_co, y_co, imgx.width * 2/10, imgx.height * 2/10, 200);
  }

  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }
}

class WallNut extends Plant {
  WallNut() { 
    //super(imgx, 100, 5, x_co, y_co);
  }

  WallNut(float x_co, float y_co, PImage imgx) {
    super(imgx, 100, 5, x_co, y_co, imgx.width * 1/10, imgx.height * 1/10, 200);
  }

  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  void attack() {
  }
}

class Squash extends Plant {
  boolean not_found = true;
  Squash(float x_co, float y_co, PImage imgx) {
    super(imgx, 150, 5, x_co, y_co, imgx.width * 1/10, imgx.height * 1/10, 200);
  }
  Squash() {
    // super(imgx, 150, 5, x_co, y_co);
  }

  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  void attack() {
    while (not_found){
      for (Zombie zzz : zombies){
        if (this.row == zzz.row && not_found){
          zzz.hp = 0; 
          zzz.display();
          not_found = false;
        }
      }
    }
    this.health = 0;
  }
}

class SnowPea extends Plant {
  int speed; 
  void attack() {
  }
  SnowPea() {
    //super
  }

  SnowPea(float x_co, float y_co, PImage imgx) {
    super(imgx, 150, 5, x_co, y_co, imgx.width * 3/20, imgx.height * 3/20, 200);
    type = 2;
  }

  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  int getType() {
    return type;
  }
}
