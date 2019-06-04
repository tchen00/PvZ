abstract class Plant {
  PImage img; 
  Zombie target;
  int price, cooldown, row, col, health, type, time; 
  float x, y, x_co, y_co, ph, pw; 
  boolean is_planted = false; 
  int projectileT; 
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

  /*
  if there is a zombie in the same row as the plant and the zombie has not passed the plant, set the plant's target to the closest zombie in front of it
   */
  void setTarget() {
    for (Zombie z : zombies) {
      if (z.row == this.row && this.x < z.x && z.x < (ori_x + 9 * w)) {
        if (this.target == null || z.x < this.target.x) {
          this.target = z;
        }
      }
    }
  }

  /*
  if the plant has a target, shoot a projectile every 3 seconds (every 1 second in demo)
   note: this helper method only for Peashooter and SnowPea
   */
  void addProjectile() {
    if (this.target != null) {
      if (!zombies.contains(this.target)) {
        this.target = null;
      } else {
        if (this.firstS()) {
          if (this instanceof Peashooter) {
            projectiles.add(new greenProjectile(this.getX(), this.getY(), this.row, this.target));
          } else if (this instanceof SnowPea) {
            projectiles.add(new blueProjectile(this.getX(), this.getY(), this.row, this.target));
          }
          proj++;
          this.startTime(); 
          this.firstSetter();
        } else if (millis() >=  3000 - 2000 * demo + this.checkTime() ) {
          if (this instanceof Peashooter) {
            projectiles.add(new greenProjectile(this.getX(), this.getY(), this.row, this.target));
          } else if (this instanceof SnowPea) {
            projectiles.add(new blueProjectile(this.getX(), this.getY(), this.row, this.target));
          }
          this.resetProjectile();
        }
      }
    }
  }

  /*
  return plant's row
   */
  int getRow() {
    return row;
  }

  /*
  return plant's x coordinate
   */
  float getX() {
    return x;
  }

  /*
  return plant's y coordinate
   */
  float getY() {
    return y;
  }

  /*
  return plant's type
   */
  int getType() {
    return type;
  }

  /*
  sets the start time of the projectile
   */
  void startTime() {
    projectileT = millis(); 
    //print("time started");
  }

  /*
  returns the current time of projectile
   */
  int checkTime() {
    return projectileT;
  }

  /*
  checks if the plant has shot its first shot
   */
  boolean firstS() {
    return firstShot;
  }

  /*
  set firstShot to false (after plant shot once already)
   */
  void firstSetter() {
    firstShot = false;
  }

  /*
  reset projectile's time
   */
  void resetProjectile() {
    projectileT = millis();
  }

  abstract void attack();
}

class Sunflower extends Plant {
  int speed, cost;
  Sun product;
  //PImage img; 

  Sunflower(float x_co, float y_co, PImage imgx) {
    super(imgx, 50, 5, x_co, y_co, imgx.width * 1/10, imgx.height * 1/10, 200);
    type = 3;
  }

  /*
  produces a sun every 7 seconds (every 2 seconds in demo)
   */
  void attack() {
    if (this.time == 0) {
      this.time = millis();
    }
    if (this.product == null) {
      if (millis() > this.time + 7000 - 5000 * demo) {
        this.product = new Sun(this.x, this.y);
        suns.add(this.product);
      }
    } else {
      if (!suns.contains(this.product)) {
        this.product = null;
        this.time = millis();
      }
    }
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

  /*
   displays Sunflower
   */
  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }
}

class Peashooter extends Plant {
  int speed; 

  Peashooter() {
    //super(imgx, 100, 5, x_co, y_co);
  }

  Peashooter(float x_co, float y_co, PImage imgx) {
    super(imgx, 100, 5, x_co, y_co, imgx.width * 2/10, imgx.height * 2/10, 200);
    type = 1;
  }

  /*
   find target and shoot projectile if the Peashooter has a target
   */
  void attack() {
    this.setTarget();
    this.addProjectile();
  }

  /*
   display Peashooter
   */
  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  /*
   return type (type 1 for Peashooter)
   */
  int getType() {
    return type;
  }
}

class CherryBomb extends Plant {

  CherryBomb() {
    //super(imgx, 150, 5, x_co, y_co);
  }

  CherryBomb(float x_co, float y_co, PImage imgx) {
    super(imgx, 150, 5, x_co, y_co, imgx.width * 2/10, imgx.height * 2/10, 200);
  }

  /*
  explodes 1.2 seconds after it is placed, kills all zombies within a radius of 1 grid space
   note: does not hurt zombies not yet on the grid
   */
  void attack() {
    if (millis() > this.time + 1200) {
      for (Zombie zzz : zombies) {
        if ((zzz.row == this.row || zzz.row + 1 == this.row || zzz.row -1 == this.row) &&
          zzz.x > this.x - w * 3 / 2 - 20 && zzz.x < this.x + w * 3 / 2 && zzz.x < ori_x + 9 * w) {
          zzz.hp = 0;
          zzz.display();
        }
      }
      this.health = 0;
    }
  }

  /*
  display Cherry Bomb
   */
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

  /*
  display Wallnut
   */
  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  /*
  wallnut cannot attack so it's attack method is empty
   */
  void attack() {
  }
}

class Squash extends Plant {
  boolean jumped;
  Squash(float x_co, float y_co, PImage imgx) {
    super(imgx, 150, 5, x_co, y_co, imgx.width * 1/10, imgx.height * 1/10, 200);
  }
  Squash() {
    // super(imgx, 150, 5, x_co, y_co);
  }

  /*
  display Squash
   shows crushing/jumping motion when it has a target
   */
  void display() { 
    if (this.target != null) {
      this.x = this.target.x;
      if (!jumped) {
        this.y = this.y - 140;
        this.jumped = true;
      } else {
        this.y = this.y + 6;
      }
    }
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  /*
  finds a target in front of it and sits on it, crushing it.
   both the squash and target dies
   */
  void attack() {
    for (Zombie zzz : zombies) {
      if (this.row == zzz.row  && zzz.x > this.x - w && zzz.x < this.x + w) {
        if (this.target == null || zzz.x < this.target.x) {
          this.target = zzz;
          this.time = millis();
        }
      }
    }
    if (this.target != null && millis() > this.time + 500) {
      this.target.hp = 0; 
      this.health = 0;
    }
  }
}

class SnowPea extends Plant {
  int speed; 

  SnowPea() {
    //super
  }

  SnowPea(float x_co, float y_co, PImage imgx) {
    super(imgx, 150, 5, x_co, y_co, imgx.width * 3/20, imgx.height * 3/20, 200);
    type = 2;
  }

  /*
  finds target and shoots peas
   */
  void attack() {
    this.setTarget();
    this.addProjectile();
  }

  /*
  display SnowPea
   */
  void display() { 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }

  /*
  return type (2 for SnowPea)
   */
  int getType() {
    return type;
  }
}
