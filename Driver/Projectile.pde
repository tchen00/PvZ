abstract class Projectile {
  // PImage img = loadImage("projectile.png"); 
  Zombie target;
  float x, y; 
  int damage, row, type;  
  Projectile(float x, float y, int row, Zombie target) {
    this.x = x; 
    this.y = y; 
    damage = 50;
    this.row = row;
    this.target = target;
  }

  /*
  return projectile's x coordinate
   */
  float getX() {
    return x;
  }

  /*
  return projectile's y coordinate
   */
  float getY() {
    return y;
  }

  /*
  set projectile's x coordinate to given parameter
   */
  void setX(int x) {
    this.x += x;
  }

  abstract void display(); 
  abstract void move();
}

class greenProjectile extends Projectile {
  // add in the image later -- for now use ellipse/circle 
  PImage img; 
  //float x, y; 

  greenProjectile(float x, float y, int row, Zombie target) {
    super(x, y, row, target);
    type = 1;
  }

  /*
  displays green pea
   */
  void display() {
    fill(68, 224, 29);
    ellipse(this.x, this.y, 25, 25);
  }

  /*
  have green pea move
   */
  void move() {
    //print("before" + x); 
    this.x = this.x + 5;
    //print("after" + x);
  }
}

class blueProjectile extends Projectile {
  blueProjectile(float x, float y, int row, Zombie target) {
    super(x, y, row, target);
    type = 2;
  }

  /*
  display blue pea
   */
  void display() {
    fill(36, 225, 242); 
    ellipse(this.x, this.y, 25, 25);
  }

  /*
  have blue pea move
   */
  void move() {
    this.x += 10;
  }
}
