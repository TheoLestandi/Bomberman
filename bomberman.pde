import java.util.Map;

Game game;

Menu menu;
boolean is_menu = false;

void setup() {
  size(800, 800, P2D);
  game = new Game();
  menu = new Menu();
}

void draw() {
  game.update();
  game.drawIt();
  if ( is_menu == true ) {
    menu.drawIt(); 
  }
}

void keyPressed() {
  game.handleKey(key);
  if ( keyCode == ENTER ) {
    if ( is_menu == false ) {
      is_menu = true; 
    }
    else {
      is_menu = false;
    }
  }
  if(Up){
    float positionY = game._hero._cellY - game._hero.cellS;
    PVector position = new PVector(game._hero._cellX, positionY);
    Board board = game._board;
    game._hero.move(board,position);
  }
  if(Left){
    ;
  }
  if(Down){
    ;
  }
  if(Right){
    ;
  }
}

void mousePressed() {
}
