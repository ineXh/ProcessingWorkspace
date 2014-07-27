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
