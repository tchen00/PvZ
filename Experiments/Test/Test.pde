
float bx;
float by;
int bs = 100;
boolean bover = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 
PImage img;


void setup() 
{
  size(1000, 1000);
  bx = width/2.0;
  by = height/2.0;
img = loadImage("peashooter.png");
  image(img, bx, by, img.width/3, img.height/3);
}

void draw() 
{ 
  background(0);
  // Test if the cursor is over the box 
  if (mouseX > bx && mouseX < bx+img.width && 
    mouseY > by && mouseY < by+img.height) {
    bover = true;  
    if (!locked) { 

      stroke(255); 

      fill(153);
    }
  } else {
    stroke(153);
    fill(153);
    bover = false;
  }


  PImage img = loadImage("peashooter.png");
  // Draw the box
  image(img, bx, by); 
  //rect(bx, by, bs, bs);
}



void mousePressed() {

  if (bover) { 

    locked = true;
    fill(255, 255, 255);
  } else {

    locked = false;
  }

  bdifx = mouseX-bx; 

  bdify = mouseY-by;
}



void mouseDragged() {

  if (locked) {
    bx = mouseX-bdifx; 
    by = mouseY-bdify;
  }
}



void mouseReleased() {
  locked = false;
}