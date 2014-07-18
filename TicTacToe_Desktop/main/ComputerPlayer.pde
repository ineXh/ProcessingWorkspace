 public class ComputerPlayer
{
  public ComputerPlayer(){
  }
  public void TakeTurn(Board board)
  {
    BoardSquare square = board.GetSquare((int)random(3), (int)random(3));
    while(square.Content_Get() != 0)
    {
      square = board.GetSquare((int)random(3), (int)random(3));
    }
    square.Content_Set(2);
  }
}
