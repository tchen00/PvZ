abstract class Zombie {
  PImage img;
  Plant target;
  int hp, dmg, row;
  float x, y, t, atk_speed, speed = 1; 
  boolean hurt, displayed;

  Zombie() {
  }

  Zombie(PImage img1, int hhp, int ddmg, float atk, float xx, float yy, int rows) {
    img = img1;
    hp = hhp;
    dmg = ddmg;
    atk_speed = atk;
    x = xx;
    y = yy;
    row = rows;
    hurt = false;
  }

  abstract void display();
  void move() {
    if (this.target == null || this.target instanceof CherryBomb) {
      this.x = this.x - speed;
    }
  }

  void attack() {
    if (this.target != null) {
      if (plants.contains(this.target)) {
        if (millis() > this.t + 2000) {
          if (!(this.target instanceof CherryBomb) && !(this.target instanceof Squash)){
            tint(255, 0, 0);
          }
          this.target.health = this.target.health - 40;
          this.target.display();
          noTint();
          this.t = millis();
        }
      } else {
        this.target = null;
      }
    }
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  int getHP() {
    return hp;
  }
}

class BasicZombie extends Zombie {
  BasicZombie(int xx, int row, PImage img1) {
    super(img1, 200, 100, 20, xx, row * 118 + 100, row);
  }



  void display() {
    if (this.hp <= 100) {
      this.img = headless;
    }
    if (this.hurt && !this.displayed) {
      tint(255, 0, 0);
    }
    image(this.img, this.x, this.y, 99, 118);
    this.displayed = true;
    noTint();
  }
}

class ConeheadZombie extends Zombie {
  ConeheadZombie (int xx, int row, PImage img1) {
    super(img1, 560, 100, 20, xx, row * 118 + 78, row);
  }

  void display() {
    if (this.hurt && !this.displayed) {
      tint(255, 0, 0);
    }
    if (this.hp <= 200) {
      if (this.hp <= 100) {
        this.img = headless;
      } else {
        this.img = zombie1;
      }
      image(this.img, this.x, this.y + 25, 97, 115);
    } else {
      image(this.img, this.x, this.y, 99, 140);
    }
    this.displayed = true;
    noTint();
  }
}
