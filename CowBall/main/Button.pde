public class Button
{
  PImage img;
  int w;
  int h;
  int center_x;
  int center_y;
  public Button(String str, int x, int y){
    img = loadImage(str);
    w = 200;//img.width;
    h = 100;//img.height;
    center_x = x;
    center_y = y;
    
  }
  void draw(){
    imageMode(CENTER);
    image(img, center_x, center_y);
  }
  boolean update(){
      if(mouseX > center_x-w/2 && mouseX < center_x+w/2
      && mouseY > center_y-h/2 && mouseY < center_y+h/2){
        if (mousePressed == true)
        return true;
      }
      return false;
  }
}
