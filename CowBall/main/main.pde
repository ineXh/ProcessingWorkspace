import apwidgets.*;

APMediaPlayer mooo;
APMediaPlayer short_moo;
APMediaPlayer hipponoise;

PFont Msgfont;
PFont Stagefont;
Ground ground_B;
Ground ground_R;
Ground ground_T;
Ground ground_L;
Orb orb;//, orb2, orb3;
MainCharacter cow;
Enemy hippo;
int GameStage = 4;// -1 = gameover
int GameState = 0; // 0 = pause for input; 1 = In Play
int Winner = 0;    // 1 = player, 2 = computer

Button quitbutton;
Button playbutton;

//Minim minim;
//AudioPlayer player;
//AudioInput input;

boolean first_move = true;

PVector gravity = new PVector(0,0);



void setup(){
  Msgfont = loadFont("Andy-Bold-64.vlw");
  Stagefont = loadFont("Andy-Bold-14.vlw");
/*  mooo = new APMediaPlayer(this); //create new APMediaPlayer
  mooo.setMediaFile("mooo2.wav"); //set the file (files are in data folder)
  
  short_moo = new APMediaPlayer(this); //create new APMediaPlayer
  short_moo.setMediaFile("short_moo.wav"); //set the file (files are in data folder)
  
  hipponoise = new APMediaPlayer(this); //create new APMediaPlayer
  hipponoise.setMediaFile("hippo.wav"); //set the file (files are in data folder)
  */
  orientation(PORTRAIT);
  size(480, 720);
  
  ground_B = new Ground((int)random(8,15),    // Segment
                         0,    // Type Ground
                         5,    // Pad Height
                        60);
  ground_R = new Ground((int)random(8,15),    // Segment
                         1,    // Type Ground
                         5,    // Pad Height
                        60);
  ground_T = new Ground((int)random(8,15),    // Segment
                         2,    // Type Ground
                         5,    // Pad Height
                        60); 
  ground_L = new Ground((int)random(8,15),    // Segment
                         3,    // Type Ground
                         5,    // Pad Height
                        60);                          
                        
// An orb object that will fall and bounce around
  orb = new Orb(width/2, height/4, 10);
  
  cow = new MainCharacter("cow_35.png", width/2, height/2, "cow_35b.png");
  hippo = new Enemy("hippo.png", width*3/4, height*3/4);
  background(0, 0, 0);
  //player = maxim.loadFile("mooo2.wav");
  //
  
  playbutton = new Button("playbutton.jpg", width/2, height*20/100);  
  quitbutton = new Button("quitbutton.jpg", width/2, height*80/100);
  
  
}
void mousePressed(){
  if(GameState == 0){ 
     if(playbutton.update()){
       GameState = 1;
       GameStage = 1;
       cow.HP = Cow_HP;
       hippo.HP = HPMax_Start;
       HPMax = HPMax_Start;
       hippo.damping = Damping_Start;
     }
     if(quitbutton.update()) exit();   
  }
}
void mouseDragged()
{
  cow.accelerate();
}
void draw(){
  draw_stage(GameStage);  
}

void Update(){
  int s = second();  // Values from 0 - 59
  if(first_move){
    if(s % 10 > 1){
      return;
    }else{ first_move = false;}
  } 
  if(s % 10 == 1){
    ground_B.Translate(0,-0.5);
    ground_R.Translate(-0.5,0);
    ground_T.Translate(0,0.5);
    ground_L.Translate(0.5,0);
  }else if(s % 10 == 3){
    ground_B.Translate(0.5,0);
    ground_R.Translate(0,-0.5);
    ground_T.Translate(-0.5,0);
    ground_L.Translate(0,0.5);
  }else if(s % 10 == 6){
    ground_B.Translate(0,0.5);
    ground_R.Translate(0.5,0);
    ground_T.Translate(0,-0.5);
    ground_L.Translate(-0.5,0);
  }else if(s % 10 == 8){
    ground_B.Translate(-0.5, 0);
    ground_R.Translate(0,0.5);
    ground_T.Translate(0.5,0);
    ground_L.Translate(0,-0.5);
  }
}


