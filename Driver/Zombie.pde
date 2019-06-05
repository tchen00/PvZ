abstract class Zombie {
  PImage img;
  Plant target;
  int hp, dmg, row;
  float x, y, t, speed = 1; 
  boolean hurt, displayed;

  Zombie() {
  }

  Zombie(PImage img1, int hhp, int ddmg, float xx, float yy, int rows) {
    img = img1;
    hp = hhp;
    dmg = ddmg;
    x = xx;
    y = yy;
    row = rows;
    hurt = false;
  }

  abstract void display();

  /*
  if zombie does not have a target (meaning it is not attacking a plant) and if its target is not cherry bomb, 
   zombie moves one pixel every time the method is called (its moving speed increases by 50% in demo)
   */
  void move() {
    if (this.target == null || this.target instanceof CherryBomb) {
      this.x = this.x - speed - 0.5 * demo;
    }
  }

  /*
  if zombie has a target, decrease the target's health by 40 every time the method is called
   if its target is dead, set its target to null
  target flashes red when hit
   */
  void attack() {
    if (this.target != null) {
      if (plants.contains(this.target)) {
        if (millis() > this.t + 2000) {
          if (!(this.target instanceof CherryBomb) && !(this.target instanceof Squash)) {
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

  /*
  return x coordinate of zombie
   */
  float getX() {
    return x;
  }

  /*
  return y coordinate of zombie
   */
  float getY() {
    return y;
  }

  /*
  return zombie's hp
   */
  int getHP() {
    return hp;
  }
}

class BasicZombie extends Zombie {
  BasicZombie(int xx, int row, PImage img1) {
    super(img1, 200, 100, xx, row * 118 + 100, row);
  }

  /*
  displays the whole basic zombie if its hp is greater than 100, 
    else, display headless zombie
  if it is being attacked, zombie flashes red
   */
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
    super(img1, 560, 100, xx, row * 118 + 78, row);
  }

  /*
  display conehead zombie if its hp is greater than 200,
    else display basic zombie if its hp is greater than 100, 
    else display headless zombie
  if zombie is being attacked, it flashes red
   */
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
