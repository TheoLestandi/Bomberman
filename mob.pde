class Mob {
  // position on screen
  PVector [] possibilities = {new PVector(-1, 0), new PVector(0, -1), new PVector(0, 1), new PVector(1, 0)};
  PVector _position;
  
  // position on board
  int _cellX, _cellY;
  
  // display size
  float _size;
  float _ecart;
  
  boolean _pause= false;
  boolean _dead= false;
  
  Mob(PVector position_on_board, float size, float ecart) {
    _cellX = int(position_on_board.y);
    _cellY = int(position_on_board.x);
    _position = new PVector(position_on_board.y, position_on_board.x);
    println(_position);
    _size = size;
    _ecart = ecart;
  }
  
  void drawIt() {
    noStroke();
    fill(255,255,0);
    rect(_position.x * _size, _position.y* _size + _ecart, _size, _size);
  }
}
