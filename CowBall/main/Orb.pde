class Orb {
  // Orb has position and velocity
  PVector position;
  PVector velocity;
  float r, r_start;
  // A damping of 80% slows it down when it hits the ground
  float damping = 0.8;
  float m;

  Orb(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = new PVector(random(0,1), random(0,1));
    r = r_;
    r_start = r;
    m = 2*r;
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
 

  void checkCharacterCollision(Character obj) {

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

      // Boss lose HP
      if(obj.getCharacterType() == 1){
        int vel = (int)mag(velocity.x, velocity.y);
        float vel_map = map(vel, 0, 10, 0, 1.0);
        obj.loseHP(vel);
        //hipponoise.setVolume(vel_map, vel_map);
        //hipponoise.seekTo(0); //"rewind"
        //hipponoise.start(); //start play back
      }
      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      obj.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      obj.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      obj.kicking = true;
      if(millis() - obj.last_kick_start_time > 750){ 
        obj.last_kick_start_time = millis();
      }else if(millis() - obj.last_kick_start_time > 500){
        obj.position.x += obj.r;
        obj.position.y += obj.r;
      }
      obj.kick_start_time = millis();
      if(obj.getCharacterType() == 0){
        //short_moo.seekTo(0); //"rewind"
        //short_moo.start(); //start play back
        //player.cue(0);
        //player.play();
      }
    }
  }





















  
  
}



