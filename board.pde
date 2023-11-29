enum TypeCell
{
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR
}

class Board
{
  TypeCell _cells[][];
  PVector _drawPosition;
  PVector _drawSize;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // cells should be square
  
  String[] _line;

  Board(PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY) {
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX;
    _nbCellsY = nbCellsY;
    _cellSize = drawSize.x / nbCellsX;
    _cells  = new TypeCell[nbCellsX][nbCellsY];
  }

  PVector getCellCenter(int i, int j) {
    PVector centerCell = new PVector( i + _cellSize / 2, j + _cellSize / 2);
    return centerCell;
  }

  void drawIt() {
    for ( int i = 0; i < _cells.length; i++ ) {
      for ( int j = 0; j < _cells[i].length; i++ ) {
        //square( i, j, _cellSize);
      }
    }
  }
}
