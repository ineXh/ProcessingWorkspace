import android.os.Bundle;
import android.view.Gravity;
import android.view.Window;
import android.widget.RelativeLayout;
import com.google.ads.*;

Board board;
int GameState = 1; // 1 = Play, 2 = GameOver, 3 = Quit
int whoseTurn = 1; // 1 = Player, 2 = Computer
int Winner = 0;
ComputerPlayer computer = new ComputerPlayer();
PFont font;
QuitButton quitbutton;
PlayButton playbutton;

void setup(){
    size(480, 480);
    background(255, 0, 0);
    board = new Board(width/3);
    quitbutton = new QuitButton("quitbutton.jpg");
    playbutton = new PlayButton("playbutton.jpg");
    font = loadFont("Andy-Bold-32.vlw");    
    
}
void Update(){
  boolean changeturn;
  if(GameState == 1){
      changeturn = board.TakePlayerTurn();//Update();//TakePlayerTurn();
      if(board.GameOver() == 1){
        Winner = 1;
        GameState = 2;
        return;
      }
      if (board.GameOver() == 3){
        Winner = 3;
        GameState = 2;
        return;
      }  
      if(changeturn){
       ChangeTurn();
       computer.TakeTurn(board);
       ChangeTurn(); 
      }
      if(board.GameOver() == 2){
        Winner = 2;
        GameState = 2;
        return;
      }    
  }
}
void draw(){
  // Draw Board
  board.Draw();  
  strokeWeight(6);
  
  if(GameState == 2){
    fill(random(100,255),random(100,255),random(100,255));
    textFont(font,64);
    if(Winner == 1)        
      text("You Win", width*3/10, height*45/100);
    if(Winner == 2)
      text("You Lose", width*3/10, height*45/100);
    if(Winner == 3)
      text("You Tie", width*3/10, height*45/100);
    playbutton.draw();
    quitbutton.draw();
  }
}

void mousePressed(){
 if(GameState == 1){
  Update();
  return;
 }
 if(GameState == 2){
   quitbutton.update();
   if(playbutton.update()){
     GameState = 1;
     board.ClearBoard();
   }
 }
}
private void ChangeTurn(){
  whoseTurn = (whoseTurn == 1) ? 2 : 1;
}
