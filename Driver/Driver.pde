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
}

void draw() {
}
