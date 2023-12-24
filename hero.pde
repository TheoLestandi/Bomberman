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
  
  PImage characters = loadImage("data/img/characters.png");
  PImage hero = characters.get(16, 0, 16, 24);
   

  Hero(float cellSize) {
    _wasHit = false;
    _cellS = cellSize;
    _size = _cellS + _cellS / 2; 
    _cellY = 2 * _size;
    _cellX = _cellS;
  }

  void move(Board board, PVector direction) {
    _cellX += direction.x * _cellS;
    _cellY += direction.y * _cellS;
    drawIt(_cellX,_cellY);
  }

  void update(Board board) {
    board.drawIt();
    
  }

  void drawIt(float cellX, float cellY) {
    image( hero, cellX, cellY, _cellS, _size) ;
       
  }
}
