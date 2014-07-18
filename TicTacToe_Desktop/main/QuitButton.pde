public class QuitButton
{
  PImage img;
  int w;
  int h;
  int center_x;
  int center_y;
  public QuitButton(String str){
    img = loadImage(str);
    w = 200;//img.width;
    h = 100;//img.height;
    center_x = width/2;
    center_y = height*5/6;
    
  }
  void draw(){
    imageMode(CENTER);
    image(img, center_x, center_y);
  }
  void update(){
      if(mouseX > center_x-w/2 && mouseX < center_x+w/2
      && mouseY > center_y-h/2 && mouseY < center_y+h/2){
        exit();
      }
  }
}
