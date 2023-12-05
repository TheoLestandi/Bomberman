class Game
{
  String[] _line = loadStrings("levels/level1.txt");
  
  Board _board;
  Hero _hero;

  String _levelName;

  int _numberCellsX = _line[0].length();
  int _numberCellsY = _line.length;
  
  PVector _posTableau;
  PVector _sizeTableau;

  Game() {
    _posTableau = new PVector(0,0);  // pas utile 
    _sizeTableau = new PVector(width, height);
    _board = new Board(_posTableau, _sizeTableau, _numberCellsX, _numberCellsY, _line);
    _hero = new Hero(_board._cellSize);
  }

  void update() {
    
  }

  void drawIt() {
    background(orange);
    _board.drawIt();
    _hero.drawIt();
  }

  void handleKey(int k) {
  }
}
