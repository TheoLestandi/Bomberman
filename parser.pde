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
  
  PImage sprite_tiles = loadImage("data/img/tiles.png");
  
  Parser(String[] _line){
    
    _spriteB = new Sprites(sprite_tiles);
    
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
  
  PImage[][] loadParser() {
    
    for ( int colonne = 0; colonne < _cells[0].length; colonne++ ) {
      for ( int ligne = 0; ligne < _cells.length; ligne++ ) {
        
        // Conditions pour "EMPTY".
        boolean isEMPTY = _cells[ligne][colonne] == TypeCell.EMPTY;
        boolean isEMPTY_UNDER_WALL = ligne != 0 && _cells[ligne-1][colonne] == TypeCell.WALL;
        boolean isEMPTY_UNDER_DESTRUCTIBLE_WALL = ligne != 0 && _cells[ligne-1][colonne] == TypeCell.DESTRUCTIBLE_WALL;
        
        // Conditions pour "WALL".
        boolean isWALL = _cells[ligne][colonne] == TypeCell.WALL;
        boolean isWALL_INSIDE_BOARD = ligne != 0 && ligne != _cells.length - 1 && colonne != 0 && colonne != _cells[0].length - 1;
        boolean isWALL_UP = ligne == 0 && colonne != 0 && colonne != _cells[0].length - 1;
        boolean isWALL_CORNER_LEFT_UP = ligne == 0 && colonne == 0;
        boolean isWALL_CORNER_RIGHT_UP = ligne == 0 && colonne == _cells[0].length - 1; 
        boolean isWALL_CORNER_LEFT_DOWN = ligne == _cells.length - 1 && colonne == 0;
        boolean isWALL_CORNER_RIGHT_DOWN = ligne == _cells.length - 1 && colonne == _cells[0].length - 1;
        boolean isWALL_LEFT = colonne == 0 && ligne != 0 && ligne != _cells.length - 1;
        boolean isWALL_RIGHT = colonne == _cells[0].length - 1 && ligne != 0 && ligne != _cells.length - 1;
       
        // Conditions pour "DESTRUCTIBLE_WALL".       
        boolean isDESTRUCTIBLE_WALL = _cells[ligne][colonne] == TypeCell.DESTRUCTIBLE_WALL;
        boolean isDESTRUCTIBLE_WALL_UNDER_EITHER_WALL = ligne != 0 && _cells[ligne-1][colonne] == TypeCell.WALL 
        || ligne != 0 && _cells[ligne-1][colonne] == TypeCell.DESTRUCTIBLE_WALL;
        
        // Conditions pour "EXIT_DOOR".
        boolean isEXIT_DOOR = _cells[ligne][colonne] == TypeCell.EXIT_DOOR;
        
        // ici on regarde si le bloc au dessus du sprite est un mur ou un mur destructible puis en fonction de la condition adéquate, cela affiche le bon sprite.
        if ( isEMPTY ) {
          if ( isEMPTY_UNDER_WALL ) {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.EMPTY_WALL);
          }
          else if ( isEMPTY_UNDER_DESTRUCTIBLE_WALL ) {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.EMPTY_DESTRUCTIBLE); 
          }
          else { 
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.EMPTY);
          }
        }
        
        // ici on teste l'emplacement des murs puis on ajoute le bon sprite selon la condition.       
        if ( isWALL ) {
          if ( isWALL_INSIDE_BOARD ) {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.WALL);
          }
          else if ( isWALL_UP ) {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.WALL_UP);
          }
          else if ( isWALL_CORNER_LEFT_UP ) {
            boardIm[ligne][colonne] =_spriteB.searchSpriteBoard().get(TypeSprites.WALL_CORNER_UP_LEFT);
          }
          else if ( isWALL_CORNER_RIGHT_UP ) {
            PImage sprite_t = _spriteB.searchSpriteBoard().get(TypeSprites.WALL_CORNER_UP_RIGHT);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
          }
          else if ( isWALL_CORNER_LEFT_DOWN ) {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.WALL_CORNER_DOWN_LEFT);
          }
          else if ( isWALL_CORNER_RIGHT_DOWN) {
            PImage sprite_t = _spriteB.searchSpriteBoard().get(TypeSprites.WALL_CORNER_DOWN_RIGHT);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
          }
          else if ( isWALL_LEFT ) {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.WALL_LEFT);      
          }
          else if ( isWALL_RIGHT ) {
            PImage sprite_t = _spriteB.searchSpriteBoard().get(TypeSprites.WALL_RIGHT);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
          }
          else {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.WALL_DOWN);
          }
        }
        
        // ici c'est les sprites des mur qui sont destructibles ( 1 où si il y a un mur au dessus ducoup le sprite change et sinon l'autre sprite si il y a rien.
        if ( isDESTRUCTIBLE_WALL ) {
          if ( isDESTRUCTIBLE_WALL_UNDER_EITHER_WALL  ) {
            boardIm[ligne][colonne] =  _spriteB.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL_SHADOW1);
          }
          else {
            boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL1);
          }
        }
        
        // ici c'est le sprite de la sortie.
        if ( isEXIT_DOOR ) {
          boardIm[ligne][colonne] = _spriteB.searchSpriteBoard().get(TypeSprites.EXIT_DOOR1);
        }
        
      }
    }
    return boardIm;
  }

}
