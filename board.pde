class Board {
  PVector _drawPosition;
  PVector _drawSize;
  
  int _nbCellsX;
  int _nbCellsY;
  
  float _cellSize; // cells should be square
  
  Parser _parser;

  Board(PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY) {
    // On initialise chaque variables par les arguments mis en paramarètre de Board. 
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX;
    _nbCellsY = nbCellsY;
    
    // _cellSize correspond à la taille d'une cellule dans le "Board" donc on divise la taille du Board par le nombre de cellules. 
    _cellSize = drawSize.x / nbCellsX;
    
    _parser = new Parser("levels/level1.txt");
    
  }

  PVector getCellCenter(float i, float j) {
    // cellCenterX et cellCenterY correspondent à l'angle haut-gauche de la cellule avec les index i et j. 
    // Puis on ajoute la moitié de cellSize aux deux pour avoir le milieu de la cellule. 
    float cellCenterX = i * _cellSize + _cellSize / 2;
    float cellCenterY = j * _cellSize + _cellSize / 2;
    return new PVector( cellCenterX, cellCenterY);
  }

  void drawIt() {
    _parser.loadParser(_cellSize);
  }
}
