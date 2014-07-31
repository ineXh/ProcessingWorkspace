void setup(){
    background(255, 0, 0);
}

void draw(){
  //background(0);

  //rect(mouseX, mouseY, 100, 100);
  strokeWeight(6);
  line(pmouseX, pmouseY, mouseX, mouseY);
}
