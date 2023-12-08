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
  float radius_menu;
  
  PVector size_button;
  PVector pos_button1;
  PVector pos_button2;
  PVector pos_button3;
  PVector pos_button4;
  PVector pos_button5;
  
  Menu() {
    
    pos_txt = new PVector( width / 2, height / 5);
    size_txt = width / 12; 
    
    center_menu = new PVector(width / 2, height / 2);
    size_menu = new PVector( width * 0.9, height * 0.9 );
    radius_menu = width /20;
    
    size_button = new PVector( size_menu.x * 0.4, size_menu.y * 0.15 );
    pos_button1 = new PVector( size_menu.x * 0.3, size_menu.y  );
    pos_button2 = 
    pos_button3 = 
    pos_button4 = 
    pos_button5 =
  }

  void drawIt() {
    rectMode( CENTER );
    stroke(black, 200);
    fill( white_menu );
    rect( center_menu.x, center_menu.y, size_menu.x, size_menu.y, radius_menu );
    textAlign( CENTER, CENTER );
    fill(black); 
    textSize(size_txt);
    text( txt_menu, pos_txt.x, pos_txt.y );
    
  }

  void update(Game game) {
    
  }

  void handleMouse() {
  }
}
