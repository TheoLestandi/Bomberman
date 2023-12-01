enum TypeCell {
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR, BOMBERMAN, MOB
}

class Parser{
  TypeCell [][] _cells;
  
  String[] _line;
  
  char val;
  
  boolean isEmpty,isWall, isWallDestruct, isExit;
  
  Parser(String file){
    _line = loadStrings(file);
    _cells = new TypeCell[_line.length][_line[0].length()];
    for ( int i = 0; i < _line.length; i++ ) { 
      for ( int j = 0; j < _line[0].length(); j++ ) { 
        val = _line[i].charAt(j);
        isEmpty = val == 'v' || val == 'B' || val == 'M';
        isWall = val == 'x';
        isWallDestruct = val == 'o';
        isExit = val == 'S';
        if ( isEmpty ) {
          _cells[i][j] = TypeCell.EMPTY;
        }
        else if ( isWall ) {
          _cells[i][j] = TypeCell.WALL;
        }
        else if ( isWallDestruct ) {
          _cells[i][j] = TypeCell.DESTRUCTIBLE_WALL;
        }
        else {
          _cells[i][j] = TypeCell.EXIT_DOOR;
        }
      }
    }
  }
  
  void loadParser() {
    for ( int ligne = 0; ligne < _cells.length; ligne++ ) {
      for ( int colonne = 0; colonne < _cells[0].length; colonne++ ) {
        if (isEmpty){
          _cells[i][j]=TypeCell.EMPTY;
        }
        if (isWall){
          _cells[i][j]=TypeCell.WALL;
        }
        if (isWallDestruct){
          _cells[i][j]=TypeCell.DESTRUCTIBLE_WALL;
        }
        if (isExit){
          _cells[i][j]=TypeCell.EXIT_DOOR;
        }
        
        
      }
    }
    
  }

}
