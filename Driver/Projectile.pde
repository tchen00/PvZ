class Projectile{
  // PImage img = loadImage("projectile.png"); 
  float x, y; 
  int damage; 
  
  Projectile(){
    
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
  
  void display(){
   // image(this.img, x, y, this.img.width * 1/10, this.img.height * 1/10);
  }
  
}
