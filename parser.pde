enum TypeCell {
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR, BOMBERMAN, MOB
}

class Parser{
  TypeCell [][] cell;
  
  String[] _line;
  
  char val;
  
  Parser(String file){
    _line = loadStrings(file);
  }
  
  void loadParser(){
    
    cell=new TypeCell[_line.length][_line[0].length()];
    
    for ( int i = 0; i < cell.length; i++ ) {
      for ( int j = 0; j < cell[i].length; j++ ) {
        val = _line[i].charAt(i);
        boolean isEmpty = val == 'v' || val == 'B' || val == 'M';
        boolean isWall = val == 'x';
        boolean isWallDestruct = val == 'o';
        boolean isExit = val == 'S';
        if (isEmpty){
          cell[i][j]=TypeCell.EMPTY;
        }
        if (isWall){
          cell[i][j]=TypeCell.WALL;
        }
        if (isWallDestruct){
          cell[i][j]=TypeCell.DESTRUCTIBLE_WALL;
        }
        if (isExit){
          cell[i][j]=TypeCell.EXIT_DOOR;
        }
        
        
      }
    }
    
  }

}
