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
    damping = 0.5;
  }
  PVector getPos(){
    return position;
  }
  PVector getVel(){
    return velocity;
  }
  int getCharacterWidth()
  {
    return char_width;
  }
  int getCharacterHeight()
  {
    return char_height;
  }
  void setVel(PVector vel){
    velocity = vel;
  }
  void setPos(PVector pos){
    position = pos;
  }
  void accelerate()
  {
    acceleration = new PVector( map((mouseX - pmouseX), 0, width, 0, max_x_accel),  map((mouseY - pmouseY), 0, height, 0, max_y_accel));
    // Move Character 
    velocity.add(acceleration);
  }
  void move() {    
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
  void checkWallCollision() {
    if (position.x > width-r) {
      position.x = width-r;
      velocity.x *= -damping;
    } 
    else if (position.x < r) {
      position.x = r;
      velocity.x *= -damping;
    }
  }
  void checkGround(Ground ground){
    int seg = ground.getSegmentNum();
    for (int i=0; i<seg; i++){
      checkGroundCollision(ground.getSegment(i),ground.getGroundType());
    }
  }

  void checkGroundCollision(Ground_Seg groundSegment, int ground_type) {

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
        velocityYTemp *= -1.0;
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
        velocityYTemp *= -1.0;
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
        velocityYTemp *= -1.0;
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
        velocityYTemp *= -1.0;
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


