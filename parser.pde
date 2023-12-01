enum TypeCell {
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR, BOMBERMAN, MOB
}

class Parser{
  TypeCell [][] _cells;  
  
  String[] _line;
  
  char val;
  
  boolean isEmpty,isWall, isWallDestruct, isExit;
  //Board board=game._board;
  
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
        if ( isEmpty ) 
          _cells[i][j] = TypeCell.EMPTY;
        else if ( isWall )
          _cells[i][j] = TypeCell.WALL;
        else if ( isWallDestruct ) 
          _cells[i][j] = TypeCell.DESTRUCTIBLE_WALL;
        else
          _cells[i][j] = TypeCell.EXIT_DOOR;
      }
    }
  }
  
  void loadParser( float cellSize ) {
    PImage sprite_tiles = loadImage("data/img/tiles.png");
    //PImage sprite_characters = loadImage("data/img/characters.png");
    for ( int ligne = 0; ligne < _cells[0].length; ligne++ ) {
      for ( int colonne = 0; colonne < _cells.length; colonne++ ) {
        float colonnebis=(2+colonne)*cellSize;
        float lignebis=ligne*cellSize;
        //game._board.getCellCenter(lignebis,colonnebis);
        if ( _cells[colonne][ligne] == TypeCell.EMPTY ) {
          PImage sprite_t = sprite_tiles.get(48, 96, 16, 16);
          image( sprite_t, lignebis, colonnebis, cellSize, cellSize) ;
        }
        if ( _cells[colonne][ligne] == TypeCell.WALL ) {
          if ( colonne != 0 && colonne != _cells.length - 1 && ligne != 0 && ligne != _cells[0].length - 1) {
            PImage sprite_t = sprite_tiles.get(80, 96, 16, 16);
            image( sprite_t, ligne * cellSize, colonnebis, cellSize, cellSize) ;
          }
          else {
            PImage sprite_t = sprite_tiles.get(32, 96, 16, 16);
            image( sprite_t, ligne * cellSize, colonnebis, cellSize, cellSize) ;
          }
        }
        if ( _cells[colonne][ligne] == TypeCell.DESTRUCTIBLE_WALL ) {
          PImage sprite_t = sprite_tiles.get(64, 80, 16, 16);
          image( sprite_t, lignebis, colonnebis, cellSize, cellSize) ;
        }
        if ( _cells[colonne][ligne] == TypeCell.EXIT_DOOR ) {
          PImage sprite_t = sprite_tiles.get(128, 48, 16, 16);
          image( sprite_t, lignebis, colonnebis, cellSize, cellSize) ;
        }
      }
    }
    
  }

}
