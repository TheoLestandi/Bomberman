import java.util.Map;

Game game;
public boolean is_game = false;

Menu menu;
public boolean is_titre = true;
public boolean in_titre = true;
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
    if ( !in_titre  ) { 
      game.drawIt();
      menu.drawLoad(); 
    }
    else 
      menu.drawLoad(); 
  }
  if (isKeypressed && !is_titre && !is_menu && !is_save && !is_load){
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
