class Button {
  String text;
  PVector topleft;
  PVector size;
  float txtS;
  PVector pos_txt_in_button;
  
  Button(String txt, PVector corner_topleft, PVector size_button) {
    text = txt;
    topleft = corner_topleft;
    size = size_button;  
    txtS = size.x / 8;
    pos_txt_in_button = new PVector(topleft.x + size.x / 2,topleft.y + size.y / 2);
  }
  
  boolean isTriggered() {
    return false;
  }
  
  void drawButton() {
    rectMode(CORNER);
    fill(black);
    rect(topleft.x, topleft.y, size.x, size.y);
    textAlign(CENTER,CENTER);
    fill(orange); 
    textSize(txtS);
    text(text, pos_txt_in_button.x, pos_txt_in_button.y) ;
  }
  
}

class Menu {
  
  Button _button1;
  Button _button2;
  Button _button3;
  Button _button4;
  Button _button5;
  
  String txt_menu =  "Pause";
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
    
    pos_txt = new PVector( width / 2, height / 6);
    size_txt = width / 12; 
    
    center_menu = new PVector(width / 2, height / 2);
    size_menu = new PVector( width * 0.7, height * 0.9 );
    radius_menu = width /20;
    
    size_button = new PVector( width * 0.4, size_menu.y * 0.08 );
    pos_button1 = new PVector( width * 0.3, size_menu.y * 0.3 );
    pos_button2 = new PVector( width * 0.3, size_menu.y * 0.45 );
    pos_button3 = new PVector( width * 0.3, size_menu.y * 0.6 );
    pos_button4 = new PVector( width * 0.3, size_menu.y * 0.75 );
    pos_button5 = new PVector( width * 0.3, size_menu.y * 0.9 );
    
    _button1 = new Button("Resume", pos_button1, size_button);
    _button2 = new Button("Save", pos_button2, size_button);
    _button3 = new Button("Load save", pos_button3, size_button);
    _button4 = new Button("Best score", pos_button4, size_button);
    _button5 = new Button("Quit", pos_button5, size_button);

  }

  void drawIt() {
    rectMode( CENTER );
    stroke(black);
    fill( white_menu );
    rect( center_menu.x, center_menu.y, size_menu.x, size_menu.y, radius_menu );
    textAlign( CENTER, CENTER );
    fill( black ); 
    textSize( size_txt );
    text( txt_menu, pos_txt.x, pos_txt.y );
    _button1.drawButton();
    _button2.drawButton();
    _button3.drawButton();
    _button4.drawButton();
    _button5.drawButton();
  }

  boolean isInsideButton ( PVector pos_button, PVector size_button ) {
     return (mouseX >= pos_button.x  && mouseX < pos_button.x + size_button.x ) && (mouseY >= pos_button.y && mouseY < pos_button.y + size_button.y );
  }

  void update(Game game) {
    
  }

  void handleMouse() {
  }
} 
