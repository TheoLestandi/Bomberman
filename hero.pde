class Hero {
  
  // position on screen
  PVector _position;
  
  // position on board
  float _cellX, _cellY, _cellCenter;
  
  // display size
  float _cellS;  
  float _size;
  
  // if hero was hit by a bomb
  boolean _wasHit;
  
  // sprite du hero
  PImage hero;

  Hero(float cellSize, String[] _line, PImage sprite) {
    _wasHit = false;
    _cellS = cellSize;
    _size = _cellS + _cellS / 2; 
    _cellY = 2 * _size;
    _cellX = _cellS;
    hero = sprite;
    
  }

  void move(Board board, PVector direction, PImage sprite_move) {
    _cellX += direction.x * _cellS;
    _cellY += direction.y * _cellS;
    hero = sprite_move;
    
  }

  void update(Board board) {
    board.drawIt();
  }

  void drawIt() { 
    image(hero, _cellX, _cellY, _cellS, _size);
  }
  
}
