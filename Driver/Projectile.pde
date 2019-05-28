abstract class Projectile {
  // PImage img = loadImage("projectile.png"); 
  float x, y; 
  int damage; 

  Projectile(float x, float y, int damage) {
    this.x = x; 
    this.y = y; 
    this.damage = damage;
  }


  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  int getDamage() { 
    return damage;
  }

  abstract void display(); 
  abstract void move();
}

class greenProjectile extends Projectile {
  // add in the image later -- for now use ellipse/circle 
  PImage img; 
  //float x, y; 
  
  greenProjectile(float x, float y, int damage) {
    super(x, y, damage);
  }

  void display() {
    fill(68, 224, 29);
    ellipse(x, y, 25, 25);
  }

  void move() {
    //print("before" + x); 
    this.x = this.x + 5;
    //print("after" + x); 
  }
  
  float getX(){
    return x; 
  }
  
  void setX(int i){
    x += i;
  }
}

class blueProjectile extends Projectile {
  blueProjectile(float x, float y, int damage) {
    super(x, y, damage);
  }

  void display() {
    fill(36, 225, 242); 
    ellipse(x, y, 25, 25);
  }

  void move() {
    x += 10;
  }
  
}
