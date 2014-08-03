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
    HP = HPMax;
    Character_Type = 1;  // Enemy
  }
    public void Draw(){    
      imageMode(CENTER);    
      image(obj, position.x, position.y); 
      DrawHP();    
    }
    private void DrawHP(){
       //rect(position.x - char_width/3, position.y - char_height/2 - 3,
        //    char_width*2/3, 2, 5);
      fill(255,255,255, 200);
      //rectMode(CORNER)
      rect(width - HPBar_Length -20, HPBar_Height, HPBar_Length, HPBar_Height, HPBar_Height/2,HPBar_Height/2,HPBar_Height/2,HPBar_Height/2);
      
      float HP_Length = map(HP, 0, HPMax, 0, HPBar_Length);
      HP_Length = (HP_Length < 0) ? 0 : HP_Length;      
      fill(255,0,0, 100);
      rect(width - HPBar_Length -20, HPBar_Height, HP_Length, HPBar_Height, HPBar_Height/2,HPBar_Height/2,HPBar_Height/2,HPBar_Height/2);
      //fill(255,0,255, 200);
      //String strHP = "Boss HP: ";
      //text(strHP, width - HPBar_Length - 75, HPBar_Height + 12);
      image(obj, width - HPBar_Length - 38, HPBar_Height + 9, char_width/3, char_height/3);
    }
}

