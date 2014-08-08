public class CollisionSystem { //<>//
  private MinPQ<Event> pq;        // the priority queue
  private double t  = 0.0;        // simulation clock time
  private double dt = 0.01;
  private double hz = 1;        // number of redraw events per clock tick
  private double limit = 10000;
  private Particle[] particles;   // the array of particles
  private Event e;

    // create a new collision system with the given set of particles
  public CollisionSystem(Particle[] particles) {
    this.particles = particles;
    pq = new MinPQ<Event>(); //<>//
    simulate_ahead(t + limit);//double limit)
  }

  // updates priority queue with all new events for particle a
  private void predict(Particle a, double limit) {
    if (a == null) return;

    // particle-particle collisions
    for (int i = 0; i < particles.length; i++) {
      double dt = a.timeToHit(particles[i]);
      //println("time to hit: " + dt);
      if (t + dt <= limit)
        pq.insert(new Event(t + dt, a, particles[i]));
    }

    // particle-wall collisions
    double dtX = a.timeToHitVerticalWall();
    double dtY = a.timeToHitHorizontalWall();
   
    //println("dtX: " + dtX);
    //println("dtY: " + dtY);
    if (dtX <= limit) pq.insert(new Event(t + dtX, a, null));
    if (dtY <= limit) pq.insert(new Event(t + dtY, null, a));
  }

  // redraw all particles
  private void redraw(double limit) {
      //println("draw()" );
  
    //StdDraw.clear();
    //background(0, 0, 0);
    for (int i = 0; i < particles.length; i++) {
      println("i" + i);
      particles[i].draw();
      
    }
    //StdDraw.show(20);
    if (time < limit) {
      pq.insert(new Event(t + dt, null, null));
    }
  }
  public void simulate_ahead(double limit){
    // initialize PQ with collision events and redraw event
    
    for (int i = 0; i < particles.length; i++) {
      predict(particles[i], limit);
    }
    if (!pq.isEmpty ()) {
      e = pq.delMin(); 
    }
    //pq.insert(new Event(0, null, null));        // redraw event
   //<>//
  }
  

  /********************************************************************************
   *  Event based simulation for limit seconds
   ********************************************************************************/
  public void simulate(){//double time, double dt, double limit) {
    
    /*if(pq.isEmpty()){
      for (int i = 0; i < particles.length; i++) {
        predict(particles[i], limit);
      }
    }*/

    Particle a = e.a;
    Particle b = e.b;
      
      // physical collision, so update positions, and then simulation clock
      for (int i = 0; i < particles.length; i++){      
        //if(e.etime >= t - dt){
          particles[i].move(dt);
         // println("particle " + i + " :" + particles[i].rx); 
        /*//}/*else{
          println("time: " + t);
          println("e.etime: " + e.etime);
          //println("dt: " + dt);
          particles[i].move(e.etime - t);//dt);//e.etime - time);
          println("particle " + i + " :" + particles[i].rx);         
        }*/
        particles[i].draw();
      }      
      //println("e.t: " + t);
      // process event
      if(e.etime <= t){
        while(e.etime <= t){
           // t = e.etime;
         // println("time: " + t);
          //t = e.etime - dt;
          if      (a != null && b != null) a.bounceOff(b);              // particle-particle collision
          else if (a != null && b == null) a.bounceOffVerticalWall();   // particle-wall collision
          else if (a == null && b != null) b.bounceOffHorizontalWall(); // particle-wall collision
          else if (a == null && b == null) redraw(limit);               // redraw event
        
          // update the priority queue with new collisions involving a or b
          predict(a, limit);
          predict(b, limit);
          //println("time: " + time);
          
          while(!pq.isEmpty ()){
            e = pq.delMin();
            //println("e.etime: " + e.etime);
            //println("e.isValid()" + e.isValid()); 
            if (e.isValid()){
              if(e.etime <= t){
              }else{
                t = t + dt;
                return;
              }
            }else if(!e.isValid()) continue;//return;//continue;            
          }
        }
        println("a");
      }
      t = t + dt;
  }

  private class Event implements Comparable<Event> {
    public final double etime;         // time that event is scheduled to occur
    private final Particle a, b;       // particles involved in event, possibly null
    private final int countA, countB;  // collision counts at event creation


    // create a new event to occur at time t involving a and b
    public Event(double t, Particle a, Particle b) {
      this.etime = t;
      this.a    = a;
      this.b    = b;
      if (a != null) countA = a.count();
      else           countA = -1;
      if (b != null) countB = b.count();
      else           countB = -1;
    }

    // compare times when two events will occur
    public int compareTo(Event that) {
      if      (this.etime < that.etime) return -1;
      else if (this.etime > that.etime) return +1;
      else                            return  0;
    }

    // has any collision occurred between when event was created and now?
    public boolean isValid() {
      if (a != null && a.count() != countA) return false;
      if (b != null && b.count() != countB) return false;
      return true;
    }
  }
}
