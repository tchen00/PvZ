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
  int speed, time; 
  void produce(){
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
