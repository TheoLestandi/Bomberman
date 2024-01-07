class Bomb {
  float _timeToExplode;
  float _cellX, _cellY;
  float _cellS;
  int _explosionRadius;
  float Time;
  
  PImage _sprite;
  Sprites _sprite_bomb;
  int derFrameBomb = 0;
  int num_bomb = 1;
  int timeFrame = 300;

  PImage sprite_tiles = loadImage("data/img/tiles.png");
  
  boolean upWall = false;
  boolean downWall = false;
  boolean leftWall = false;
  boolean rightWall = false;

  Bomb(float CellX,float CellY,float CellS, boolean bonus) {
    _timeToExplode = 3000.0;
    Time = millis();
    _cellX = CellX;
    _cellY = CellY;
    _cellS=CellS;
    if (bonus){
      _explosionRadius = 2;
    }
    else {
      _explosionRadius = 1;
    }
    _sprite_bomb = new Sprites( sprite_tiles );
    _sprite =  _sprite_bomb.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL_SHADOW1);
  }

  void update(Board board, Hero hero) {
    
  }
  void drawIt(){
     loadBomb();
     imageMode(CENTER);
     image(_sprite, _cellX, _cellY, _cellS, _cellS);
  }
  
  void loadBomb() {
    if (millis() - derFrameBomb >= timeFrame) {
       derFrameBomb = millis();
       num_bomb++;
    }
    
    if (num_bomb > 4) {
      num_bomb = 1;
    }

    if (num_bomb == 1)
      _sprite =  _sprite_bomb.searchSpriteBoard().get(TypeSprites.BOMB1);
    else if (num_bomb == 2)
      _sprite =  _sprite_bomb.searchSpriteBoard().get(TypeSprites.BOMB2);
    else if (num_bomb == 3)
      _sprite =  _sprite_bomb.searchSpriteBoard().get(TypeSprites.BOMB3);
    else if (num_bomb == 4)
      _sprite =  _sprite_bomb.searchSpriteBoard().get(TypeSprites.BOMB2);
  }
  
  void explosion_bomb_rad() {
     imageMode(CENTER);
     image(_sprite, _cellX, _cellY, _cellS, _cellS);
    if (!leftWall) {
     imageMode(CENTER);
     image(_sprite, _cellX-_cellS, _cellY, _cellS, _cellS);
    }
    if (!upWall) {
     imageMode(CENTER);
     image(_sprite, _cellX, _cellY-_cellS, _cellS, _cellS);
    }
    if (!rightWall) {
     imageMode(CENTER);
     image(_sprite, _cellX+_cellS, _cellY, _cellS, _cellS);
    }
    if (!downWall) {
     imageMode(CENTER);
     image(_sprite, _cellX, _cellY+_cellS, _cellS, _cellS);
    }
  }
     
    
}
