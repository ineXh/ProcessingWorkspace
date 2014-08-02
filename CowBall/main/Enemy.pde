public class Enemy extends Character{
  public Enemy(String File, int x, int y){
    obj = loadImage(File);
    velocity = new PVector(random(1,3), random(1,3));
    position = new PVector(x, y);
    char_width = obj.width;
    char_height = obj.height;
    r = max(char_width, char_height)/2;    
    damping = 1.02;
    m = char_width*4;
    HP = 200;
  }
    public void Draw(){    
    imageMode(CENTER);    
      image(obj, position.x, position.y);
      //rect(position.x - char_width/3, position.y - char_height/2 - 3,
        //    char_width*2/3, 2, 5);
    }
}

