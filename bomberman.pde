import java.util.Map;

Game game;

Menu menu;
public boolean is_menu = false;

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
    PVector position = new PVector( -1, 0 );
    Board board = game._board;
    game._hero.move(board,position);
  }
  if(Left){
    PVector position = new PVector( 0, -1 );
    
  }
  if(Down){
    PVector position = new PVector( 1, 0 );
    
  }
  if(Right){
    PVector position = new PVector( 0, 1 );
    
  }
}

void mousePressed() {
}
