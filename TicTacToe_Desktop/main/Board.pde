public class Board
{

  BoardSquare [][] board = new BoardSquare[3][3];
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
      }
    }
  }

  public BoardSquare GetSquare(int row, int col)
  {
    BoardSquare abc = board[1][1];
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
  public boolean GameOver(){
    return RowWin(1) || RowWin(2)
    || ColumnWin(1) || ColumnWin(2)
    || DiagonalWin(1) || DiagonalWin(2)
    || BoardFull();
  }
}
