import java.util.Map;

Game game;
public boolean is_game = true;

Menu menu;
public boolean is_menu = false;

void setup() {
  size(800, 800, P2D);
  game = new Game();
  menu = new Menu();
}

void draw() {
  if ( is_game ){
    game.update();
    game.drawIt();
  }
  if ( is_menu ) {
    menu.drawIt(); 
  }
}

void keyPressed() {
  game.handleKey(key);
  if ( keyCode == ENTER ) {
    if ( is_menu == false ) {
      is_menu = true; 
      is_game = false;
    }
    else {
      is_menu = false;
      is_game = true;
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
  if ( mouseButton == LEFT && is_menu ) {
    if ( menu.isInsideButton(menu.pos_button1, menu.size_button) ) {
      is_menu = false;
      is_game = true;
    }
    if ( menu.isInsideButton(menu.pos_button5, menu.size_button) ) {
      exit();
    }
  }
}
