class Game
{
  Board _board;
  Hero _hero;

  String _levelName;

  int _numberCellsX = 15;
  int _numberCellsY = 13;
  
  PVector _posTableau;
  PVector _sizeTableau;

  Game() {
    _posTableau = new PVector(0,0);
    _sizeTableau = new PVector(800, 800);
    _board = new Board(_posTableau, _sizeTableau, _numberCellsX, _numberCellsY);
    _hero = null;
  }

  void update() {
  }

  void drawIt() {
    _board.drawIt();
  }

  void handleKey(int k) {
  }
}
