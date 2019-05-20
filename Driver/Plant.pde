abstract class Plant{
  PImage img; 
  int price, cooldown; 
  float x, y; 
  // basic constructor 
  Plant(){
    
  }
  
  Plant(PImage img1, int price1, int cooldown1, float x_cor, float y_cor){
    PImage img = img1; 
    int price = price1; 
    int cooldown = cooldown1; 
    float x = x_cor; 
    float y = y_cor; 
  }
}

class Sunflower extends Plant{
}

class Peashooter extends Plant{
}

class CherryBomb extends Plant{
}

class WallNut extends Plant{
}

class Squash extends Plant{
}

class SnowPea extends Plant{
}
