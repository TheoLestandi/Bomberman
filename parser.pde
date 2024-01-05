enum TypeCell {
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR, BOMBERMAN, NO_BBM, MOB
}

class Parser{
  
  Sprites _spriteBoard;
  Sprites _spriteHeroAndMob;
  
  TypeCell [][] _cells;  
  TypeCell [][] _cells_hero;  

  
  PVector spawnHero;
  PVector[] spawnMob;
  int numMob = 0;
  
  String[] _line;
  
  PImage [][] boardIm, heroIm; 
  
  char val;
  
  boolean isEmpty, isWall, isWallDestruct, isExit, isBomberman, isMob;
  
  PImage sprite_tiles = loadImage("data/img/tiles.png");
  
  int num_sprite_exit = 1;
  int num_sprite_destructWall = 1;
  
  int derFrameDestructWall = 0;
  int derFrameExit = 0;
  int timeFrame = 100;
  
  Parser(String[] _line){
    
    _spriteBoard = new Sprites( sprite_tiles );
    //_spriteHeroAndMob = new Sprites( sprite_hero_and_mob );
    
    _cells = new TypeCell[_line.length][_line[0].length()];
    _cells_hero = new TypeCell[_line.length][_line[0].length()];
    boardIm = new PImage[_cells.length][_cells[0].length];
    heroIm = new PImage[_cells.length][_cells[0].length];
    spawnMob = new PVector[_cells.length*_cells[0].length];
    
    for ( int i = 0; i < _line.length; i++ ) { 
      for ( int j = 0; j < _line[0].length(); j++ ) { 
        val = _line[i].charAt(j);
        isEmpty = val == 'v';
        isWall = val == 'x';
        isWallDestruct = val == 'o';
        isExit = val == 'S';
        isBomberman = val == 'B';
        isMob = val == 'M';
        
        //On associe les TypeCell à des cellules 
        if ( isEmpty ) 
          _cells[i][j] = TypeCell.EMPTY;
        else if ( isWall )
          _cells[i][j] = TypeCell.WALL;
        else if ( isWallDestruct ) 
          _cells[i][j] = TypeCell.DESTRUCTIBLE_WALL;
        else if ( isExit ) 
          _cells[i][j] = TypeCell.EXIT_DOOR;
        else if ( isBomberman ){
          spawnHero = new PVector( i, j);
          _cells_hero[i][j] = TypeCell.BOMBERMAN;
          _cells[i][j] = TypeCell.EMPTY;
        }
        else if ( isMob ){
          spawnMob[numMob]= new PVector(i, j);
          _cells_hero[i][j] = TypeCell.MOB;  
          _cells[i][j] = TypeCell.EMPTY; 
          numMob += 1;
        }
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
  
  PImage[][] loadParser( ) {
    
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
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.EMPTY_WALL);
          }
          else if ( isEMPTY_UNDER_DESTRUCTIBLE_WALL ) {
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.EMPTY_DESTRUCTIBLE); 
          }
          else { 
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.EMPTY);
          }
        }
        
        // ici on teste l'emplacement des murs puis on ajoute le bon sprite selon la condition.       
        if ( isWALL ) {
          if ( isWALL_INSIDE_BOARD ) {
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL);
          }
          else if ( isWALL_UP ) {
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_UP);
          }
          else if ( isWALL_CORNER_LEFT_UP ) {
            boardIm[ligne][colonne] =_spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_CORNER_UP_LEFT);
          }
          else if ( isWALL_CORNER_RIGHT_UP ) {
            PImage sprite_t = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_CORNER_UP_RIGHT);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
          }
          else if ( isWALL_CORNER_LEFT_DOWN ) {
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_CORNER_DOWN_LEFT);
          }
          else if ( isWALL_CORNER_RIGHT_DOWN) {
            PImage sprite_t = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_CORNER_DOWN_RIGHT);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
          }
          else if ( isWALL_LEFT ) {
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_LEFT);      
          }
          else if ( isWALL_RIGHT ) {
            PImage sprite_t = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_RIGHT);
            inversedSprite(sprite_t);
            boardIm[ligne][colonne] = sprite_t;
          }
          else {
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.WALL_DOWN);
          }
        }
        
        // ici c'est les sprites des mur qui sont destructibles ( 1 où si il y a un mur au dessus ducoup le sprite change et sinon l'autre sprite si il y a rien.
        if ( isDESTRUCTIBLE_WALL ) {
          
           if (millis() - derFrameDestructWall >= timeFrame) {
             derFrameDestructWall = millis();
             num_sprite_destructWall++;
           }
          
          if (num_sprite_destructWall > 4) {
            num_sprite_destructWall = 1;
          }

          if ( isDESTRUCTIBLE_WALL_UNDER_EITHER_WALL  ) {
            if (num_sprite_destructWall == 1)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL_SHADOW1);
            else if (num_sprite_destructWall == 2)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL_SHADOW2);
            else if (num_sprite_destructWall == 3)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL_SHADOW3);
            else if (num_sprite_destructWall == 4)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL_SHADOW4);
          }
          else {
            if (num_sprite_destructWall == 1)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL1);
            else if (num_sprite_destructWall == 2)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL2);
            else if (num_sprite_destructWall == 3)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL3);
            else if (num_sprite_destructWall == 4)
              boardIm[ligne][colonne] =  _spriteBoard.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL4);       
          }
        }
        
        // ici c'est le sprite de la sortie.
        if ( isEXIT_DOOR ) {   
          
          if (millis() - derFrameExit >= timeFrame) {
             derFrameExit = millis();
             num_sprite_exit++;
          }
          
          if (num_sprite_exit > 2) {
            num_sprite_exit = 1;
          }
          
          if (num_sprite_exit == 1) 
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.EXIT_DOOR1);
          else 
            boardIm[ligne][colonne] = _spriteBoard.searchSpriteBoard().get(TypeSprites.EXIT_DOOR2);
        }
      }
    }
    return boardIm;
  }
  /*
  PImage[][] loadHero() {
    for ( int colonne = 0; colonne < _cells_hero[0].length; colonne++ ) {
      for ( int ligne = 0; ligne < _cells_hero.length; ligne++ ) {
                
        boolean isBOMBERMAN = _cells_hero[ligne][colonne] == TypeCell.BOMBERMAN;
        boolean isNO_BBM = _cells_hero[ligne][colonne] == TypeCell.NO_BBM;
        
        if ( isBOMBERMAN ) {
          heroIm[ligne][colonne] = _spriteHeroAndMob.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);
        }
        else if ( isNO_BBM )  {
          heroIm[ligne][colonne] = _spriteHeroAndMob.searchSpriteHero().get(TypeSprites.NO_BBM);
        }
      }
    }
  return heroIm;
  }*/

}
