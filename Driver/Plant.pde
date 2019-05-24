abstract class Plant{
  PImage img; 
  int price, cooldown, row, col; 
  float x, y, x_co, y_co, ph, pw; 
  boolean is_planted = false; 
  boolean hover = false; 
  
  // basic constructor 
  Plant(){
  }
  
  Plant(PImage img1, int price1, int cooldown1, float x_cor, float y_cor, float pwA, float phA){
    img = img1; 
    price = price1; 
    cooldown = cooldown1;
    /*
    while (mousePressed){
      
    }
    */ 
    x = x_cor; 
    y = y_cor; 
    row = -1;
    col = -1;
    ph = phA;
    pw = pwA;
    //is_planted = true; 
  }
  
  void display(){
    
  }
  
  void setLocation(){
    
  }
   
}

class Sunflower extends Plant{
  int speed, time, cost;
  //PImage img; 
  void produce(){
    
  }
  
  Sunflower(float x_co, float y_co, PImage imgx){
    super(imgx, 50, 5, x_co, y_co, imgx.width * 1/10, imgx.height * 1/10); 
  }
  /*
  Sunflower(){
    PImage imgx = loadImage("sunflower.png"); 
    img = imgx; 
    speed = 3; 
    time = 0; 
    cost = 50; 
  }
  */
  void display(){ 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }
  
}

class Peashooter extends Plant{
  int speed; 
  void attack(){
  }
  Peashooter(){
    //super(imgx, 100, 5, x_co, y_co);
  }
  
  Peashooter(float x_co, float y_co, PImage imgx){
    super(imgx, 100, 5, x_co, y_co, imgx.width * 2/10, imgx.height * 2/10); 
  }
  
  void display(){ 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }
}

class CherryBomb extends Plant{
  int time; 
  void attack(){
  }
  
  CherryBomb(){
    //super(imgx, 150, 5, x_co, y_co); 
  }
  
  CherryBomb(float x_co, float y_co, PImage imgx){
    super(imgx, 150, 5, x_co, y_co, imgx.width * 2/10, imgx.height * 2/10); 
  }
  
  void display(){ 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  }
  
  
}

class WallNut extends Plant{
  WallNut(){ 
    //super(imgx, 100, 5, x_co, y_co); 
  }
  
  WallNut(float x_co, float y_co, PImage imgx){
    super(imgx, 100, 5, x_co, y_co,imgx.width * 1/10, imgx.height * 1/10); 
  }

  void display(){ 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  } 
  
}

class Squash extends Plant{
  Squash(float x_co, float y_co, PImage imgx){
    super(imgx, 150, 5, x_co, y_co, imgx.width * 1/10, imgx.height * 1/10); 
  }
  Squash(){
   // super(imgx, 150, 5, x_co, y_co); 
  }
  
  void display(){ 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  } 
  
}

class SnowPea extends Plant{
  int speed; 
  void attack(){
  }
  SnowPea(){
   //super 
  }
  
  SnowPea(float x_co, float y_co, PImage imgx){
    super(imgx, 150, 5, x_co, y_co, imgx.width * 3/20, imgx.height * 3/20); 
  }
  
  void display(){ 
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.pw, this.ph);
    imageMode(CORNER);
  } 
}
