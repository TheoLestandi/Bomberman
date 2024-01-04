class Bomb {
  float _timeToExplode;
  float _cellX, _cellY;
  float _cellS;
  int _explosionRadius;


  Bomb(float CellX,float CellY,float CellS, boolean bonus) {
    _timeToExplode = 3000.0;
    _cellX = CellX;
    _cellY = CellY;
    _cellS=CellS;
    if (bonus){
      _explosionRadius = 2;
    }
    else {
      _explosionRadius = 1;
    }
  }

  void update(Board board, Hero hero) {
  }
  void drawIt(){
    fill(0, 0, 255);
    rect(_cellX, _cellY, _cellS, _cellS);
  }
}
