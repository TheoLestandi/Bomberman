class Hero {
  float cellS;
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
  float lignebis;
  float colonnebis;

  Hero(float cellSize) {
    _wasHit = false;
    cellS = cellSize;
    lignebis = (5 + 2) * cellS;
    colonnebis = 3 * cellS;
  }

  void move(Board board, PVector direction) {
  }

  void update(Board board) {
  }

  void drawIt() {
    image( hero, colonnebis, lignebis, cellS, cellS) ;
    
  }
}
