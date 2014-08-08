Particle[] particles;
//Particle particles;
CollisionSystem system;
double startTime;
double time;
double Ti, Te;

void setup() {
  size(400, 200);
  
  int N = 1;
  
  particles = new Particle[N];
  for (int i = 0; i < N; i++){
    //particles[i] = new Particle();
  }
  particles[0] =  new Particle((double)width/2, (double)height/2, (double)100.0, (double)100.0, (double)10.0, (double)1.0);//, Color color) 

  system = new CollisionSystem(particles);
  startTime = (double)millis()/1000;
  Te = startTime;
  println("startTime " + startTime);
  //system.simulate(100);
        
}

void draw(){
  double dt;
  background(0, 0, 0);
  //if(particles[0].rx < width-particles[0].radius){
    Ti = (double)millis()/1000;
    time = Ti - startTime;
    dt = Ti - Te;
    //println("time: " + time);
    system.simulate(time, dt, 10000);
    //particles[0].move(dt);
    //particles[0].draw();
    Te = (double)millis()/1000;
  //}
}
