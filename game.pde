class Game
{
  String[] _line = loadStrings("levels/level1.txt");
  
  Board _board;
  Hero _hero;

  String _levelName;

  int _numberCellsX = _line[0].length();
  int _numberCellsY = _line.length;
  
  //float start_posY;
  
  PVector _posTab;
  PVector _sizeTab;

  Game() {
    //start_posY = _sizeTab.y * 2;
    _posTab = new PVector(0,0);
    _sizeTab = new PVector(width, height);
    _board = new Board(_posTab, _sizeTab, _numberCellsX, _numberCellsY, _line);
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
