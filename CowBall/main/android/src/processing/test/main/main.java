package processing.test.main;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

Ground ground_B;
Ground ground_R;
Ground ground_T;
Ground ground_L;
Orb orb;
Character cow;
Enemy hippo;
//Maxim maxim;
//AudioPlayer player;

boolean first_move = true;

PVector gravity = new PVector(0,0);

public void setup(){
 
  
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
  
  cow = new Character("cow_35.png", width/2, height/2, "cow_35b.png");
  hippo = new Enemy("hippo.png", width*3/4, height*3/4);
  background(0);
  //player = maxim.loadFile("mooo2.wav");
  //player.volume(0.6);
  
}
public void mouseDragged()
{
  cow.accelerate();
}
public void draw(){
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
 orb.checkCharacterCollision(hippo);
 
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
  
  // Hippo
  hippo.Draw();
  hippo.move();
  hippo.checkGround(ground_B);
  hippo.checkGround(ground_R);
  hippo.checkGround(ground_T);
  hippo.checkGround(ground_L);
  
}

public void Update(){
  int s = second();  // Values from 0 - 59
  if(first_move){
    if(s % 10 > 1){
      return;
    }else{ first_move = false;}
  } 
  if(s % 10 == 1){
    ground_B.Translate(0,-0.5f);
    ground_R.Translate(-0.5f,0);
    ground_T.Translate(0,0.5f);
    ground_L.Translate(0.5f,0);
  }else if(s % 10 == 3){
    ground_B.Translate(0.5f,0);
    ground_R.Translate(0,-0.5f);
    ground_T.Translate(-0.5f,0);
    ground_L.Translate(0,0.5f);
  }else if(s % 10 == 6){
    ground_B.Translate(0,0.5f);
    ground_R.Translate(0.5f,0);
    ground_T.Translate(0,-0.5f);
    ground_L.Translate(-0.5f,0);
  }else if(s % 10 == 8){
    ground_B.Translate(-0.5f, 0);
    ground_R.Translate(0,0.5f);
    ground_T.Translate(0.5f,0);
    ground_L.Translate(0,-0.5f);
  }
}


public class Character{
  PVector position;
  public PVector velocity;
  PVector acceleration;
  int char_width;
  int char_height;
  float r;
  float damping;
  float max_x_accel = 5;
  float max_y_accel = 5;
  public float m;
  
  PImage obj;
   PImage obj_kick; 
   public boolean kicking;
   public int kick_start_time = 0;
  // Constructor
  Character(){
  }
  Character(String File, int x, int y, String File_kick){
    obj = loadImage(File);
    obj_kick = loadImage(File_kick);
    char_width = obj.width;
    char_height = obj.height;
    velocity = new PVector(0,0);//random(3,6), random(3,6));
    position = new PVector(x, y);
    r = max(char_width, char_height)/2;
    m = char_width;
    damping = 0.5f;
  }
  public PVector getPos(){
    return position;
  }
  public PVector getVel(){
    return velocity;
  }
  public int getCharacterWidth()
  {
    return char_width;
  }
  public int getCharacterHeight()
  {
    return char_height;
  }
  public void setVel(PVector vel){
    velocity = vel;
  }
  public void setPos(PVector pos){
    position = pos;
  }
  public void accelerate()
  {
    acceleration = new PVector( map((mouseX - pmouseX), 0, width, 0, max_x_accel),  map((mouseY - pmouseY), 0, height, 0, max_y_accel));
    // Move Character 
    velocity.add(acceleration);
  }
  public void move() {    
    velocity.add(gravity);
    position.add(velocity);
  }
  
  public void Draw(){
    if(millis() - kick_start_time > 750) kicking = false;
    imageMode(CENTER);
    if(kicking){
      image(obj_kick, position.x, position.y);
    }else{
      image(obj, position.x, position.y);
    }
  }
  // Check boundaries of window
  public void checkWallCollision() {
    if (position.x > width-r) {
      position.x = width-r;
      velocity.x *= -damping;
    } 
    else if (position.x < r) {
      position.x = r;
      velocity.x *= -damping;
    }
  }
  public void checkGround(Ground ground){
    int seg = ground.getSegmentNum();
    for (int i=0; i<seg; i++){
      checkGroundCollision(ground.getSegment(i),ground.getGroundType());
    }
  }

