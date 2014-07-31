Ground ground_B;
Ground ground_R;
Ground ground_T;
Ground ground_L;
Orb orb;
Character cow;

boolean first_move = true;

PVector gravity = new PVector(0,0);

void setup(){
  size(720, 480);
  
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
  orb = new Orb(width/2, height/2, 25);
  
  cow = new Character("cow_25.png", width/2, height/2);
  background(0);
  
}
void mouseDragged()
{
  cow.accelerate();
}
void draw(){
  // Background
  //noStroke();
  fill(10, 20, 30, 40 + second()*2);
  rect(0, 0, width, height);
  
    // Move and display the orb
  orb.move();
  orb.Draw();
  // Check walls
  orb.checkWallCollision();

  // Check against all the ground segments
 orb.checkGround(ground_B);
 orb.checkGround(ground_R);
 orb.checkGround(ground_T);
 orb.checkGround(ground_L);
 orb.checkCharacterCollision(cow);
 
  Update();
  fill(0, 200, 0, 1);
  ground_B.Draw();
  ground_R.Draw();
  ground_T.Draw();
  ground_L.Draw();
  // Cow
  
  cow.Draw();
  cow.move();
  //cow.checkWallCollision();
  cow.checkGround(ground_B);
  cow.checkGround(ground_R);
  cow.checkGround(ground_T);
  cow.checkGround(ground_L);
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
