abstract class Plant{
  PImage img; 
  int price, cooldown; 
  float x, y; 
  boolean is_planted; 
  // basic constructor 
  Plant(){
    
  }
  
  Plant(PImage img1, int price1, int cooldown1, float x_cor, float y_cor){
    img = img1; 
    price = price1; 
    cooldown = cooldown1; 
    x = x_cor; 
    y = y_cor; 
    is_planted = true; 
  }
  
  void display(){
  }
  
  void setLocation(){
  }
}

class Sunflower extends Plant{
  int speed, time, cost;
  float x, y; 
  //PImage img; 
  void produce(){
  }
  
  Sunflower(float x_co, float y_co, PImage imgx){
    super(imgx, 50, 5, x_co, y_co); 
  }
  
  Sunflower(){
    PImage imgx = loadImage("sunflower.png"); 
    img = imgx; 
    speed = 3; 
    time = 0; 
    cost = 50; 
  }
  void display(){ 
    image(this.img, x, y, this.img.width * 3/50, this.img.height * 3/50);
  }
}

class Peashooter extends Plant{
  int speed; 
  void attack(){
  }
  
}

class CherryBomb extends Plant{
  int time; 
  void attack(){
  }
  
}

class WallNut extends Plant{


}

class Squash extends Plant{


}

class SnowPea extends Plant{
  int speed; 
  void attack(){
  }
}
