abstract class Zombie {
  PImage img;
  Plant target;
  int hp, dmg, row;
  float x, y, t;
  float atk_speed;

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
  }

  abstract void display();
  void move() {
    if (this.target == null || this.target instanceof CherryBomb) {
      this.x = this.x - 1;
    }
  }

  void attack() {
    if (this.target != null) {
      if (plants.contains(this.target)) {
        if (millis() > this.t + 2000) {
          this.target.health = this.target.health - 40;
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
    image(this.img, this.x, this.y, 99, 118);
  }
}

class ConeheadZombie extends Zombie {
  ConeheadZombie (int xx, int row, PImage img1) {
    super(img1, 560, 100, 20, xx, row * 118 + 78, row);
  }

  void display() {
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
  }
}
