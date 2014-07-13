
Maxim maxim;
AudioPlayer player;

void setup(){
  maxim = new Maxim(this);
  player = maxim.loadFile("ping.wav");
    background(255, 0, 0);
    player.setLooping(false);
}

void draw(){
  //background(0);

  //rect(mouseX, mouseY, 100, 100);
  strokeWeight(6);
  line(pmouseX, pmouseY, mouseX, mouseY);
}

void mousePressed(){
    player.cue(0);
player.play();
}
