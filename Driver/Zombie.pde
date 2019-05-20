abstract class Zombie implements Displayable, Moveable {
  PImage img;
  int hp, dmg;
  float atk_speed, move_speed, x, y;

  Zombie() {
  }

  Zombie(PImage img1, int hhp, int ddmg, float atk, float move, float xx, float yy) {
    img = img1;
    hp = hhp;
    dmg = ddmg;
    atk_speed = atk;
    move_speed = move;
    x = xx;
    y = yy;
  }
}

class BasicZombie extends Zombie {
  BasicZombie(int xx, int yy, PImage img1) {
    super(img1, 200, 100, 1.5, 20, xx, yy);
  }

  void move() {
    this.x = this.x - 0.5;
  }

  void display() {
    image(this.img, this.x, this.y, this.img.width * 3/50, this.img.height * 3/50);
  }
}

class ConeheadZombie extends Zombie {
  ConeheadZombie (int xx, int yy, PImage img1) {
    super(img1, 560, 100, 1.5, 20, xx, yy);
  }

  void move() {
    this.x = this.x - 0.5;
  }

  void display() {
    image(this.img, this.x, this.y, this.img.width * 3/5, this.img.height * 3/5);
  }
}
