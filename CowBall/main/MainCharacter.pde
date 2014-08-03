public class MainCharacter extends Character{
  PImage heart;
  
  MainCharacter(String File, int x, int y, String File_kick){
    Character_Type = 0;
    obj = loadImage(File);
    obj_kick = loadImage(File_kick);
    heart = loadImage("heart.png");
    char_width = obj.width;
    char_height = obj.height;
    velocity = new PVector(0,0);//random(3,6), random(3,6));
    position = new PVector(x, y);
    r = max(char_width, char_height)/2;
    m = char_width;
    damping = 0.5;
    HP = 3;
  }

 public void Draw(){
   DrawHP(); 
   if(millis() - kick_start_time > 750) kicking = false;
    imageMode(CENTER);
    if(kicking){
      image(obj_kick, position.x, position.y);
    }else{
      image(obj, position.x, position.y);
    }    
  }
  private void DrawHP(){
    int width_pad = 2;
    int height_pad = 2 ;
    int offset = 2;
    image(obj, char_width/2 + width_pad, char_height/2 + height_pad, char_width*0.6, char_height*0.6);
    for(int i = 0; i < HP; i++){
      image(heart, char_width + width_pad + heart.width*i + offset*i + 3, char_height/2 + height_pad);
    }
  }
}
