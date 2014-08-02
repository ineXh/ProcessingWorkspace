public class Orb extends Ball{
  // Orb has position and velocity
  float r, r_start;
  // A damping of 80% slows it down when it hits the ground
  float damping = 0.8;
  float m;

  Orb(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = new PVector(random(0,10), random(0,10));
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
  




















  
  
}



