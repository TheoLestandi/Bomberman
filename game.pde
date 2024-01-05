class Game {
  String[] _line = loadStrings("levels/level1.txt");
  String [] _line2 = new String[_line.length-1];

  Board _board;
  Hero _hero;
  Bomb bomb;
  Mob[] mob;

  String _levelName;

  int _numberCellsX;
  int _numberCellsY;
  float _ecart;
  float _sizeCell;
  float _size_inter_board = width/160;
  float _size_txt = width/16;

  PVector _posTab;
  PVector _sizeTab;


  Sprites sprite_hero;
  PImage _sprite_hero ;
  PImage sprite_hero_and_mob = loadImage("data/img/characters.png");

  TypeCell _cell[][];
  float _cellX, _cellY;

  boolean UpLeft, UpRight, DownLeft, DownRight;
  
  float bombPlacementCellX;
  float bombPlacementCellY;
  
  PVector positionHero;
  PVector[] positionMob;
  int nbMob;

  Game() {
    // Nom du niveau.
    _levelName = _line[0];

    // Données pour le "board".
    arrayCopy(_line, 1, _line2, 0, _line2.length);
    _numberCellsX = _line2[0].length();
    _numberCellsY = _line2.length - 1;
    _sizeCell = float(width)/ _numberCellsX;
    _ecart = 2*_sizeCell;
    _posTab = new PVector(0, _ecart);
    _sizeTab = new PVector(width, height - _posTab.y);
    _board = new Board(_posTab, _sizeTab, _numberCellsX, _numberCellsY, _line2);

    // Données pour le "hero".
    positionHero = _board._parser.spawnHero;
    sprite_hero = new Sprites(sprite_hero_and_mob );
    _sprite_hero = sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);
    _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
    PImage sprite_hero_and_mob = loadImage("data/img/characters.png");
    sprite_hero = new Sprites(sprite_hero_and_mob );
    _sprite_hero = sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);
    
    // Données pour les mob.
    positionMob = _board._parser.spawnMob;
    nbMob = _board._parser.numMob;
    mob = new Mob[nbMob];
    for ( int numMob = 0; numMob < nbMob; numMob++ ) {
      println(positionMob[numMob]);
      mob[numMob] = new Mob( positionMob[numMob],_sizeCell, _ecart); 
    }


    _cell=_board._parser._cells;
  }


  void update() {
  }

  void drawIt() {
    // Fond d'écran quand on joue.
    background(orange);
    strokeWeight(_size_inter_board);
    stroke(inter_board);
    line(0, _posTab.y + _sizeCell/2, width, _posTab.y + _sizeCell/2);
    
    strokeWeight(_size_inter_board * 2);
    stroke(inter_board);
    line(0, height - _sizeCell/2, width, height - _sizeCell/2);

    // Niveau:
    textAlign(CENTER, CENTER);
    fill(black);
    textSize(_size_txt);
    text(_levelName, width/6, _posTab.y/2);

    // Affichage du "board" et du "hero".
    
    _board.drawIt();
    if (bomb != null && millis()-bomb.Time>3000){
      explosion(bombPlacementCellX, bombPlacementCellY, _cell, bomb._explosionRadius);
      bomb=null;
    }
    if (bomb != null) {
      bomb.drawIt();
    }
    
    _hero.drawIt(_sprite_hero);
    _cellX=_hero._cellX;
    _cellY=_hero._cellY;
    
    for ( int numMob = 0; numMob < nbMob; numMob++ ) {
      mob[numMob].drawIt();
    }
    
  }

  void handleKey(int k) {
    if (k=='z'||keyCode==UP||k=='Z') {
      PVector position = new PVector( 0, -1 );
      _sprite_hero= sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_UP1);
      if (obstacle(_cellX, _cellY, position, _sizeCell, _cell)) {
        _hero.move(_board, position);
      }
      _hero.drawIt(_sprite_hero);
    }
    if (k == 'q' || keyCode == LEFT) {
      PVector position = new PVector( -1, 0 );
      _sprite_hero= sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_LEFT1);
      if (obstacle(_cellX, _cellY, position, _sizeCell, _cell)) {
        _hero.move(_board, position);
      }
      _hero.drawIt(_sprite_hero);
    }
    if (k == 's' || keyCode == DOWN) {
      PVector position = new PVector( 0, 1 );
      _sprite_hero=sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);
      if (obstacle(_cellX, _cellY, position, _sizeCell, _cell)) {
        _hero.move(_board, position);
      }
      _hero.drawIt(_sprite_hero);
    }
    if (k == 'd' || keyCode == RIGHT) {
      PVector position = new PVector( 1, 0 );
      _sprite_hero =sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_RIGHT1);
      if (obstacle(_cellX, _cellY, position, _sizeCell, _cell)) {
        _hero.move(_board, position);
      }
      _hero.drawIt(_sprite_hero);
    }
    if (k == ' ' && bomb==null){
      float cellX=floor((_cellX+_sizeCell/2)/_sizeCell);
      float cellY=floor((_cellY+_sizeCell/2)/_sizeCell-2.5);
      PVector centerCell= _board.getCellCenter(cellX*_sizeCell, cellY*_sizeCell+2.5*_sizeCell);
      bomb = new Bomb(centerCell.x,centerCell.y,_sizeCell,false);
      bombPlacementCellX = cellX; // Enregistrez les coordonnées de la pose de la bombe
      bombPlacementCellY = cellY;
      //bomb.drawIt();
    }
  }
  
  void explosion(float cellX,float cellY,TypeCell [][] cell, int rad){
    if (cell[int(cellY+rad)][int(cellX)]==TypeCell.DESTRUCTIBLE_WALL){
      cell[int(cellY+rad)][int(cellX)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY-rad)][int(cellX)]==TypeCell.DESTRUCTIBLE_WALL){
      cell[int(cellY-rad)][int(cellX)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY)][int(cellX+rad)]==TypeCell.DESTRUCTIBLE_WALL){
      cell[int(cellY)][int(cellX+1)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY)][int(cellX-rad)]==TypeCell.DESTRUCTIBLE_WALL){
      cell[int(cellY)][int(cellX-rad)]=TypeCell.EMPTY;
    }
    
  }
  boolean obstacle(float cellX, float cellY, PVector direction, float CellSize, TypeCell [][] cell) {
    
    PVector BUpLeft = new PVector(cellX+direction.x*CellSize/4,cellY+direction.y*CellSize/4);
    PVector BUpRight = new PVector(cellX+CellSize+direction.x*CellSize/4,cellY+direction.y*CellSize/4);
    PVector BDownLeft = new PVector(cellX+direction.x*CellSize/4,cellY+CellSize+direction.y*CellSize/4);
    PVector BDownRight = new PVector(cellX+CellSize+direction.x*CellSize/4,cellY+CellSize+direction.y*CellSize/4);

    
    PVector xyUpLeft= new PVector((BUpLeft.y/CellSize)-2.5,(BUpLeft.x/CellSize));
    PVector xyUpRight= new PVector((BUpRight.y/CellSize)-2.5,(BUpRight.x/CellSize));
    PVector xyDownLeft= new PVector((BDownLeft.y/CellSize)-2.5,(BDownLeft.x/CellSize));
    PVector xyDownRight= new PVector((BDownRight.y/CellSize)-2.5,(BDownRight.x/CellSize));
    
    
    if(abs(xyUpLeft.x-round(xyUpLeft.x))<1e-4){
      xyUpLeft.x = ceil(xyUpLeft.x);
    }
    if(abs(xyUpLeft.y-round(xyUpLeft.y))<1e-4){
      xyUpLeft.y = ceil(xyUpLeft.y);
    }
    if(abs(xyUpRight.x-round(xyUpRight.x))<1e-4){
      xyUpRight.x = ceil(xyUpRight.x);
    }
    if(abs(xyUpRight.y-round(xyUpRight.y))<1e-4){
      xyUpRight.y = ceil(xyUpRight.y);
    }
    if(abs(xyDownLeft.x-round(xyDownLeft.x))<1e-4){
      xyDownLeft.x = ceil(xyDownLeft.x);
    }
    if(abs(xyDownLeft.y-round(xyDownLeft.y))<1e-4){
      xyDownLeft.y = ceil(xyDownLeft.y);
    }
    if(abs(xyDownRight.x-round(xyDownRight.x))<1e-4){
      xyDownRight.x = ceil(xyDownRight.x);
    }
    if(abs(xyDownRight.y-round(xyDownRight.y))<1e-4){
      xyDownRight.y = ceil(xyDownRight.y);
    }
    
    
    
    if (xyDownLeft.x%1==0){//||abs(xyDownLeft.x-int(xyDownLeft.x+1))<1e-4){
      xyDownLeft.x--;
      
    }
    if (xyDownRight.x%1==0){//||abs(xyDownRight.x-int(xyDownRight.x+1))<1e-4){
      xyDownRight.x--;
      
    }
    if (xyDownRight.y%1==0){//||abs(xyDownRight.y-int(xyDownRight.y+1))<1e-4){
      xyDownRight.y--;
     
    }
    if (xyUpRight.y%1==0){//||abs(xyUpRight.y-int(xyUpRight.y+1))<1e-4){
      xyUpRight.y--;
     
    }
    if (xyUpLeft.x>=0 && xyUpLeft.x<1){
      xyUpLeft.x=1.0;
      return false;
    }
    if (xyUpLeft.y>=0 && xyUpLeft.y<1){
      xyUpLeft.y=1.0;
      return false;
    }
    if (xyDownLeft.y>=0 && xyDownLeft.y<1){
      xyDownLeft.y=1.0;
      return false;
    }
    
    if (cell[floor(xyUpLeft.x)][floor(xyUpLeft.y)]!=TypeCell.EMPTY){
      xyDownRight.x=xyUpLeft.x;
      xyDownRight.y=xyUpLeft.y;
    }
    if (cell[floor(xyUpRight.x)][floor(xyUpRight.y)]!=TypeCell.EMPTY){
      xyDownLeft.x=xyUpRight.x;
      xyDownLeft.y=xyUpRight.y;
    }
    if (cell[floor(xyDownLeft.x)][floor(xyDownLeft.y)]!=TypeCell.EMPTY){
      xyUpRight.x=xyDownLeft.x;
      xyUpRight.y=xyDownLeft.y;
    }
    if (cell[floor(xyDownRight.x)][floor(xyDownRight.y)]!=TypeCell.EMPTY){
      xyUpLeft.x=xyDownRight.x;
      xyUpLeft.y=xyDownRight.y;
    }
    
    if (cell[floor(xyUpLeft.x)][floor(xyUpLeft.y)]!=TypeCell.EMPTY){
      xyDownRight.x=xyUpLeft.x;
      xyDownRight.y=xyUpLeft.y;
      return false;
    }
    if (cell[floor(xyUpRight.x)][floor(xyUpRight.y)]!=TypeCell.EMPTY){
      xyDownLeft.x=xyUpRight.x;
      xyDownLeft.y=xyUpRight.y;
      return false;
    }
    if (cell[floor(xyDownLeft.x)][floor(xyDownLeft.y)]!=TypeCell.EMPTY){
      xyUpRight.x=xyDownLeft.x;
      xyUpRight.y=xyDownLeft.y;
      return false;
    }
    if (cell[floor(xyDownRight.x)][floor(xyDownRight.y)]!=TypeCell.EMPTY){
      xyUpLeft.x=xyDownRight.x;
      xyUpLeft.y=xyDownRight.y;
      return false;
    }
    else {
      return true;
    }
    
    
    
    
  } 
}
