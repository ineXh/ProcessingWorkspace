public class PlayButton
{
  PImage img;
  int w;
  int h;
  int center_x;
  int center_y;
  public PlayButton(String str){
    img = loadImage(str);
    w = 200;//img.width;
    h = 100;//img.height;
    center_x = width/2;
    center_y = height*1/6;
    
  }
  void draw(){
    imageMode(CENTER);
    image(img, center_x, center_y);
  }
  boolean update(){
      if(mouseX > center_x-w/2 && mouseX < center_x+w/2
      && mouseY > center_y-h/2 && mouseY < center_y+h/2){
        return true;
      }
      return false;
  }
}
