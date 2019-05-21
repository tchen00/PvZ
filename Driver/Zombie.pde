abstract class Zombie {
  PImage img;
  int hp, dmg;
  float atk_speed, x, y;
  boolean attacking;

  Zombie() {
  }

  Zombie(PImage img1, int hhp, int ddmg, float atk, float xx, float yy) {
    img = img1;
    hp = hhp;
    dmg = ddmg;
    atk_speed = atk;
    x = xx;
    y = yy;
  }
  
  abstract void display();
  abstract void move();
  
  void attack(Plant smth){
    for (Plant pla: plants){
    }
  }
}

class BasicZombie extends Zombie {
  BasicZombie(int xx, int yy, PImage img1) {
    super(img1, 200, 100, 20, xx, yy);
  }

  void move() {
    this.x = this.x - 0.3;
  }

  void display() {
    image(this.img, this.x, this.y, 99, 118);
  }
}

class ConeheadZombie extends Zombie {
  ConeheadZombie (int xx, int yy, PImage img1) {
    super(img1, 560, 100, 20, xx, yy);
  }

  void move() {
    this.x = this.x - 0.3;
  }

  void display() {
    image(this.img, this.x, this.y, 99, 140);
  }
}
