class Parser{
  String[] _line;
  TypeCell [][] cell;

  Parser(String file){
    _line = loadStrings(file);
  }
  
  void loadParser(){


    cell=new TypeCell[_line.length][_line[0].length()];
    final boolean isEmpty = _line[i][j] == "v" || _line[i][j] == "B" || _line[i][j] == "M";
    final boolean isWall = ;
    final boolean isWallDestruct = ;
    final boolean isExit = ;
    for ( int i = 0; i < cell.length; i++ ) {
      for ( int j = 0; j < cell[i].length; j++ ) {
        
        
      }
    }
    
  }

}
