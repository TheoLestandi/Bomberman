class Hero {
  
  // position on screen
  PVector _position;
  
  // position on board
  float _cellX, _cellY;
  
  // display size
  float _size;
  
  // if hero was hit by a bomb
  boolean _wasHit;
  
  PImage characters = loadImage("data/img/characters.png");
  PImage hero = characters.get(16, 0, 16, 24);
  
  float lignebis;
  float colonnebis;
  float cellS;  

  Hero(float cellSize) {
    _wasHit = false;
    cellS = cellSize;
    _size = cellS + cellS / 2; 
    _cellY = 2 * cellS + cellS/2;
    _cellX = cellS;
  }

  void move(Board board, PVector direction) {
    _cellX=direction.x;
    _cellY=direction.y;
    
    
  }

  void update(Board board) {
  }

  void drawIt() {
    image( hero, _cellX, _cellY, cellS, cellS+cellS/2) ;
    
  }
}
