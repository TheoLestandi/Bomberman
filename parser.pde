enum TypeCell {
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR, BOMBERMAN, MOB
}

class Parser{
  
  Sprites _spriteB;
  
  TypeCell [][] _cells;  
  
  String[] _line;
  
  PImage [][] boardIm; 
  
  char val;
  
  boolean isEmpty,isWall, isWallDestruct, isExit, isBomberman;
  
  Parser(String[] _line){
    _spriteB = Sprites();
    HashMap<TypeSprites, PImage> spriteBoard = searchSpriteBoard();
    
    _cells = new TypeCell[_line.length][_line[0].length()];
    boardIm = new PImage[_cells.length][_cells[0].length];
    for ( int i = 0; i < _line.length; i++ ) { 
      for ( int j = 0; j < _line[0].length(); j++ ) { 
        val = _line[i].charAt(j);
        isEmpty = val == 'v' ||val=='B'|| val == 'M';
        isWall = val == 'x';
        isWallDestruct = val == 'o';
        isExit = val == 'S';
        //isBomberman = val == 'B';
        
        //On associe les TypeCell à des cellules 
        if ( isEmpty ) 
          _cells[i][j] = TypeCell.EMPTY;
        else if ( isWall )
          _cells[i][j] = TypeCell.WALL;
        else if ( isWallDestruct ) 
          _cells[i][j] = TypeCell.DESTRUCTIBLE_WALL;
        else if ( isExit) 
          _cells[i][j] = TypeCell.EXIT_DOOR;
        else 
          _cells[i][j] = TypeCell.BOMBERMAN;
      }
    }
  }
  
  void inversedSprite ( PImage sprite ) {
    sprite.loadPixels();
    for ( int y = 0; y < sprite.height; y++ ) {
      for ( int x = 0; x < sprite.width / 2; x++ ) {
        int start = x + y * sprite.width;
        int end = ( sprite.width - 1 ) - x + y * sprite.width;
        int temp = sprite.pixels[start];
        sprite.pixels[start] = sprite.pixels[end];
        sprite.pixels[end] = temp;
      }
    }
    sprite.updatePixels();
  }
  
  PImage[][] loadParser(PImage sprite_tiles) {
    
    for ( int colonne = 0; colonne < _cells[0].length; colonne++ ) {
      for ( int ligne = 0; ligne < _cells.length; ligne++ ) {
       
        // ici on regarde si le bloc au dessus du sprite est un mur ou un mur destructible puis en fonction de la condition adéquate, cela affiche le bon sprite.
        if ( _cells[ligne][colonne] == TypeCell.EMPTY ) {
          if ( _cells[ligne-1][colonne] == TypeCell.WALL ) {
            boardIm[ligne][colonne] = sprite_tiles.get(48, 80, 16, 16);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
            
          }
          else if ( _cells[ligne-1][colonne] == TypeCell.DESTRUCTIBLE_WALL ) {
            boardIm[ligne][colonne] = sprite_tiles.get(64, 96, 16, 16);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;      
          }
          else {
            boardIm[ligne][colonne] = sprite_tiles.get(48, 96, 16, 16);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
          
        }
        
        // ici on teste l'emplacement des murs puis on ajoute le bon sprite selon la condition.       
        if ( _cells[ligne][colonne] == TypeCell.WALL ) {
          if ( ligne != 0 && ligne != _cells.length - 1 && colonne != 0 && colonne != _cells[0].length - 1) {
            boardIm[ligne][colonne] = sprite_tiles.get(80, 96, 16, 16);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
          else if ( ligne == 0 && colonne != 0 && colonne != _cells[0].length - 1 ) {
            boardIm[ligne][colonne] = sprite_tiles.get(48, 64+8, 16, 8);
            //image( sprite_t, colonnebis, lignebis+cellSize/2, cellSize, cellSize/2);
          }
          else if ( ligne == 0 && colonne == 0 ) {
            boardIm[ligne][colonne] = sprite_tiles.get(16, 64+8, 16, 8);
            //image( sprite_t, colonnebis, lignebis+cellSize/2, cellSize, cellSize/2);
          }
          else if ( ligne == 0 && colonne == _cells[0].length - 1 ) {
            PImage sprite_t = sprite_tiles.get(16, 64+8, 16, 8);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
            //image(sprite_t, colonnebis, lignebis+cellSize/2, cellSize, cellSize/2);
          }
          else if ( ligne == _cells.length - 1 && colonne == 0 ) {
            boardIm[ligne][colonne] = sprite_tiles.get(16, 96, 16, 8);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize/2);
          }
          else if ( ligne == _cells.length - 1 && colonne == _cells[0].length - 1 ) {
            PImage sprite_t = sprite_tiles.get(16, 96, 16, 8);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
            //image(sprite_t, colonnebis, lignebis, cellSize, cellSize/2);
          }
          else if ( colonne == 0 && ligne != 0 && ligne != _cells.length - 1 ) {
            boardIm[ligne][colonne] = sprite_tiles.get(16, 80, 16, 16);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize);        
          }
          else if ( colonne == _cells[0].length - 1 && ligne != 0 && ligne != _cells.length - 1) {
            PImage sprite_t = sprite_tiles.get(16, 80, 16, 16);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
            //image(sprite_t, colonnebis, lignebis, cellSize, cellSize);
          }
          else {
            boardIm[ligne][colonne] = sprite_tiles.get(32, 96, 16, 8);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize/2) ;
          }
        }
        
        // ici c'est les sprites des mur qui sont destructibles ( 1 où si il y a un mur au dessus ducoup le sprite change et sinon l'autre sprite si il y a rien.
        if ( _cells[ligne][colonne] == TypeCell.DESTRUCTIBLE_WALL ) {
          if ( _cells[ligne-1][colonne] == TypeCell.WALL || _cells[ligne-1][colonne] == TypeCell.DESTRUCTIBLE_WALL ) {
            boardIm[ligne][colonne] = sprite_tiles.get(64, 80, 16, 16);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
          else {
            boardIm[ligne][colonne] = sprite_tiles.get(64, 64, 16, 16);
            //image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
          }
        }
        
        // ici c'est le sprite de la sortie.
        if ( _cells[ligne][colonne] == TypeCell.EXIT_DOOR ) {
          boardIm[ligne][colonne] = sprite_tiles.get(128, 48, 16, 16);
          //image( sprite_t, colonnebis, lignebis, cellSize, cellSize) ;
        }
        
       
      }
    }
    return boardIm;
  }

}
