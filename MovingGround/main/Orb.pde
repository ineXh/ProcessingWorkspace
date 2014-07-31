class Orb {
  // Orb has positio and velocity
  PVector position;
  PVector velocity;
  float r, r_start;
  // A damping of 80% slows it down when it hits the ground
  float damping = 0.8;

  Orb(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = new PVector(random(0,10), random(0,10));
    r = r_;
    r_start = r;
  }

  void move() {
    // Move orb
    r = r_start + mag(velocity.x, velocity.y)/2;
    velocity.add(gravity);
    position.add(velocity);
  }

  void Draw() {
    // Draw orb
    stroke(200, 0, 100);
    fill(mag(velocity.x,velocity.y)*40, 255-mag(velocity.x,velocity.y)*40, 0);
    ellipse(position.x, position.y, r*2, r*2);
    noStroke();
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
      if (groundYTemp > -r &&
        position.x > groundSegment.x1 &&
        position.x < groundSegment.x2 ) {
        // keep orb from going into ground
        groundYTemp = -r;
        // bounce and slow down orb
        velocityYTemp *= -1.0;
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
        velocityYTemp *= -1.0;
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
        velocityYTemp *= -1.0;
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
  void checkCharacterCollision(Character obj){
    PVector character_pos = obj.getPos();
    if(  position.x + r > character_pos.x && 
         position.y + r > character_pos.y &&
         position.x - r < character_pos.x + obj.getCharacterWidth() &&
         position.y - r < character_pos.y + obj.getCharacterHeight()){
            PVector character_vel = obj.getVel();
            velocity.add(character_vel);
            position.add(velocity);            
         }
  }
}

