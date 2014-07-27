package processing.test.main;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

import android.os.Bundle;
import android.view.Gravity;
import android.view.Window;
import android.widget.RelativeLayout;
import com.google.ads.*;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.AdRequest;

public class main extends PApplet {

Board board;
int GameState = 1; // 1 = Play, 2 = GameOver, 3 = Quit
int whoseTurn = 1; // 1 = Player, 2 = Computer
int Winner = 0;
ComputerPlayer computer = new ComputerPlayer();
PFont font;
QuitButton quitbutton;
PlayButton playbutton;

public void setup(){
   
    background(200, 0, 0);
    board = new Board(width/3);
    quitbutton = new QuitButton("quitbutton.jpg");
    playbutton = new PlayButton("playbutton.jpg");
    font = loadFont("Andy-Bold-32.vlw");    
    
}
public void Update(){
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
public void draw(){
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

public void mousePressed(){
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
public class Board
{
  BoardSquare [][] board = new BoardSquare[3][3];
  int n; // # placed
  public Board(int sq_len)
  {
    for (int row = 0; row < 3; row++)
    {
      for (int col = 0; col < 3; col++)
      {
        board[row][col] = new BoardSquare(row*width*1/3 + width*1/6,
                                             col*height*1/3 + height*1/6,
                                             sq_len); 
      }
    } 
  }
  public void Draw()
  {
    // draw board squares
    for (int row = 0; row < 3; row++)
    {
      for (int col = 0; col < 3; col++)
      {
        board[row][col].Draw();
      }
    }
  }
  public void ClearBoard(){
    for (int row = 0; row < 3; row++)
    {
      for (int col = 0; col < 3; col++)
      {
        board[row][col].Content_Set(0);
        n = 0;
      }
    }
  }

  public BoardSquare GetSquare(int row, int col)
  {
    return board[row][col]; 
  }
  public boolean TakePlayerTurn(){
    for (int row = 0; row < 3; row++){
      for (int col = 0; col < 3; col++){
        boolean tookTurn = board[row][col].Update();
       if(tookTurn) return true;
      }
    }
    // Player has not taken turn
   return false; 
  }
  private boolean RowWin(int content){
    return( (board[0][0].content == content 
        && board[0][1].content == content 
        && board[0][2].content == content)
        || (board[1][0].content == content 
        && board[1][1].content == content 
        && board[1][2].content == content)
        || (board[2][0].content == content 
        && board[2][1].content == content 
        && board[2][2].content == content));
  }
  private boolean ColumnWin(int content){
    return( (board[0][0].content == content 
        && board[1][0].content == content 
        && board[2][0].content == content)
        || (board[0][1].content == content 
        && board[1][1].content == content 
        && board[2][1].content == content)
        || (board[0][2].content == content 
        && board[1][2].content == content 
        && board[2][2].content == content));
  }
  private boolean DiagonalWin(int content){
        return( (board[0][0].content == content 
        && board[1][1].content == content 
        && board[2][2].content == content)
        || (board[0][2].content == content 
        && board[1][1].content == content 
        && board[2][0].content == content));
    
  }
  private boolean BoardFull()
  {
    for (int row = 0; row < 3; row++)
    {
      for (int col = 0; col < 3; col++)
      {
        if(board[row][col].Content_Get() == 0) return false;
      }
    }
    return true;
  }
  public int GameOver(){
    if(RowWin(1) || ColumnWin(1) || DiagonalWin(1)){
     return 1;
    }else if(RowWin(2) || ColumnWin(2) || DiagonalWin(2)){
      return 2;
    }else if(BoardFull()){
    return 3;
    }else{
      return 0;
    }
  }
}
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
 public class ComputerPlayer
{
  int n; // Placed Move
  public ComputerPlayer(){
  }
  public void TakeTurn(Board board)
  {
    if(!TakeCenter(board)){
      if(!TakeWinMove(board)){
        if(!PreventWinMove(board)){
         if(!TakeCorner(board)) TakeRandom(board);
        }  
      }      
    }
  }
  private boolean TakeCenter(Board board){
    BoardSquare square = board.GetSquare(1, 1);
    if(square.isEmpty()){
      Place(square);
      n++;
      return true;
    }
    return false;
  }
  private boolean TakeCorner(Board board){
    BoardSquare square = board.GetSquare(0,0);
    if(square.isEmpty()){
      Place(square);
      return true;
    }
    square = board.GetSquare(0,2);
    if(square.isEmpty()){
      Place(square);
      return true;
    }
    square = board.GetSquare(2,0);
    if(square.isEmpty()){
      Place(square);
      return true;
    }
    square = board.GetSquare(2,2);
    if(square.isEmpty()){
      Place(square);
      return true;
    }
    return false;
  }
  private boolean TakeWinMove(Board board){
    boolean willwin = false;
    BoardSquare square;
    for(int i = 0, k = 0; willwin == false && i < 3; i++){
     for(int j = 0; willwin == false && j < 3; j++, k++){
       square = board.GetSquare(i, j);
       if(square.isEmpty()){
         Place(square);
         if(board.GameOver() != 0){
           willwin = true;
           return true;
         }else{
           square.Content_Remove();           
         }        
       }
     }   
    }
    return false;    
  }
  private boolean PreventWinMove(Board board){
    boolean willwin = false;
    BoardSquare square;
    for(int i = 0, k = 0; willwin == false && i < 3; i++){
     for(int j = 0; willwin == false && j < 3; j++, k++){
       square = board.GetSquare(i, j);
       if(square.isEmpty()){
          square.Content_Set(1);
         if(board.GameOver() != 0){
           square.Content_Remove();
           willwin = true;
           Place(square);
           return true;
         }else{
           square.Content_Remove();           
         }        
       }
     }   
    }
    return false;    
  }
  private boolean TakeRandom(Board board){
    BoardSquare square = board.GetSquare((int)random(3), (int)random(3));
    while(!square.isEmpty())
    {
      square = board.GetSquare((int)random(3), (int)random(3));
    }
    Place(square);
    return true;
  }
  private void Place(BoardSquare square){
    square.Content_Set(2);
  }
}
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
  public void draw(){
    imageMode(CENTER);
    image(img, center_x, center_y);
  }
  public boolean update(){
      if(mouseX > center_x-w/2 && mouseX < center_x+w/2
      && mouseY > center_y-h/2 && mouseY < center_y+h/2){
        return true;
      }
      return false;
  }
}
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
  public void draw(){
    imageMode(CENTER);
    image(img, center_x, center_y);
  }
  public void update(){
      if(mouseX > center_x-w/2 && mouseX < center_x+w/2
      && mouseY > center_y-h/2 && mouseY < center_y+h/2){
        exit();
      }
  }
}

  public int sketchWidth() { return 480; }
  public int sketchHeight() { return 480; }
  /*
	  @Override
	  public void onCreate(Bundle savedInstanceState) {
	    super.onCreate(savedInstanceState);
	    Window window = getWindow();
	    RelativeLayout adsLayout = new RelativeLayout(this);
	    RelativeLayout.LayoutParams lp2 = new RelativeLayout.LayoutParams(
	           RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.FILL_PARENT);
	     // Displays Ads at the bottom of your sketch, use Gravity.TOP to display them at the top
	    adsLayout.setGravity(Gravity.BOTTOM);
	    //AdView adView = new AdView(this, AdSize.BANNER, "pub-8663005545856692");  // add your app-id
	    AdView adView = new AdView(this.getApplicationContext());//, AdSize.BANNER,"pub-8663005545856692");
	    adView.setAdUnitId("pub-8663005545856692");
	    AdSize customAdSize = new AdSize(250, 250);
	    //adView.setAdSize(AdSize.SMART_BANNER);
	    
	    adsLayout.addView(adView);
	    AdRequest newAdReq = new AdRequest.Builder().build();
	    // Remark: uncomment next line for testing your Ads (fake ads)
	    //newAdReq.setTesting(true);
	    adView.loadAd(newAdReq);
	    window.addContentView(adsLayout,lp2);
	}*/
}
