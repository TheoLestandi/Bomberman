class Game {
  String[] _line = loadStrings("levels/level1.txt");
  String [] _line2 = new String[_line.length-1];

  Board _board;
  Hero _hero;

  String _levelName;

  int _numberCellsX;
  int _numberCellsY;

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
  

  Game() {
    // Nom du niveau.
    _levelName = _line[0];

    // Données pour le "board".
    arrayCopy(_line, 1, _line2, 0, _line2.length);
    _numberCellsX = _line2[0].length();
    _numberCellsY = _line2.length - 1;
    _sizeCell = float(width)/ _numberCellsX;
    _posTab = new PVector(0, 2.5 * _sizeCell);
    _sizeTab = new PVector(width, height - _posTab.y);
    _board = new Board(_posTab, _sizeTab, _numberCellsX, _numberCellsY, _line2);

    // Données pour le "hero".
    sprite_hero = new Sprites(sprite_hero_and_mob );
    _sprite_hero = sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);
    _hero = new Hero(_board._cellSize, _line2, _sprite_hero );
    PImage sprite_hero_and_mob = loadImage("data/img/characters.png");
    sprite_hero = new Sprites(sprite_hero_and_mob );
    _sprite_hero = sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);

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

    // Niveau:
    textAlign(CENTER, CENTER);
    fill(black);
    textSize(_size_txt);
    text(_levelName, width/6, _posTab.y/2);

    // Affichage du "board" et du "hero".
    _board.drawIt();
    _hero.drawIt(_sprite_hero);
    _cellX=_hero._cellX;
    _cellY=_hero._cellY;
    
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
  }
  boolean obstacle(float cellX, float cellY, PVector direction, float CellSize, TypeCell [][] cell) {
    int x=round(cellX/CellSize);
    int y=int(cellY/CellSize)-2;
    println(x,y);
    println(cellX, cellY);
    x+=direction.x;
    y+=direction.y;
    println(x,y);
    println(cell.length,cell[0].length);
    if (x<=0){//||x>=cell.length){
      println("false");
      return false;
    }
    if (y<=0){//||y>=cell[0].length+2){
      println("false");
      return false;
    }
    
    float epsilon = 1;
    println(direction.x,direction.y);
    println(int(cellX/CellSize));
    println(cellX+CellSize);
    float UpLeftX=abs((cellX + (direction.x * CellSize)/4) - (int(cellX / CellSize)*CellSize + direction.x*CellSize));
    float UpLeftY = abs((cellY + (direction.y * CellSize)/4) - (int(cellY / CellSize)*CellSize + direction.y*CellSize));
    float UpRightX = abs((cellX + CellSize + (direction.x * CellSize )/4) - (int((CellSize+cellX) / CellSize)*CellSize + direction.x*CellSize));
    float  UpRightY = abs((cellY + (direction.y * CellSize) /4) - (int(cellY / CellSize)*CellSize + direction.y*CellSize));
    float  DownLeftX = abs((cellX + (direction.x * CellSize) /4)  - (int(cellX / CellSize)*CellSize + direction.x*CellSize));
    float  DownLeftY = abs((CellSize + cellY + (direction.y * CellSize) /4) - (int((CellSize+cellY) / CellSize)*CellSize + direction.y*CellSize));
    float DownRightX = abs((CellSize + cellX + (direction.x * CellSize) / 4) - (int((CellSize+cellX) / CellSize)*CellSize + direction.x*CellSize));
    float DownRightY =  abs((CellSize + cellY + (direction.y * CellSize) / 4) - (int((CellSize+cellY) / CellSize)*CellSize + direction.y*CellSize));
    /*println(UpLeftX,UpLeftY);
    println(UpRightX,UpRightY);
    println(DownLeftX,DownLeftY);
    println(DownRightX,DownRightY);
    println(epsilon);*/
    
    UpLeft = UpLeftX < epsilon && UpLeftY < epsilon;
    println(UpLeft);
    UpRight = UpRightX < epsilon && UpRightY < epsilon;
    println(UpRight); 
    DownLeft = DownLeftX < epsilon && DownLeftY < epsilon;
    println(DownLeft);
    DownRight = DownRightX < epsilon && DownRightY < epsilon;
    println(DownRight);
    if (UpLeft && UpRight && DownLeft && DownRight){
      x+=direction.x;
      y+=direction.y;
    }
    println(cell[y][x]!=TypeCell.EMPTY);
    if (cell[y][x] != TypeCell.EMPTY && UpLeft && UpRight && DownLeft && DownRight) {
      println("False");
      return false;
      
    } else {
      println("True");
      return true;
    }
  }
}
