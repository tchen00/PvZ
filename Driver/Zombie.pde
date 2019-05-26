abstract class Zombie {
  PImage img;
  int hp, dmg, row;
  float x, y;
  float atk_speed;
  boolean attacking;

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
  abstract void move();
  abstract void attack(Plant pla);
}

class BasicZombie extends Zombie {
  BasicZombie(int xx, int row, PImage img1) {
    super(img1, 200, 100, 20, xx, row * 118 + 100, row);
  }

  void move() {
    if (!this.attacking) {
      this.x = this.x - 0.3;
    }
  }

  void display() {
    image(this.img, this.x, this.y, 99, 118);
  }

  void attack(Plant pla) {
    if (plants.contains(pla)) {
      this.attacking = true;
    }
  }
}

class ConeheadZombie extends Zombie {
  ConeheadZombie (int xx, int row, PImage img1) {
    super(img1, 560, 100, 20, xx, row * 118 + 78, row);
  }

  void move() {
    if (!this.attacking) {
      this.x = this.x - 0.3;
    }
  }

  void display() {
    image(this.img, this.x, this.y, 99, 140);
  }

  void attack(Plant pla) {
    if (plants.contains(pla)) {
      this.attacking = true;
      println(true);
      pla.health = pla.health -  100;
    }
  }
}
