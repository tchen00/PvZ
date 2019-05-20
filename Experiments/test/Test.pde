int savedTime;
int totalTime = 5000;

void setup() {
  size(200, 200);
  background(0);
  savedTime = millis();
}

void draw() {
  if (mousePressed == true) {
    fill(0);
  } else {
    fill(255);
  }
  rect(25, 25, 50, 50);
}
