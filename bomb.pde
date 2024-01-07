class Bomb {
  float _timeToExplode;
  float _timeExplosion;
  float _cellX, _cellY;
  float _cellS;
  int _explosionRadius;
  float Time;

  Sprites _sprite_bomb;

  PImage _sprite;
  int derFrameBomb = 0;
  int num_bomb = 1;
  int timeFrame = 300;

  PImage _sprite_M;
  PImage _sprite_L;
  PImage _sprite_R;
  PImage _sprite_U;
  PImage _sprite_D;
  int derFrameExplo = 0;
  int num_explosion_M = 1;
  int num_explosion_L = 1;
  int num_explosion_R = 1;
  int num_explosion_U = 1;
  int num_explosion_D = 1;
  int num_inverse_M = 1;
  int num_inverse_L = 1;
  int num_inverse_R = 1;
  int num_inverse_U = 1;
  int num_inverse_D = 1;
  int timeExplo = 300;

  PImage sprite_tiles = loadImage("data/img/tiles.png");

  boolean upWall = false;
  boolean downWall = false;
  boolean leftWall = false;
  boolean rightWall = false;

  Bomb(float CellX, float CellY, float CellS, boolean bonus) {
    _timeToExplode = 3000;
    _timeExplosion = _timeToExplode + 900;
    Time = millis();
    _cellX = CellX;
    _cellY = CellY;
    _cellS=CellS;
    if (bonus) {
      _explosionRadius = 2;
    } else {
      _explosionRadius = 1;
    }
    _sprite_bomb = new Sprites( sprite_tiles );
    _sprite =  _sprite_bomb.searchSpriteBoard().get(TypeSprites.DESTRUCTIBLE_WALL_SHADOW1);
  }

  void update(Board board, Hero hero) {
  }
  void drawIt() {
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

  PImage loadExplosion(String _name, int num_explosion, int num_inverse) {

    PImage sprite = null;

    if (millis() - derFrameExplo >= timeExplo) {
      derFrameBomb = millis();
      num_inverse++;
      num_explosion++;
    }

    if (num_inverse > 5) {
      num_explosion --;
    }

    TypeSprites name_explo = Enum.valueOf(TypeSprites.class, _name+num_explosion);

    if (num_explosion == 1)
      sprite =  _sprite_bomb.searchSpriteBoard().get(name_explo);
    else if (num_explosion == 2)
      sprite =  _sprite_bomb.searchSpriteBoard().get(name_explo);
    else if (num_explosion == 3)
      sprite =  _sprite_bomb.searchSpriteBoard().get(name_explo);
    else if (num_explosion == 4)
      sprite =  _sprite_bomb.searchSpriteBoard().get(name_explo);
    else if (num_explosion == 5)
      sprite =  _sprite_bomb.searchSpriteBoard().get(name_explo);

    return sprite;
  }

  void explosion_bomb_rad() {
    _sprite_M = loadExplosion( "EXPLO_MID", num_explosion_M, num_inverse_M);
    _sprite_L = loadExplosion( "EXPLO_LEFT", num_explosion_L, num_inverse_L);
    _sprite_U = loadExplosion( "EXPLO_UP", num_explosion_U, num_inverse_U);
    _sprite_R = loadExplosion( "EXPLO_RIGHT", num_explosion_R, num_inverse_R);
    _sprite_D = loadExplosion( "EXPLO_DOWN", num_explosion_D, num_inverse_D);

    imageMode(CENTER);
    image(_sprite_M, _cellX, _cellY, _cellS, _cellS);
    if (!leftWall) {
      imageMode(CENTER);
      image(_sprite_L, _cellX-_cellS, _cellY, _cellS, _cellS);
    }
    if (!upWall) {
      imageMode(CENTER);
      image(_sprite_U, _cellX, _cellY-_cellS, _cellS, _cellS);
    }
    if (!rightWall) {
      imageMode(CENTER);
      image(_sprite_R, _cellX+_cellS, _cellY, _cellS, _cellS);
    }
    if (!downWall) {
      imageMode(CENTER);
      image(_sprite_D, _cellX, _cellY+_cellS, _cellS, _cellS);
    }
  }
}
