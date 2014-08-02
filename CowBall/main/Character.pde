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
  
  int HP;
  
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
    HP = 5;
  }
  
  int getCharacterWidth()
  {
    return char_width;
  }
  int getCharacterHeight()
  {
    return char_height;
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
  
  

}


