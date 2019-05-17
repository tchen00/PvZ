import java.util.*;

PImage start, lawn;
ArrayList<Plant> plants;
ArrayList<Zombie> zombies;
Queue<Plant> nextPlants;

void setup() {
  size(1280, 720);
  start = loadImage("start_screen.png");
  lawn = loadImage("lawn.png");
  image(start, 0, 0, width, height);
}

void mouseClicked() {
  image(lawn, 0, 0, width, height);
  pushMatrix();
  fill(255, 240, 179);
  translate(50, 200);
  rect(0, 0, 150, 200);
  popMatrix();
}

void draw() {
}
