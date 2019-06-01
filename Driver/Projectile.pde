abstract class Projectile {
  // PImage img = loadImage("projectile.png"); 
  float x, y; 
  int damage; 
  int row;

  Projectile(float x, float y, int damage, int row) {
    this.x = x; 
    this.y = y; 
    this.damage = damage;
    this.row = row;
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

  void setX(int x){
    this.x += x; 
  }
  
  abstract void display(); 
  abstract void move();
}

class greenProjectile extends Projectile {
  // add in the image later -- for now use ellipse/circle 
  PImage img; 
  //float x, y; 
  
  greenProjectile(float x, float y, int damage, int row) {
    super(x, y, damage, row);
  }

  void display() {
    fill(68, 224, 29);
    ellipse(this.x, this.y, 25, 25);
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
    this.x += i;
  }
}

class blueProjectile extends Projectile {
  blueProjectile(float x, float y, int damage, int row) {
    super(x, y, damage, row);
  }

  void display() {
    fill(36, 225, 242); 
    ellipse(this.x, this.y, 25, 25);
  }

  void move() {
    this.x += 10;
  }
  
  
}
