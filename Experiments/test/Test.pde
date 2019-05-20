class Test{
var time;
var wait = 1000;

var tick = false;

function setup(){
  time = millis();//store the current time
  smooth();
  strokeWeight(3);
}
function draw(){
  //check the difference between now and the previously stored time is greater than the wait interval
  if(millis() - time >= wait){
    tick = !tick;//if it is, do something
    time = millis();//also update the stored time
  }
  //draw a visual cue
  background(255);
  line(50,10,tick ? 10 : 90,90);
}
}
