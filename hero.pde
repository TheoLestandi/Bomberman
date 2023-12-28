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
  
  //PImage characters = loadImage("data/img/characters.png");
  //PImage hero = characters.get(16, 0, 16, 24);
  
  Parser _parser_hero;
  
  PImage [][] _tabH ;

  Hero(float cellSize, String[] _line) {
    _wasHit = false;
    _cellS = cellSize;
    _size = _cellS + _cellS / 2; 
    _cellY = 2 * _size;
    _cellX = _cellS;
    
    _parser_hero = new Parser( _line );
    _tabH = _parser_hero.loadHero();
  }

  void move(Board board, PVector direction) {
    _cellX += direction.x * _cellS;
    _cellY += direction.y * _cellS;
  }

  void update(Board board) {
    //board.drawIt();
  }

  void drawIt(PImage hero) { 
    image(hero, _cellX, _cellY, _cellS, _size);
  }
  
}
