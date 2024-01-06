 class Board {
  PVector _drawPosition;
  PVector _drawSize;
  
  PImage [][] _tabB ;
  
  int _nbCellsX;
  int _nbCellsY;
  
  float _cellSize; // cells should be square
  
  Parser _parser;
  
  int der_tab = 0;
  
  boolean bomb;
  
  Board(PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY, String[] _line) {
    // On initialise chaque variables par les arguments mis en paramarètre de Board. 
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX;
    _nbCellsY = nbCellsY;
    
    // _cellSize correspond à la taille d'une cellule dans le "Board" donc on divise la taille du Board par le nombre de cellules. 
    _cellSize = drawSize.x / nbCellsX;
   
   
    _parser = new Parser(_line);
    bomb=false;
  }

  PVector getCellCenter(float i, float j) {
    PVector center = new PVector(i + _cellSize / 2,j + _cellSize / 2);
    // cellCenterX et cellCenterY correspondent à l'angle haut-gauche de la cellule avec les index i et j. 
    // Puis on ajoute la moitié de cellSize aux deux pour avoir le milieu de la cellule. 
    return center;
  }

  void drawIt() {
    _tabB = _parser.loadParser();
    for (int colonne = 0; colonne < _tabB[0].length; colonne++) {
      for (int ligne = 0; ligne < _tabB.length; ligne++) {
        float posx = colonne * _cellSize;
        float posy = ligne * _cellSize + _drawPosition.y;   
        PImage sprite = _tabB[ligne][colonne];
        imageMode(CORNER);
        if ( ligne == 0 ) 
          image(sprite, posx, posy + _cellSize/2, _cellSize, _cellSize/2);       
        else if ( ligne == _tabB.length - 1 ) 
          image(sprite, posx, posy, _cellSize, _cellSize/2);
        else 
          image(sprite, posx, posy, _cellSize, _cellSize);
      }
    }
  }

}  
