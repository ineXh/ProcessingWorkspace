public class Particle {
    private static final double INFINITY = Double.POSITIVE_INFINITY;

    public double rx, ry;    // position
    public double vx, vy;    // velocity
    private double radius;    // radius
    private double mass;      // mass
    private Color clr;      // color
    private int count;        // number of collisions so far


    // create a new particle with given parameters        
    public Particle(double rx, double ry, double vx, double vy, double radius, double mass, Color clr) {
        this.vx = vx;
        this.vy = vy;
        this.rx = rx;
        this.ry = ry;
        this.radius = radius;
        this.mass   = mass;
        this.clr  = clr;
    }
         
    // create a random particle in the unit box (overlaps not checked)
    public Particle() {
        rx     = random(width);//Math.random();
        //println("rx:" + rx);
        ry     = random(height);//Math.random();
        //println("ry:" + ry);
        vx     = random(500);//0.01 * (Math.random() - 0.5);
        //println("vx:" + vx);
        vy     = random(500);//0.01 * (Math.random() - 0.5);
        //println("vy:" + vy);
        radius = 10;
        mass   = 1;
        clr  = new Color((int)random(255), (int)random(255), (int)random(255));//Color.BLACK;
    }

    // updates position
    public void move(double dt) {
        rx += vx * dt;
        ry += vy * dt;
    }

    // draw the particle
    public void draw() {
      fill(clr.R,clr.G,clr.B);
      ellipse((float)rx,(float)ry,(float)radius*2,(float)radius*2);
        //StdDraw.setPenColor(color);
        //StdDraw.filledCircle(rx, ry, radius);
    }

    // return the number of collisions involving this particle
    public int count() { return count; }
        
  
    // how long into future until collision between this particle a and b?
    public double timeToHit(Particle b) {
        Particle a = this;
        if (a == b) return INFINITY;
        double dx  = b.rx - a.rx;
        double dy  = b.ry - a.ry;
        double dvx = b.vx - a.vx;
        double dvy = b.vy - a.vy;
        double dvdr = dx*dvx + dy*dvy;
        if (dvdr > 0) return INFINITY;
        double dvdv = dvx*dvx + dvy*dvy;
        double drdr = dx*dx + dy*dy;
        double sigma = a.radius + b.radius;
        double d = (dvdr*dvdr) - dvdv * (drdr - sigma*sigma);
        // if (drdr < sigma*sigma) StdOut.println("overlapping particles");
        if (d < 0) return INFINITY;
        return -(dvdr + Math.sqrt(d)) / dvdv;
    }

    // how long into future until this particle collides with a vertical wall?
    public double timeToHitVerticalWall() {
        if      (vx > 0) return (width - rx - radius) / vx;
        else if (vx < 0) return (radius - rx) / vx;  
        else             return INFINITY;
    }

    // how long into future until this particle collides with a horizontal wall?
    public double timeToHitHorizontalWall() {
        if      (vy > 0) return (height - ry - radius) / vy;
        else if (vy < 0) return (radius - ry) / vy;
        else             return INFINITY;
    }

    // update velocities upon collision between this particle and that particle
    public void bounceOff(Particle that) {
        double damping = 1;
        double dx  = that.rx - this.rx;
        //println("that.rx :" + that.rx);
        //println("this.rx :" + this.rx);
        //println("dx :" + dx);
        double dy  = that.ry - this.ry;
        //println("dy :" + dy);
        
         double dist = this.radius + that.radius;   // distance between particle centers at collison
        //println("dist :" + dist);
        while(mag((float)dx, (float)dy) > dist){
          dx = dx* 0.9999;
          dy = dy* 0.9999;
        }
        //if(dx > dist) dx = dist;
        //if(dy > dist) dy = dist;
        
        
        double dvx = that.vx - this.vx;
        //println("dvx :" + dvx);
        double dvy = that.vy - this.vy;
        //println("dvy :" + dvy);
        double dvdr = dx*dvx + dy*dvy;             // dv dot dr
        //println("dvdr :" + dvdr);
        
       
        
        // normal force F, and in x and y directions
        double F = 2 * this.mass * that.mass * dvdr / ((this.mass + that.mass) * dist);
        //println("F :" + F);
        double fx = F * dx / dist;
        //println("fx :" + fx);
        double fy = F * dy / dist;
        //println("fy :" + fy);
        
        // update velocities according to normal force
        this.vx += fx / this.mass*damping;
        this.vy += fy / this.mass*damping;
        that.vx -= fx / that.mass*damping;
        that.vy -= fy / that.mass*damping;

        // update collision counts
        this.count++;
        that.count++;
    }

    // update velocity of this particle upon collision with a vertical wall
    public void bounceOffVerticalWall() {
        vx = -vx;
        count++;
    }

    // update velocity of this particle upon collision with a horizontal wall
    public void bounceOffHorizontalWall() {
        vy = -vy;
        count++;
    }

    // return kinetic energy associated with this particle
    public double kineticEnergy() { return 0.5 * mass * (vx*vx + vy*vy); }
}

