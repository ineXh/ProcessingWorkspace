public class BoardSquare
{
  int content = 0;  // 0 = Empty, 1 = o, 2 = x
  int x, y, len;
 // Constructor
  public BoardSquare(int x, int y, int length)
  {
    this.x = x;
    this.y = y;
    len = length;
  }
  public int Content_Get()
  {
    return content;      
  }
  public void Content_Set(int content)
  {
    this.content = content;
  }
  public void Content_Remove(){
    content = 0;
  }
  public boolean isEmpty()
  {
    return content == 0;
  }
  public boolean Update()
  {
    //if (mousePressed == true) {
      if(mouseX > x-len/2 && mouseX < x+len/2
      && mouseY > y-len/2 && mouseY < y+len/2
      && content == 0){
        content = 1;
        return true;
      }
      return false;
    //}
    
  }
  public void Draw()
  {
    fill(220);
    rectMode(CENTER);
    rect(x, y, len, len);
    if(content == 1) Draw_O();
    if(content == 2) Draw_X();
  }
  private void Draw_O()
  {
    ellipse(x,y, len/2, len/2);
  }
  private void Draw_X()
  {
    line(x-len/3, y-len/3, x+len/3, y+len/3);
    line(x-len/3, y+len/3, x+len/3, y-len/3);
  }
}
