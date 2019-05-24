abstract class Projectile{
  // PImage img = loadImage("projectile.png"); 
  float x, y; 
  int damage; 
  
  Projectile(float x, float y, int damage){
    this.x = x; 
    this.y = y; 
    this.damage = damage; 
  }
  
  
  float getX(){
    return x; 
  }
  
  float getY(){
    return y;  
  }
  
  int getDamage(){ 
    return damage; 
  }
  
  abstract void display(); 
  abstract void move();  
}

class greenProjectile extends Projectile{
  PImage img; 
  
  greenProjectile(float x, float y, int damage){
   super(x, y, damage); 
  }
  
  void display(){
<<<<<<< HEAD
    fill(68, 224, 29);
=======
    fill(40, 155, 85);
>>>>>>> master
    ellipse(x, y, 25, 25);  
  }
  
  void move(){
    x += 1;
  }
}
