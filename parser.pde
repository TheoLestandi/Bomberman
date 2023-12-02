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
    
    for ( int colonne = 0; colonne < _cells[0].length; colonne++ ) {
      for ( int ligne = 0; ligne < _cells.length; ligne++ ) {
        
        float lignebis = ( 2 + ligne ) * cellSize;
        float colonnebis = colonne * cellSize;
        //game._board.getCellCenter(lignebis,colonnebis);
        
        if ( _cells[ligne][colonne] == TypeCell.EMPTY ) {
          if ( _cells[ligne-1][colonne] == TypeCell.WALL ) {
            PImage sprite_t = sprite_tiles.get(48, 80, 16, 16);
            image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
          else if ( _cells[ligne-1][colonne] == TypeCell.DESTRUCTIBLE_WALL ) {
            PImage sprite_t = sprite_tiles.get(64, 96, 16, 16);
            image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;      
          }
          else {
            PImage sprite_t = sprite_tiles.get(48, 96, 16, 16);
            image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
        }
        
        if ( _cells[ligne][colonne] == TypeCell.WALL ) {
          if ( ligne != 0 && ligne != _cells.length - 1 && colonne != 0 && colonne != _cells[0].length - 1) {
            PImage sprite_t = sprite_tiles.get(80, 96, 16, 16);
            image( sprite_t, colonne * cellSize, lignebis, cellSize, cellSize) ;
          }
          else {
            PImage sprite_t = sprite_tiles.get(32, 96, 16, 16);
            image( sprite_t, colonne * cellSize, lignebis, cellSize, cellSize) ;
          }
        }
        
        if ( _cells[ligne][colonne] == TypeCell.DESTRUCTIBLE_WALL ) {
          if ( _cells[ligne-1][colonne] == TypeCell.WALL ) {
            PImage sprite_t = sprite_tiles.get(64, 80, 16, 16);
            image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
          else {
            PImage sprite_t = sprite_tiles.get(64, 64, 16, 16);
            image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
        }
        
        if ( _cells[ligne][colonne] == TypeCell.EXIT_DOOR ) {
          PImage sprite_t = sprite_tiles.get(128, 48, 16, 16);
          image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
        }
      }
    }
  }

}
