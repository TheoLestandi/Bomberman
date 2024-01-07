import java.util.Map;

Game game;
public boolean is_game = false;

Menu menu;
public boolean is_titre = true;
public boolean is_menu = false;
public boolean is_save = false;
public boolean is_load = false;

boolean isKeypressed;

void setup() {
  size(800, 800, P2D);
  game = new Game();
  menu = new Menu();
}

void draw() {
  if (is_titre){
    menu.drawTitre();
  }
  if ( is_game ){
    game.update();
    game.drawIt();
  }
  if ( is_menu ) {
    game.drawIt();
    menu.drawPause(); 
  }
  if ( is_save ) {
    game.drawIt();
    menu.drawSave(); 
  }
  if ( is_load ) {
    game.drawIt();
    menu.drawSave(); 
  }
  if (isKeypressed && !is_titre && !is_menu && !is_save){
    game.handleKey(key);
  }
}

void keyPressed() {
  menu.handleKey();
  if (is_save) 
    menu.saveName();
  isKeypressed=true;
  
}
void keyReleased(){
  isKeypressed=false;
}

void mousePressed() {
  menu.handleMouse();
}