  public void checkGroundCollision(Ground_Seg groundSegment, int ground_type) {

    // Get difference between orb and ground
    float deltaX = position.x - groundSegment.x;
    float deltaY = position.y - groundSegment.y;

    // Precalculate trig values
    float cosine = cos(groundSegment.rot);
    float sine = sin(groundSegment.rot);

    /* Rotate ground and velocity to allow 
     orthogonal collision calculations */
    float groundXTemp = cosine * deltaX + sine * deltaY;
    float groundYTemp = cosine * deltaY - sine * deltaX;
    float velocityXTemp = cosine * velocity.x + sine * velocity.y;
    float velocityYTemp = cosine * velocity.y - sine * velocity.x;

    /* Ground collision - check for surface 
     collision and also that orb is within 
     left/rights bounds of ground segment */
     if(ground_type == 0){
      if (groundYTemp > -char_height/2 &&//-r &&
        position.x > groundSegment.x1 &&
        position.x < groundSegment.x2 ) {
        // keep orb from going into ground
        groundYTemp = -char_height/2;//-r;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }
     if(ground_type == 1){
      if (groundYTemp < char_width/2 &&
        position.y > groundSegment.y1 &&
        position.y < groundSegment.y2 ) {
        // keep orb from going into ground
        groundYTemp = char_width/2;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }
     if(ground_type == 2){
      if (groundYTemp < char_height/2 &&
        position.x > groundSegment.x1 &&
        position.x < groundSegment.x2 ) {
        // keep orb from going into ground
        groundYTemp = char_height/2;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }
     if(ground_type == 3){
      if (groundYTemp > -char_width/2 &&
        position.y > groundSegment.y1 &&
        position.y < groundSegment.y2 ) {
        // keep orb from going into ground
        groundYTemp = -char_width/2;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }

    // Reset ground, velocity and orb
    deltaX = cosine * groundXTemp - sine * groundYTemp;
    deltaY = cosine * groundYTemp + sine * groundXTemp;
    velocity.x = cosine * velocityXTemp - sine * velocityYTemp;
    velocity.y = cosine * velocityYTemp + sine * velocityXTemp;
    position.x = groundSegment.x + deltaX;
    position.y = groundSegment.y + deltaY;
  } // End checkGroundCollision

}


public class Enemy extends Character{
  public Enemy(String File, int x, int y){
    obj = loadImage(File);
    velocity = new PVector(random(1,3), random(1,3));
    position = new PVector(x, y);
    char_width = obj.width;
    char_height = obj.height;
    r = max(char_width, char_height)/2;    
    damping = 1.02f;
    m = char_width*4;
  }
    public void Draw(){
    if(millis() - kick_start_time > 750) kicking = false;
    imageMode(CENTER);    
      image(obj, position.x, position.y);
  }
}

public class Ground {
  int segments;
  int ground_type;  // 0 = Bottom
  Ground_Seg[] ground_seg;
  float[] peakHeights;
  
  // Constructor
  Ground(int segments, int ground_type, int pad_height, int peak_height){
    this.segments = segments;
    this.ground_type = ground_type;
    
    ground_seg = new Ground_Seg[segments];
    peakHeights = new float[segments+1];
  
    // Bottom
    if(ground_type == 0){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(height - pad_height - peak_height, height - pad_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(width*1.4f/segs*i, peakHeights[i], width/segs*1.4f*(i+1), peakHeights[i+1]);
        }
        Translate(-(int)(width*0.2f), 0);
    }
    // Right
    if(ground_type == 1){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(width - pad_height - peak_height, width - pad_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(peakHeights[i], height*1.4f/segs*i, peakHeights[i+1], height/segs*1.4f*(i+1));
        }
        Translate(0,-(int)(height*0.1f));
    }
    //Top
    if(ground_type == 2){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(pad_height, peak_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(width*1.4f/segs*i, peakHeights[i], width/segs*1.4f*(i+1), peakHeights[i+1]);
        }
        Translate(-(int)(width*0.1f), 0);
    }
    // Left
    if(ground_type == 3){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(pad_height, peak_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(peakHeights[i], height*1.4f/segs*i, peakHeights[i+1], height/segs*1.4f*(i+1));
        }
        Translate(0,-(int)(height*0.2f));
    }
  } // End Ground Constructor
  
  public int getGroundType(){
    return ground_type;
  }
  public int getSegmentNum(){
    return segments;
  }
  public Ground_Seg getSegment(int i){
    return ground_seg[i];
  }
  
  public void Translate(float x, float y){
    for (int i=0; i<segments; i++){
          ground_seg[i].translate(x, y);
    }
  }
  
  public void Draw(){
      // Draw ground
    fill(127);
    beginShape();
    // Bottom
    if(ground_type == 0){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(ground_seg[segments-1].x2, height);
      vertex(ground_seg[0].x1, height);
      endShape(CLOSE);
    }
    // Right
    if(ground_type == 1){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(width, ground_seg[segments-1].y2);
      vertex(width, ground_seg[0].y1);
      endShape(CLOSE);
    }
    // Top
    if(ground_type == 2){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(ground_seg[segments-1].x2, 0);
      vertex(ground_seg[0].x1, 0);
      endShape(CLOSE);
    }
    // Left
    if(ground_type == 3){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(0, ground_seg[segments-1].y2);
      vertex(0, ground_seg[0].y1);
      endShape(CLOSE);
    }
  } // End Draw  
}// End Ground Class
  class Ground_Seg {  
  float x1, y1, x2, y2;  
  float x, y, len, rot;
  
    Ground_Seg(float x1, float y1, float x2, float y2) {
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      x = (x1+x2)/2;
      y = (y1+y2)/2;
      len = dist(x1, y1, x2, y2);
      rot = atan2((y2-y1), (x2-x1));
    }
    public void translate(float x, float y){
      x1 += x;
      x2 += x;
      this.x += x;
      y1 += y;
      y2 += y;
      this.y += y;
    }
  }



class Orb {
  // Orb has position and velocity
  PVector position;
  PVector velocity;
  float r, r_start;
  // A damping of 80% slows it down when it hits the ground
  float damping = 0.8f;
  float m;

  Orb(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = new PVector(random(0,10), random(0,10));
    r = r_;
    r_start = r;
    m = 2*r;
  }

  public void move() {
    // Move orb
    r = r_start + mag(velocity.x, velocity.y)/2;
    velocity.add(gravity);
    position.add(velocity);
  }

  public void Draw() {
    // Draw orb
    stroke(200, 0, 100);
    fill(mag(velocity.x,velocity.y)*40, 255-mag(velocity.x,velocity.y)*40, 0);
    ellipse(position.x, position.y, r*2, r*2);
    noStroke();
  }
  
  // Check boundaries of window
  public void checkWallCollision() {
    if (position.x > width-r) {
      position.x = width-r;
      velocity.x *= -damping;
    } 
    else if (position.x < r) {
      position.x = r;
      velocity.x *= -damping;
    }
  }
  public void checkGround(Ground ground){
    int seg = ground.getSegmentNum();
    for (int i=0; i<seg; i++){
      checkGroundCollision(ground.getSegment(i),ground.getGroundType());
    }
  }

  public void checkGroundCollision(Ground_Seg groundSegment, int ground_type) {

    // Get difference between orb and ground
    float deltaX = position.x - groundSegment.x;
    float deltaY = position.y - groundSegment.y;

    // Precalculate trig values
    float cosine = cos(groundSegment.rot);
    float sine = sin(groundSegment.rot);

    /* Rotate ground and velocity to allow 
     orthogonal collision calculations */
    float groundXTemp = cosine * deltaX + sine * deltaY;
    float groundYTemp = cosine * deltaY - sine * deltaX;
    float velocityXTemp = cosine * velocity.x + sine * velocity.y;
    float velocityYTemp = cosine * velocity.y - sine * velocity.x;

    /* Ground collision - check for surface 
     collision and also that orb is within 
     left/rights bounds of ground segment */
     if(ground_type == 0){
      if (groundYTemp > -r &&
        position.x > groundSegment.x1 &&
        position.x < groundSegment.x2 ) {
        // keep orb from going into ground
        groundYTemp = -r;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }
     if(ground_type == 1){
      if (groundYTemp < r &&
        position.y > groundSegment.y1 &&
        position.y < groundSegment.y2 ) {
        // keep orb from going into ground
        groundYTemp = r;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }
     if(ground_type == 2){
      if (groundYTemp < r &&
        position.x > groundSegment.x1 &&
        position.x < groundSegment.x2 ) {
        // keep orb from going into ground
        groundYTemp = r;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }
     if(ground_type == 3){
      if (groundYTemp > -r &&
        position.y > groundSegment.y1 &&
        position.y < groundSegment.y2 ) {
        // keep orb from going into ground
        groundYTemp = -r;
        // bounce and slow down orb
        velocityYTemp *= -1.0f;
        velocityYTemp *= damping;
      }
     }

    // Reset ground, velocity and orb
    deltaX = cosine * groundXTemp - sine * groundYTemp;
    deltaY = cosine * groundYTemp + sine * groundXTemp;
    velocity.x = cosine * velocityXTemp - sine * velocityYTemp;
    velocity.y = cosine * velocityYTemp + sine * velocityXTemp;
    position.x = groundSegment.x + deltaX;
    position.y = groundSegment.y + deltaY;
  } // End checkGroundCollision
  /*
  void checkCharacterCollision(Character obj){
    PVector character_pos = obj.getPos();
    if(  position.x + r > character_pos.x && 
         position.y + r > character_pos.y &&
         position.x - r < character_pos.x + obj.getCharacterWidth() &&
         position.y - r < character_pos.y + obj.getCharacterHeight()){
            PVector character_vel = obj.getVel();
            PVector new_character_vel = new PVector(character_vel.x + velocity.x/10, character_vel.y + velocity.y/10);
            PVector new_velocity = new PVector(velocity.x + character_vel.x/2, velocity.y + character_vel.y/2);
            velocity = new_velocity;
            position.add(velocity);
              
            obj.setVel(new_character_vel);
            character_pos.add(new_character_vel);
            obj.setPos(character_pos);            
         }
  }*/

  public void checkCharacterCollision(Character obj) {

    // get distances between the balls components
    PVector bVect = PVector.sub(obj.position, position);

    // calculate magnitude of the vector separating the balls
    float bVectMag = bVect.mag();

    if (bVectMag < r + obj.r) {
      // get angle of bVect
      float theta  = bVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
        };

        /* this ball's position is relative to the other
         so you can use the vector between them (bVect) as the 
         reference point in the rotation expressions.
         bTemp[0].position.x and bTemp[0].position.y will initialize
         automatically to 0.0, which is what you want
         since b[1] will rotate around b[0] */
        bTemp[1].x  = cosine * bVect.x + sine * bVect.y;
      bTemp[1].y  = cosine * bVect.y - sine * bVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
        };

        vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * obj.velocity.x + sine * obj.velocity.y;
      vTemp[1].y  = cosine * obj.velocity.y - sine * obj.velocity.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
        };

      // final rotated velocity for b[0]
      vFinal[0].x = ((m - obj.m) * vTemp[0].x + 2 * obj.m * vTemp[1].x) / (m + obj.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((obj.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + obj.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
        };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      obj.position.x = position.x + bFinal[1].x;
      obj.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      obj.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      obj.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      obj.kicking = true;
      obj.kick_start_time = millis();
      //player.play();
    }
  }





















  
  
}




  public int sketchWidth() { return 720; }
  public int sketchHeight() { return 480; }
}
