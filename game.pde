class Game
{
  String[] _line = loadStrings("levels/level1.txt");
  
  Board _board;
  Hero _hero;

  String _levelName;

  int _numberCellsX = _line[0].length();
  int _numberCellsY = _line.length - 1;
  
  float _sizeCell = float(width)/ _numberCellsX;
  
  PVector _posTab;
  PVector _sizeTab;

  Game() {
    _levelName = _line[1];
    _posTab = new PVector(0, 2.5 * _sizeCell);
    _sizeTab = new PVector(width, height - _posTab.y);
    _board = new Board(_posTab, _sizeTab, _numberCellsX, _numberCellsY, _line);
    _hero = new Hero(_board._cellSize);
  }

  void update() {
    
  }

  void drawIt() {
    background(orange);
    fill(black); 
    textSize(_TextSize);
    text(_levelName, _TextPos, _posTab.y/2 );
    //_board.drawIt();
    _hero.drawIt();
  }

  void handleKey(int k) {
  }
}
