class Hero {
  
  // position on screen
  PVector _position;
  
  // position on board
  float _cellX, _cellY;
  
  // display size
  float _cellS;  
  float _size;
  
  boolean movingUp = false;
  boolean movingDown = false;
  boolean movingLeft = false;
  boolean movingRight = false;
  
  // if hero was hit by a bomb
  boolean _wasHit;
  
  // sprite du hero
  PImage hero;

  Hero(PVector posH, float cellSize,  float ecart, String[] _line, PImage sprite) {
    _wasHit = false;
    _cellS = cellSize;
    _size = _cellS + _cellS / 2; 
    _position= new PVector(posH.x * _cellS, posH.y * _cellS + ecart);
    
    _cellY = posH.y;
    _cellX = posH.x;
    hero = sprite;
    
  }

  void move(Board board, PVector direction) {
    _cellX += (direction.x * _cellS)/4;
    _cellY += (direction.y * _cellS)/4;
    _position.x += (direction.x * _cellS)/4;
    _position.y += (direction.y * _cellS)/4;
    
    
  }

  void update(Board board) {
    board.drawIt();
  }

  void drawIt(PImage hero) { 
    image(hero, _position.x, _position.y, _cellS, _cellS);
  }
  
}
