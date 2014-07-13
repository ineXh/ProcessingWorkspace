//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies


Maxim maxim;
AudioPlayer player, pingsound;

void setup()
{
  size(640, 960);
  
   background(255, 0, 0);
  maxim = new Maxim(this);
  player = maxim.loadFile("mykbeat.wav");
  pingsound = maxim.loadFile("ping.wav");
  player.setLooping(false);
 
}

void draw(){
  //background(0);

  //rect(mouseX, mouseY, 100, 100);
  strokeWeight(6);
  line(pmouseX, pmouseY, mouseX, mouseY);
}

void mouseDragged()
{
// code that happens when the mouse moves
// with the button down
}

void mousePressed()
{

// code that happens when the mouse button
// is pressed
  player.cue(0);
  player.play();
  pingsound.cue(0);
  pingsound.play();
}

void mouseReleased()
{
// code that happens when the mouse button
// is released
pingsound.cue(1);
}

