class Mob {
  // position on screen
  PVector [] possibilities = {new PVector(-1, 0), new PVector(0, -1), new PVector(0, 1), new PVector(1, 0)};
  PVector _position;
  
  // position on board
  int _cellX, _cellY;
  
  // display size
  float _size;
  
  boolean _pause;
  boolean _dead;
  
  Mob(PVector position_on_board, float size) {
     
  }
}
