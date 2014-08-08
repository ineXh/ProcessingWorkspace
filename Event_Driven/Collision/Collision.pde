Particle[] particles;
//Particle particles;
CollisionSystem system;
double startTime;
double time;
double Ti, Te;

void setup() {
  size(400, 200);
  
  int N = 10;
  
  particles = new Particle[N];
  int i;
  for (i = 0; i < N; i++){
    particles[i] = new Particle();
  }
  particles[i-1] =  new Particle((double)0, (double)height/2, (double)100.0, (double)00.0, (double)10.0, (double)1.0, new Color(0,255,0));//, Color color)
  //particles[0] =  new Particle((double)0, (double)height/2 + 0, (double)200.0, (double)00.0, (double)10.0, (double)0.1, new Color(0,255,0));//, Color color)
 //particles[1] =  new Particle((double)width, (double)height/2 - 0, (double)-200.0, (double)00.0, (double)10.0, (double)1, new Color(0,0,255));//, Color color) 

  system = new CollisionSystem(particles);
  startTime = (double)millis()/1000;
  Te = startTime;
  println("startTime " + startTime);
  //system.simulate(100);
  frameRate(100);
        
}

void draw(){
  double dt;
  background(0, 0, 0);
  //if(particles[0].rx < width-particles[0].radius){
    Ti = (double)millis()/1000;
    dt = Ti - Te;
    time = time + dt;
    //println("dt" + dt);
    //println("time: " + time);
    system.simulate();//time, dt, 10000);
    //particles[0].move(dt);
    //particles[0].draw();
    Te = (double)millis()/1000;
  //}
}
