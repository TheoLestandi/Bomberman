class Game {
  String[] _line = loadStrings("levels/level1.txt");
  String [] _line2 = new String[_line.length-1];

  Board _board;
  Hero _hero;
  Bomb bomb;
  Mob[] mob;
  int mobcenterx, mobcentery;

  String _levelName;

  int _numberCellsX;
  int _numberCellsY;
  float _ecart;
  float _sizeCell;
  float _size_inter_board = width/160;
  float _size_txt = width/20;

  PVector _posTab;
  PVector _sizeTab;

  Sprites sprite_hero;
  PImage _sprite_hero ;
  PImage position_base_hero;
  int derFrameHero = 0;
  int num_hero = 1;
  int timeFrame = 200;
  PImage sprite_hero_and_mob = loadImage("data/img/characters.png");
  int score = 0;

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
    boomExit = false;

    // Données pour le "board".
    arrayCopy(_line, 1, _line2, 0, _line2.length);
    _numberCellsX = _line2[0].length();
    _numberCellsY = _line2.length - 1;
    _sizeCell = float(width)/ _numberCellsX;
    _ecart = 2.5*_sizeCell;
    _posTab = new PVector(0, _ecart);
    _sizeTab = new PVector(width, height - _posTab.y);
    _board = new Board(_posTab, _sizeTab, _numberCellsX, _numberCellsY, _line2);

    // Données pour le "hero".
    positionHero = _board._parser.spawnHero;
    PImage sprite_hero_and_mob = loadImage("data/img/characters.png");
    sprite_hero = new Sprites(sprite_hero_and_mob );
    _sprite_hero = sprite_hero.searchSpriteHero().get(TypeSprites.BOMBERMAN_DOWN1);
    _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );

    // Données pour les mob.
    positionMob = _board._parser.spawnMob;
    nbMob = _board._parser.numMob;
    mob = new Mob[nbMob];
    for ( int numMob = 0; numMob < nbMob; numMob++ ) {
      mob[numMob] = new Mob( positionMob[numMob], _sizeCell, _ecart, _board);
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

    drawButton(width/6, _posTab.y/2, _size_txt, _levelName);
    drawButton(width/6*5, _posTab.y/2, _size_txt, "Life: "+BBM_life);
    drawButton(width/6*3, _posTab.y/3*2, _size_txt, ""+score);

    // Affichage du "board" et du "hero".
    _board.drawIt();


    if (bomb != null && millis()-bomb.Time>3000) {
      canExplose(bombPlacementCellX, bombPlacementCellY, bomb._explosionRadius);
      explosion(bombPlacementCellX, bombPlacementCellY, _cell, bomb._explosionRadius);
      bomb.explosion_bomb_rad();
      bomb=null;
    }
    if (bomb != null) {
      bomb.drawIt();
    }

    for ( int numMob = 0; numMob < nbMob; numMob++ ) {
      if ( mob[numMob]!=null){
        mob[numMob].move(_board, 20);
        mob[numMob].drawIt();
      }
    }

    _hero.drawIt(_sprite_hero);
    _cellX=_hero._cellX;
    _cellY=_hero._cellY;
  }

  void handleKey(int k) {
    if (k=='z'||keyCode==UP||k=='Z') {
      PVector position = new PVector( 0, -1 );
      loadHero("BOMBERMAN_UP");
      _hero.move(_board, position);
      _hero.drawIt(_sprite_hero);
    }

    if (k == 'q' || keyCode == LEFT) {
      PVector position = new PVector( -1, 0 );
      loadHero("BOMBERMAN_LEFT");
      _hero.move(_board, position);
      _hero.drawIt(_sprite_hero);
    }

    if (k == 's' || keyCode == DOWN) {
      PVector position = new PVector( 0, 1 );
      loadHero("BOMBERMAN_DOWN");
      _hero.move(_board, position);
      _hero.drawIt(_sprite_hero);
    }

    if (k == 'd' || keyCode == RIGHT) {
      PVector position = new PVector( 1, 0 );
      loadHero("BOMBERMAN_RIGHT");
      _hero.move(_board, position);
      _hero.drawIt(_sprite_hero);
    }

    if (k == ' ' && bomb==null) {
      float cellX=floor((_cellX+_sizeCell/2)/_sizeCell);
      float cellY=floor((_cellY+_sizeCell/2)/_sizeCell-2.5);
      PVector centerCell= _board.getCellCenter(cellX*_sizeCell, cellY*_sizeCell+2.5*_sizeCell);
      bomb = new Bomb(centerCell.x, centerCell.y, _sizeCell, false);
      bombPlacementCellX = cellX; // Enregistrez les coordonnées de la pose de la bombe
      bombPlacementCellY = cellY;
    }
  }

  void canExplose(float x, float y, int radius) {
    int cellX_parser = int(x);
    int cellY_parser = int(y);

    for ( int i = 1; i <= radius; i++ ) {
      if (!bomb.upWall && cellY_parser - i >= 0) {
        if ( _cell[cellX_parser][cellY_parser-i] == TypeCell.WALL ) {
          bomb.upWall = true;
        }
      }
      if (!bomb.downWall && cellY_parser + i >= 0) {
        if ( _cell[cellX_parser][cellY_parser+i] == TypeCell.WALL )
          bomb.downWall = true;
      }
    }
    for ( int j = 1; j <= radius; j++ ) {
      if (!bomb.leftWall && cellX_parser - j >= 0) {
        if ( _cell[cellX_parser-j][cellY_parser] == TypeCell.WALL )
          bomb.leftWall = true;
      }
      if (!bomb.rightWall && cellX_parser + j >= 0) {
        if ( _cell[cellX_parser+j][cellY_parser] == TypeCell.WALL )
          bomb.rightWall = true;
      }
    }
  }

  void explosion(float cellX, float cellY, TypeCell [][] cell, int rad) {
    if (cell[int(cellY+rad)][int(cellX)]==TypeCell.DESTRUCTIBLE_WALL ) {
      cell[int(cellY+rad)][int(cellX)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY-rad)][int(cellX)]==TypeCell.DESTRUCTIBLE_WALL ) {
      cell[int(cellY-rad)][int(cellX)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY)][int(cellX+rad)]==TypeCell.DESTRUCTIBLE_WALL  ) {
      cell[int(cellY)][int(cellX+1)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY)][int(cellX-rad)]==TypeCell.DESTRUCTIBLE_WALL  ) {
      cell[int(cellY)][int(cellX-rad)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY+rad)][int(cellX)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }
    if (cell[int(cellY-rad)][int(cellX)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }
    if (cell[int(cellY)][int(cellX+rad)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }
    if (cell[int(cellY)][int(cellX-rad)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }

    //Mort mob
    for ( int numMob = 0; numMob < nbMob; numMob++ ) {
      if (mob[numMob]!=null){
      

      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY+rad) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY-rad) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX+rad && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX-rad && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY) {
        mob[numMob]=null;
      }
    }
    }


    //Mort hero
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY+rad) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY-rad) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX+rad && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX-rad && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (rad=2){
      if (cell[int(cellY+rad)][int(cellX)]==TypeCell.DESTRUCTIBLE_WALL ) {
      cell[int(cellY+rad)][int(cellX)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY-rad)][int(cellX)]==TypeCell.DESTRUCTIBLE_WALL ) {
      cell[int(cellY-rad)][int(cellX)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY)][int(cellX+rad)]==TypeCell.DESTRUCTIBLE_WALL  ) {
      cell[int(cellY)][int(cellX+1)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY)][int(cellX-rad)]==TypeCell.DESTRUCTIBLE_WALL  ) {
      cell[int(cellY)][int(cellX-rad)]=TypeCell.EMPTY;
    }
    if (cell[int(cellY+rad)][int(cellX)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }
    if (cell[int(cellY-rad)][int(cellX)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }
    if (cell[int(cellY)][int(cellX+rad)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }
    if (cell[int(cellY)][int(cellX-rad)]==TypeCell.EXIT_DOOR) {
      boomExit = true;
    }

    //Mort mob
    for ( int numMob = 0; numMob < nbMob; numMob++ ) {
      if (mob[numMob]!=null){
      

      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY+rad) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY-rad) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX+rad && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY) {
        mob[numMob]=null;
      }
      if (floor((mob[numMob].positionbis.x+_sizeCell/2)/_sizeCell)==cellX-rad && floor((mob[numMob].positionbis.y+_sizeCell/2)/_sizeCell-2.5)==cellY) {
        mob[numMob]=null;
      }
    }
    }


    //Mort hero
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY+rad) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY-rad) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX+rad && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
    if (floor((_cellX+_sizeCell/2)/_sizeCell)==cellX-rad && floor((_cellY+_sizeCell/2)/_sizeCell-2.5)==cellY) {
      if ( BBM_life > 1 ) {
        BBM_life -= 1;
        _hero = new Hero( positionHero, _board._cellSize, _ecart, _line2, _sprite_hero );
      } else {
        exit();
      }
    }
  }
  }
  

    void loadHero(String _name) {
      if (millis() - derFrameHero >= timeFrame) {
        derFrameHero = millis();
        num_hero++;
      }

      if (num_hero > 4) {
        num_hero = 1;
      }

      TypeSprites name = Enum.valueOf(TypeSprites.class, _name+num_hero);

      if (num_hero == 1)
        _sprite_hero =  sprite_hero.searchSpriteHero().get(name);
      else if (num_hero == 2)
        _sprite_hero =  sprite_hero.searchSpriteHero().get(name);
      else if (num_hero == 3)
        _sprite_hero =  sprite_hero.searchSpriteHero().get(name);
      else if (num_hero == 4)
        _sprite_hero =  sprite_hero.searchSpriteHero().get(name);
    }

    void drawButton(float posX, float posY, float sizetxt, String txt) {
      stroke(inter_board);
      strokeWeight(_size_inter_board);
      fill(black);
      rectMode(CENTER);
      rect(posX, posY, width/5, width/14);
      textAlign(CENTER, CENTER);
      fill(white);
      textSize(sizetxt);
      text(txt, posX, posY);
    }

    void saveBoard(String name_player) {
      char[][] mapSave = new char[_cell.length][_cell[0].length];
      for (int j = 0; j < _cell.length; j++) {
        for (int i = 0; i < _cell[0].length; i++) {
          if (_cell[j][i] == TypeCell.WALL) {
            mapSave[i][j] = 'x';
          } else if (_cell[j][i] == TypeCell.DESTRUCTIBLE_WALL) {
            mapSave[i][j] = 'o';
          } else if (_cell[j][i] == TypeCell.EXIT_DOOR) {
            mapSave[i][j] = 'S';
          } else {
            mapSave[i][j] = 'v';
          }
        }
      }

      String[] map =  new String[_cell[0].length];
      for (int i = 0; i < _cell[0].length; i++) {
        map[i] = new String(mapSave[i]);
      }

      String[] all_parameters = { str(score), str(BBM_life) };

      saveStrings("data/save/"+name_player+"/map.txt", map);
      saveStrings("data/save/"+name_player+"/parameters.txt", all_parameters);
    }
  }
