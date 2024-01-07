class Hero {
  
  // position on screen
  PVector _position;
  
  // position on board
  float _cellX, _cellY;
  
  // display size
  float _cellS;  
  float _size;
  
  boolean movingUp = false;
  boolean movingDown = false;
  boolean movingLeft = false;
  boolean movingRight = false;
  
  // if hero was hit by a bomb
  boolean _wasHit;
  
  // sprite du hero
  PImage hero;
  
  int vitesse=20;
  TypeCell cell [][];

  Hero(PVector posH, float cellSize,  float ecart, String[] _line, PImage sprite) {
    _wasHit = false;
    _cellS = cellSize;
    _size = _cellS + _cellS / 2; 
    _position= new PVector(posH.x * _cellS, posH.y * _cellS/2 + ecart);
    
    _cellY = _position.y+_cellS/2;
    _cellX = _position.x;
    hero = sprite;
    
    
  }

  void move(Board board, PVector direction) {
    if (obst(direction,board)){
      _cellX += (direction.x * _cellS)/vitesse;
      _cellY += (direction.y * _cellS)/vitesse;
      _position.x += (direction.x * _cellS)/vitesse;
      _position.y += (direction.y * _cellS)/vitesse;
    }
    
    
  }
  
  boolean obst(PVector direction, Board board){
    cell=board._parser._cells;
    if (direction.x==1 && direction.y==0){
      float cellRUX=_cellX+_cellS-1+direction.x*_cellS/vitesse;
      float cellRUY=_cellY;
      float cellRDX=_cellX+_cellS-1+direction.x*_cellS/vitesse;
      float cellRDY=_cellY+_cellS-1;
      if ((cell[int(arrondi(cellRUY/_cellS-2.5))][int(arrondi(cellRUX/_cellS))]==TypeCell.EMPTY && cell[int(arrondi(cellRDY/_cellS-2.5))][int(arrondi(cellRDX/_cellS))]==TypeCell.EMPTY)
      || (cell[int(arrondi(cellRUY/_cellS-2.5))][int(arrondi(cellRUX/_cellS))]==TypeCell.EXIT_DOOR && cell[int(arrondi(cellRDY/_cellS-2.5))][int(arrondi(cellRDX/_cellS))]==TypeCell.EXIT_DOOR
      && boomExit)){
        return true;
      }
      else{
        return false;
      }    
    }
    
    if (direction.x==-1 && direction.y==0){
      float cellLUX=_cellX+direction.x*_cellS/vitesse;
      float cellLUY=_cellY;
      float cellLDX=_cellX+direction.x*_cellS/vitesse;
      float cellLDY=_cellY+_cellS-1;
      if ((cell[int(arrondi(cellLUY/_cellS-2.5))][int(arrondi(cellLUX/_cellS))]==TypeCell.EMPTY && cell[int(arrondi(cellLDY/_cellS-2.5))][int(arrondi(cellLDX/_cellS))]==TypeCell.EMPTY)
      || (cell[int(arrondi(cellLUY/_cellS-2.5))][int(arrondi(cellLUX/_cellS))]==TypeCell.EXIT_DOOR && cell[int(arrondi(cellLDY/_cellS-2.5))][int(arrondi(cellLDX/_cellS))]==TypeCell.EXIT_DOOR
      && boomExit)){
        return true;
      }
      else{
        return false;
      }
    }
    
    if (direction.x==0 && direction.y==1){
      float cellDLX=_cellX;
      float cellDLY=_cellY+_cellS-1+direction.y*_cellS/vitesse;
      float cellDRX=_cellX+_cellS-1;
      float cellDRY=_cellY+_cellS-1+direction.y*_cellS/vitesse;
      if ((cell[int(arrondi(cellDLY/_cellS-2.5))][int(arrondi(cellDLX/_cellS))]==TypeCell.EMPTY && cell[int(arrondi(cellDRY/_cellS-2.5))][int(arrondi(cellDRX/_cellS))]==TypeCell.EMPTY)
      || (cell[int(arrondi(cellDLY/_cellS-2.5))][int(arrondi(cellDLX/_cellS))]==TypeCell.EXIT_DOOR && cell[int(arrondi(cellDRY/_cellS-2.5))][int(arrondi(cellDRX/_cellS))]==TypeCell.EXIT_DOOR
      && boomExit)){
        return true;
      }
      else{
        return false;
      }
    }
    
    if (direction.x==0 && direction.y==-1){
      float cellULX=_cellX;
      float cellULY=_cellY+direction.y*_cellS/vitesse;
      float cellURX=_cellX+_cellS-1;
      float cellURY=_cellY+direction.y*_cellS/vitesse;
      
      if ((cell[int(arrondi(cellULY/_cellS-2.5))][int(arrondi(cellULX/_cellS))]==TypeCell.EMPTY && cell[int(arrondi(cellURY/_cellS-2.5))][int(arrondi(cellURX/_cellS))]==TypeCell.EMPTY)
      || (cell[int(arrondi(cellULY/_cellS-2.5))][int(arrondi(cellULX/_cellS))]==TypeCell.EXIT_DOOR && cell[int(arrondi(cellURY/_cellS-2.5))][int(arrondi(cellURX/_cellS))]==TypeCell.EXIT_DOOR
      && boomExit)){
        return true;
      }
      else{
        return false;
      }
    }
    return false;    
  }
  
  boolean bomb_wall(){
    return true;
  }
    
  
  float arrondi(float i){
    if (abs(i-round(i))<1e-4){
      return round(i);
    }
    return i;
  }
 
  void update(Board board) {
  }
  
  void drawIt(PImage hero) { 
    imageMode(CORNER);
    image(hero, _position.x, _position.y, _cellS, _size);
  }
  
}
