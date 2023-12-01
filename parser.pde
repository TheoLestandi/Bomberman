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
  
  void loadParser( float cellSize ) {
    PImage sprite_tiles = loadImage("data/img/tiles.png");
    //PImage sprite_characters = loadImage("data/img/characters.png");
    for ( int ligne = 0; ligne < _cells[0].length; ligne++ ) {
      for ( int colonne = 0; colonne < _cells.length; colonne++ ) {
        if ( _cells[colonne][ligne] == TypeCell.EMPTY ) {
          image( sprite_tiles.get(48, 96, 16, 16), ligne * cellSize, colonne * cellSize) ;
        }
        if ( _cells[colonne][ligne] == TypeCell.WALL ) {
          image( sprite_tiles.get(32, 96, 16, 16), ligne * cellSize, colonne * cellSize) ;
        }
        if ( _cells[colonne][ligne] == TypeCell.DESTRUCTIBLE_WALL ) {
          image( sprite_tiles.get(64, 80, 16, 16), ligne * cellSize, colonne * cellSize) ;
        }
        if ( _cells[colonne][ligne] == TypeCell.EXIT_DOOR ) {
          image( sprite_tiles.get(128, 48, 16, 16), ligne * cellSize, colonne * cellSize) ;
        }
        
      }
    }
    
  }

}
