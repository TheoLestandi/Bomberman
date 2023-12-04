class Hero {
  float CellS;
  // position on screen
  PVector _position;
  
  // position on board
  int _cellX, _cellY;
  
  // display size
  float _size;
  
  // if hero was hit by a bomb
  boolean _wasHit;
  PImage characters = loadImage("data/img/characters.png");
  PImage hero = characters.get(16, 0, 16, 24);
  float lignebis = ( 2 + 5 ) * board.cellSize;
  float colonnebis = 3 * cellSize;

  Hero(float cellSize) {
    _wasHit = false;
    cellS=cellSize;
  }

  void move(Board board, PVector direction) {
  }

  void update(Board board) {
  }

  void drawIt() {
    image( hero, 4, lignebis, cellS, cellS) ;
    
  }
}
