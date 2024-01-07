 class Mob {
  // position on screen
  PVector [] possibilities = {new PVector(-1, 0), new PVector(0, -1), new PVector(0, 1), new PVector(1, 0)};
  int [] Mobpossibilities;
  PVector _position;
  PVector pos_sprite;
  PVector positionbis;
  
  // position on board
  int _cellX, _cellY;
  
  // display size
  float _size;
  float _sizeY;
  float _ecart;

  boolean _dead= false;
  
  int compteur=1;
  int chiffre[]=new int[4];
  PVector direction;
  TypeCell cell[][];
  
  
  Sprites allMobSprite;
  PImage sprite_mob = loadImage("data/img/characters.png");
  PImage _sprite_mob;
  
  int derFrameMob = 0;
  int num_mob = 1;
  int timeFrame = 50;
  
  Mob(PVector position_on_board, float size, float ecart,Board board) {
    _cellX = int(position_on_board.y);
    _cellY = int(position_on_board.x);
    _size = size;
    _sizeY = _size + _size / 2;
    _ecart = ecart;
    
    //pour chaque mob on etablit un liste de possibilité de direction
    _position = new PVector(position_on_board.y, position_on_board.x);
    pos_sprite = new PVector(_position.x * _size, _position.y * _size + _size * 2);
    Mobpossibilities= new int[0];
    positionbis=new PVector(_position.x* _size,_position.y* _size +_ecart);
    for (int i = 0 ; i < 4 ; i++){
      direction=new PVector (possibilities[i].x,possibilities[i].y);
      if(obst(direction,board,25)){
        Mobpossibilities=append(Mobpossibilities,i);
      }
    }
    allMobSprite = new Sprites(sprite_mob);
    _sprite_mob =  allMobSprite.searchSpriteMob().get(TypeSprites.MOB_DOWN1);
  }
  
  void move(Board board,float vitesse) {
     
     if(obst(direction,board,vitesse)){
       positionbis.x+=(direction.x*_size)/vitesse;
       positionbis.y+=(direction.y*_size)/vitesse;
       pos_sprite.x+=(direction.x*_size)/vitesse;
       pos_sprite.y+=(direction.y*_size)/vitesse;
     }
     else {
       for (int i=0;i<4;i++){
        direction=new PVector (possibilities[i].x,possibilities[i].y);
        if(obst(direction,board,20)){
          Mobpossibilities=append(Mobpossibilities,i);
        }
      }
     int chiffre=Mobpossibilities[int(random(0,Mobpossibilities.length))];
     direction=new PVector (possibilities[chiffre].x,possibilities[chiffre].y);
     }  
  } 
  
  //Verification si le mob ne touche pas de mur
  boolean obst(PVector direction, Board board, float vitesse){
    cell=board._parser._cells;
    if (direction.x==1 && direction.y==0){
      float cellRUX=positionbis.x+_size-1+direction.x*_size/vitesse;
      float cellRUY=positionbis.y;
      float cellRDX=positionbis.x+_size-1+direction.x*_size/vitesse;
      float cellRDY=positionbis.y+_size-1;
      if (cell[int(arrondi(cellRUY/_size-2.5))][int(arrondi(cellRUX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellRDY/_size-2.5))][int(arrondi(cellRDX/_size))]==TypeCell.EMPTY){
        return true;
      }
      else{
        return false;
      }
      
    }
    if (direction.x==-1 && direction.y==0){
      float cellLUX=positionbis.x+direction.x*_size/vitesse;
      float cellLUY=positionbis.y;
      float cellLDX=positionbis.x+direction.x*_size/vitesse;
      float cellLDY=positionbis.y+_size-1;
      if (cell[int(arrondi(cellLUY/_size-2.5))][int(arrondi(cellLUX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellLDY/_size-2.5))][int(arrondi(cellLDX/_size))]==TypeCell.EMPTY){
        return true;
      }
      else{
        return false;
      }
    }
    if (direction.x==0 && direction.y==1){
      float cellDLX=positionbis.x;
      float cellDLY=positionbis.y+_size-1+direction.y*_size/vitesse;
      float cellDRX=positionbis.x+_size-1;
      float cellDRY=positionbis.y+_size-1+direction.y*_size/vitesse;
      if (cell[int(arrondi(cellDLY/_size-2.5))][int(arrondi(cellDLX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellDRY/_size-2.5))][int(arrondi(cellDRX/_size))]==TypeCell.EMPTY){
        return true;
      }
      else{
        return false;
      }
    }
    if (direction.x==0 && direction.y==-1){
      float cellULX=positionbis.x;
      float cellULY=positionbis.y+direction.y*_size/vitesse;
      float cellURX=positionbis.x+_size-1;
      float cellURY=positionbis.y+direction.y*_size/vitesse;
      
      if (cell[int(arrondi(cellULY/_size-2.5))][int(arrondi(cellULX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellURY/_size-2.5))][int(arrondi(cellURX/_size))]==TypeCell.EMPTY){
        
        return true;
        
      }
      else{
        return false;
      }
    }
    return false;
    
  }
  
  //Fonction qui gère les arrondi
  float arrondi(float i){
    if (abs(i-round(i))<1e-4){
      return round(i);
    }
    return i;
  }
  
  void loadMob() {
    if (millis() - derFrameMob >= timeFrame) {
      derFrameMob = millis();
      num_mob++;
    }

    if (num_mob > 4) {
      num_mob = 1;
    }

    if (num_mob == 1)
      _sprite_mob =  allMobSprite.searchSpriteMob().get(TypeSprites.MOB_DOWN1);
    else if (num_mob == 2)
      _sprite_mob =  allMobSprite.searchSpriteMob().get(TypeSprites.MOB_DOWN2);
    else if (num_mob == 3)
      _sprite_mob =  allMobSprite.searchSpriteMob().get(TypeSprites.MOB_DOWN3);
    else if (num_mob == 4)
      _sprite_mob =  allMobSprite.searchSpriteMob().get(TypeSprites.MOB_DOWN4);
  }
  
  void drawIt() {
    loadMob();
    imageMode(CORNER);
    image(_sprite_mob, pos_sprite.x, pos_sprite.y, _size, _sizeY);
  }
}
