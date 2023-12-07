class Game{
  String[] _line = loadStrings("levels/level1.txt");
  String [] _line2=new String[_line.length-1];
  
  
  
  Board _board;
  Hero _hero;

  String _levelName;
  
  int _numberCellsX;
  int _numberCellsY;
  
  float _sizeCell;
  
  PVector _posTab;
  PVector _sizeTab;
  

  Game() {
    _levelName = _line[0];
    arrayCopy(_line, 1,_line2,0,_line2.length);
    _numberCellsX = _line2[0].length();
    _numberCellsY = _line2.length - 1;
    _sizeCell = float(width)/ _numberCellsX;
    
    _posTab = new PVector(0, 2.5 * _sizeCell);
    _sizeTab = new PVector(width, height - _posTab.y);
    _board = new Board(_posTab, _sizeTab, _numberCellsX, _numberCellsY, _line2);
    _hero = new Hero(_board._cellSize);
  }

  void update() {
    
  }

  void drawIt() {
    background(orange);
    textAlign(CENTER, CENTER);
    fill(black); 
    textSize(width/16);
    text(_levelName, width/2, _posTab.y/2 );
    _board.drawIt();
    _hero.drawIt();
  }

  void handleKey(int k) {
  }
}
