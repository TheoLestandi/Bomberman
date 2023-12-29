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
  float _cellX,_cellY;
  
  Sprites sprite_hero;
  PImage _sprite_hero ;
  PImage sprite_hero_and_mob = loadImage("data/img/characters.png");

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
<<<<<<< Updated upstream

    // Données pour le "hero".
    _hero = new Hero(_board._cellSize, _line2);
    PImage sprite_hero_and_mob = loadImage("data/img/characters.png");
=======
    
    // Données pour le "hero". 
>>>>>>> Stashed changes
    sprite_hero = new Sprites(sprite_hero_and_mob );
    _sprite_hero = sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);   
    _hero = new Hero(_board._cellSize, _line2, _sprite_hero);
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
    _hero.drawIt();
  }

  void handleKey(int k) {
    if(k=='z'||keyCode==UP||k=='Z'){
    PVector position = new PVector( 0, -1 );
    _sprite_hero= sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_UP1);
    _hero.move(_board,position,_sprite_hero);
  }
    if(k == 'q' || keyCode == LEFT){
    PVector position = new PVector( -1, 0 );
    _sprite_hero= sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_LEFT1);
    _hero.move(_board,position,_sprite_hero);
  }
    if(k == 's' || keyCode == DOWN){
    PVector position = new PVector( 0, 1 );
    _sprite_hero=sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);
    _hero.move(_board,position,_sprite_hero);
  }
    if(k == 'd' || keyCode == RIGHT){
    PVector position = new PVector( 1, 0 );
    _sprite_hero =sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_RIGHT1);
    _hero.move(_board,position,_sprite_hero);
  }
  }
  
}
