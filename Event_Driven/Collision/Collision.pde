Particle[] particles;
//Particle particles;

void setup() {
  size(200, 200);
  
  int N = 1;
  
  particles = new Particle[N];
  //for (int i = 0; i < N; i++){
   // particles[i] = new Particle();
  //}
  particles[0] =  new Particle((double)0.0, (double)height/2, (double)1.0, (double)0.0, (double)10.0, (double)1.0);//, Color color) 

  //CollisionSystem system = new CollisionSystem(particles);
  //system.simulate(100);
        
}

void draw(){
  particles[0].move(1);
  particles[0].draw();
}
