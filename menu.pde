class Button {
  String text;
  PVector topleft;
  PVector size;
  
  Button(String txt, PVector corner_topleft, PVector size_button) {
    text = txt;
    topleft = corner_topleft;
    size = size_button;  
  }
  
  boolean isTriggered() {
    return false;
  }
  
  void drawButton() {
    rectMode(CORNER);
    fill(black);
    rect(topleft.x, topleft.y, size.x, size.y);
    textAlign(CENTER);
    fill(white); 
    textSize(size.x);
    text(text, size.x, size.y) ;
  }
  
}

class Menu {
  
  String txt_menu =  "Menu Pause";
  PVector pos_txt;
  float size_txt;
  
  PVector center_menu;
  PVector size_menu;
  
  Menu() {
    pos_txt = new PVector( width / 2, height / 4);
    size_txt = width / 9; 
    center_menu = new PVector(width / 2, height / 2);
    size_menu = new PVector( width * 0.8, height * 0.8 );
  }

  void drawIt() {
    rectMode( CENTER );
    fill( white_menu );
    rect( center_menu.x, center_menu.y, size_menu.x, size_menu.y );
    
  }

  void update(Game game) {
  }

  void handleMouse() {
  }
}
