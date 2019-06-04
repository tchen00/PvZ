abstract class Plant {
  PImage img; 
  Zombie target;
  int price, cooldown, row, col, health, type, time; 
  float x, y, ph, pw; 
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
  void getDamage() {
    health -= 5;
  }

  void setTarget() {
    for (Zombie z : zombies) {
      if (z.row == this.row && this.x < z.x && z.x < (ori_x + 9 * w)) {
        if (this.target == null || z.x < this.target.x) {
          this.target = z;
        }
      }
    }
  }

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
  int speed, cost;
  Sun product;
  //PImage img; 
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
      if (!suns.contains(this.product)){
        this.product = null;
        this.time = millis();
      }
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

  Peashooter() {
    //super(imgx, 100, 5, x_co, y_co);
  }

  Peashooter(float x_co, float y_co, PImage imgx) {
    super(imgx, 100, 5, x_co, y_co, imgx.width * 2/10, imgx.height * 2/10, 200);
    type = 1;
  }

  void attack() {
    this.setTarget();
    this.addProjectile();
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
  void attack() {
    if (millis() > this.time + 1200) {
      for (Zombie zzz : zombies) {
        if ((zzz.row == this.row || zzz.row + 1 == this.row || zzz.row -1 == this.row) &&
          zzz.x > this.x - w * 3 / 2 - 20 && zzz.x < this.x + w * 3 / 2 && zzz.x < ori_x + 9 * w) {
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
    for (Zombie zzz : zombies) {
      if (this.row == zzz.row  && zzz.x > ori_x + this.col * w && zzz.x < ori_x + 9 * w) {
        if (this.target == null || zzz.x < this.target.x) {
          this.target = zzz;
        }
      }
    }
    if (this.target != null) {
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

  void attack() {
    this.setTarget();
    this.addProjectile();
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
