public class CollisionSystem { //<>//
  private MinPQ<Event> pq;        // the priority queue
  //private double t  = 0.0;        // simulation clock time
  private double hz = 1;        // number of redraw events per clock tick
  private Particle[] particles;   // the array of particles
  private Event e;

    // create a new collision system with the given set of particles
  public CollisionSystem(Particle[] particles) {
    this.particles = particles;
    simulate_ahead(10000);//double limit)
  }

  // updates priority queue with all new events for particle a
  private void predict(Particle a, double limit) {
    if (a == null) return;

    // particle-particle collisions
    for (int i = 0; i < particles.length; i++) {
      double dt = a.timeToHit(particles[i]);
      if (time + dt <= limit)
        pq.insert(new Event(time + dt, a, particles[i]));
    }

    // particle-wall collisions
    double dtX = a.timeToHitVerticalWall();
    double dtY = a.timeToHitHorizontalWall();
   
    println("dtX: " + dtX);
    println("dtY: " + dtY);
    if (dtX <= limit) pq.insert(new Event(time + dtX, a, null));
    if (dtY <= limit) pq.insert(new Event(time + dtY, null, a));
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
    //if (time < limit) {
    //  pq.insert(new Event(time + 1.0 / hz, null, null));
    //}
  }
  public void simulate_ahead(double limit){
    // initialize PQ with collision events and redraw event
    pq = new MinPQ<Event>(); //<>//
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
  public void simulate(double time, double dt, double limit) {
    //println("pq.size(): " + pq.size());
    // the main event-driven simulation loop
    //if (!pq.isEmpty ()) { 

      // get impending event, discard if invalidated
      //Event e = pq.delMin();
      //if (!e.isValid()) return;//continue;
      Particle a = e.a;
      Particle b = e.b;
      //println("a: " + a);
      // physical collision, so update positions, and then simulation clock
      for (int i = 0; i < particles.length; i++){
      //println("e.t: " + e.time);
      //println("time: " + time);
      //println("e.time > time : " + (e.time > time));
        if(e.etime > time){
          particles[i].move(dt);//e.time - t);          
          //println("particle " + i + " move");
        }
        particles[i].draw();
      }      
      //println("e.t: " + t);
      // process event
      if(e.etime < time){
        //time = e.time;
        if      (a != null && b != null) a.bounceOff(b);              // particle-particle collision
        else if (a != null && b == null) a.bounceOffVerticalWall();   // particle-wall collision
        else if (a == null && b != null) b.bounceOffHorizontalWall(); // particle-wall collision
        else if (a == null && b == null) redraw(limit);               // redraw event
      
        // update the priority queue with new collisions involving a or b
        predict(a, limit);
        predict(b, limit);
        while(!pq.isEmpty ()) {
          e = pq.delMin(); 
          if (!e.isValid()) continue;//return;//continue;
          println("e.etime: " + e.etime);
        }
      }
    //}
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
