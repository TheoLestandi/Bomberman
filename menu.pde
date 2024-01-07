class Button {
  String text;
  PVector topleft;
  PVector size;
  float txtS;
  PVector pos_txt_in_button;
  color color_button;
  color color_txt_button;
  
  Button(String txt, PVector corner_topleft, PVector size_button, color col_button, color txt_button) {
    text = txt;
    topleft = corner_topleft;
    size = size_button;  
    txtS = size.x / 8;
    pos_txt_in_button = new PVector(topleft.x + size.x / 2,topleft.y + size.y / 2);
    color_button = col_button;
    color_txt_button = txt_button;
  }
  
  boolean isTriggered() {
    return false;
  }
  
  void drawButton() {
    rectMode(CORNER);
    fill(color_button);
    rect(topleft.x, topleft.y, size.x, size.y);
    textAlign(CENTER,CENTER);
    fill(color_txt_button); 
    textSize(txtS);
    text(text, pos_txt_in_button.x, pos_txt_in_button.y) ;
  }
  
}

class Menu {
  
  // ecran titre.
  Button _button_titre1;
  Button _button_titre2;
  Button _button_titre3;
  Button _button_titre4;
  
  String txt_menu_titre =  "Bomberman";
  PVector size_button_titre;
  PVector pos_button_titre1;
  PVector pos_button_titre2;
  PVector pos_button_titre3;
  PVector pos_button_titre4;

  // ecran pause.
  Button _button1;
  Button _button2;
  Button _button3;
  Button _button4;
  Button _button5;
  
  String txt_menu_pause =  "Pause";
  PVector size_button;
  PVector pos_button1;
  PVector pos_button2;
  PVector pos_button3;
  PVector pos_button4;
  PVector pos_button5;
  
  // ecran save.
  Button _button_nom;
  Button _button_save;
  
  String txt_menu_save =  "Save";
  String text = "Entrez un nom:";
  PVector size_button_save;
  PVector pos_button_nom;
  PVector pos_button_save;
  
  //ecran Load Save. 
  Button _button_load1;
  Button _button_load2;
  Button _button_load3;
  Button _button_load4;
 
  String txt_menu_load =  "Load Save";
  PVector size_button_load;
  PVector pos_button_load1;
  PVector pos_button_load2;
  PVector pos_button_load3;
  PVector pos_button_load4;

  
  // General.
  PVector pos_txt;
  float size_txt;
  
  PVector center_menu;
  PVector size_menu;
  float radius_menu;
  float _size_line = width/160;
  
  Menu() {
 
    pos_txt = new PVector( width / 2, height / 6);
    size_txt = width / 12; 
    
    center_menu = new PVector(width / 2, height / 2);
    size_menu = new PVector( width * 0.7, height * 0.9 );
    radius_menu = width /20;
    
    size_button_titre = new PVector( width * 0.4, size_menu.y * 0.12 );
    
    // boutons écran titre.
    pos_button_titre1 = new PVector( width * 0.3, size_menu.y * 0.40 );
    pos_button_titre2 = new PVector( width * 0.3, size_menu.y * 0.55 );
    pos_button_titre3 = new PVector( width * 0.3, size_menu.y * 0.70 );
    pos_button_titre4 = new PVector( width * 0.3, size_menu.y * 0.85 );
    
    _button_titre1 =  new Button("Play", pos_button_titre1, size_button_titre, orange, white);
    _button_titre2 =  new Button("Load Save", pos_button_titre2, size_button_titre, orange, white);
    _button_titre3 =  new Button("Board score", pos_button_titre3, size_button_titre, orange, white);
    _button_titre4 =  new Button("Quit", pos_button_titre4, size_button_titre, orange, white);
    
    // boutons écran pause.
    size_button = new PVector( width * 0.4, size_menu.y * 0.08 );
    pos_button1 = new PVector( width * 0.3, size_menu.y * 0.3 );
    pos_button2 = new PVector( width * 0.3, size_menu.y * 0.45 );
    pos_button3 = new PVector( width * 0.3, size_menu.y * 0.6 );
    pos_button4 = new PVector( width * 0.3, size_menu.y * 0.75 );
    pos_button5 = new PVector( width * 0.3, size_menu.y * 0.9 );
    
    _button1 = new Button("Resume", pos_button1, size_button, black, orange);
    _button2 = new Button("Save", pos_button2, size_button, black, orange);
    _button3 = new Button("Load save", pos_button3, size_button, black, orange);
    _button4 = new Button("Best score", pos_button4, size_button, black, orange);
    _button5 = new Button("Quit", pos_button5, size_button, black, orange);

    // boutons écran save.
    size_button_save = new PVector( width * 0.5, size_menu.y * 0.2 );
    pos_button_nom = new PVector( width * 0.25, size_menu.y * 0.35 );
    pos_button_save = new PVector( width * 0.25, size_menu.y * 0.65 );
    
    _button_save = new Button("Save", pos_button_save, size_button_save, black, orange);

    // boutons écran load save.
    size_button_load = new PVector( width * 0.4, size_menu.y * 0.12 );
    pos_button_load1 = new PVector( width * 0.3, size_menu.y * 0.3 );
    pos_button_load2 = new PVector( width * 0.3, size_menu.y * 0.45 );
    pos_button_load3 = new PVector( width * 0.3, size_menu.y * 0.6 );
    pos_button_load4 = new PVector( width * 0.3, size_menu.y * 0.75 );
    
    _button_load1 = new Button("", pos_button_load1, size_button_load, black, orange);
    _button_load2 = new Button("", pos_button_load2, size_button_load, black, orange);
    _button_load3 = new Button("", pos_button_load3, size_button_load, black, orange);
    _button_load4 = new Button("", pos_button_load4, size_button_load, black, orange);
  }
  
  void drawTitre() {
    noStroke();
    fill(white);
    rectMode(CENTER);
    rect(width/2,height/2,width,height);
    fill(orange);
    rectMode(CENTER);
    rect(width/2,height/2,width-30,height-30);
    fill(black);
    rectMode(CENTER);
    rect(width/2,height/2,width-60,height-60);
    textAlign( CENTER, CENTER );
    fill(orange); 
    textSize( size_txt * 5 / 3);
    text( txt_menu_titre, pos_txt.x, pos_txt.y );
    _button_titre1.drawButton();
    _button_titre2.drawButton();
    _button_titre3.drawButton();
    _button_titre4.drawButton();
  
  }

  void drawPause() {
    rectMode( CENTER );
    stroke(black);
    strokeWeight(_size_line);
    fill( white_menu );
    rect( center_menu.x, center_menu.y, size_menu.x, size_menu.y, radius_menu );
    textAlign( CENTER, CENTER );
    fill( black ); 
    textSize( size_txt );
    text( txt_menu_pause, pos_txt.x, pos_txt.y );
    _button1.drawButton();
    _button2.drawButton();
    _button3.drawButton();
    _button4.drawButton();
    _button5.drawButton();
  }
  
  void drawSave() {
    rectMode( CENTER );
    stroke(black);
    strokeWeight(_size_line);
    fill( white_menu );
    rect( center_menu.x, center_menu.y, size_menu.x, size_menu.y, radius_menu );
    textAlign( CENTER, CENTER );
    fill( black ); 
    textSize( size_txt );
    text( txt_menu_save, pos_txt.x, pos_txt.y );
    _button_nom = new Button(text, pos_button_nom, size_button_save, black, orange);
    _button_nom.drawButton();
    _button_save.drawButton();
  }
  
  void drawLoad() {
    rectMode( CENTER );
    stroke(black);
    strokeWeight(_size_line);
    fill( white_menu );
    rect( center_menu.x, center_menu.y, size_menu.x, size_menu.y, radius_menu );
    textAlign( CENTER, CENTER );
    fill( black ); 
    textSize( size_txt );
    text( txt_menu_load, pos_txt.x, pos_txt.y );
    _button_load1.drawButton();
    _button_load2.drawButton();
    _button_load3.drawButton();
    _button_load4.drawButton();
  }

  boolean isInsideButton ( PVector pos_button, PVector size_button ) {
     return (mouseX >= pos_button.x  && mouseX < pos_button.x + size_button.x ) && (mouseY >= pos_button.y && mouseY < pos_button.y + size_button.y );
  }
  
  // fonction qui sauvegarde un nom.
  void saveName() {
    if (((char)key >= 'a') && ((char)key <= 'z') && ( text.length() < 15)) {
      if (text == "Entrez un nom:") {
        text = str((char)key);
      }
      else {
        text += ((char)key);
      }
    }
    else if (key == DELETE && text.length() != 0) {
      text = text.substring(0, text.length()-1);
    }
    else if (keyCode == ' ' && !(text == "Entrez un nom:")) {
      text += " ";
    }
  }
  
  

  void update(Game game) {
    
  }

  void handleMouse() {
    if ( mouseButton == LEFT && is_titre ) {
      if ( menu.isInsideButton(menu.pos_button_titre1, menu.size_button) ) {
        is_titre = false;
        is_game = true;
      }
      if ( menu.isInsideButton(menu.pos_button_titre2, menu.size_button) ) {
        is_load= true;
      }
      if ( menu.isInsideButton(menu.pos_button_titre4, menu.size_button) ) {
        is_titre = false;
        exit();
      }
    }
    if ( mouseButton == LEFT && is_menu ) {
      if ( menu.isInsideButton(menu.pos_button1, menu.size_button) ) {
        is_menu = false;
        is_game = true;
      }
      if ( menu.isInsideButton(menu.pos_button2, menu.size_button) ) {
        is_menu = false;
        is_save = true;
      }
      if ( menu.isInsideButton(menu.pos_button3, menu.size_button) ) {
        is_menu = false;
        is_load = true;
      }
      if ( menu.isInsideButton(menu.pos_button5, menu.size_button) ) {
        is_menu = false;
        is_titre = true;
      }
    }
    if ( mouseButton == LEFT && is_save ) {
      if ( menu.isInsideButton(menu.pos_button_save, menu.size_button_save) ) {
        is_save = false;
        is_titre = true;
      }
    }
      
  }
  
  void handleKey() {
    if ( keyCode == ESC ) {
    key = 0;
      if ( !is_titre ) {
        if ( !is_menu) {
          is_menu = true; 
          text = "Entrez un nom:";
          is_game = false;
        }
        else {
          is_menu = false;
          is_game = true;
        }
        if ( is_save ) {
          is_save = false; 
          is_menu = true;
        }
        if ( is_load ) {
          is_load = false; 
          is_menu = true;
        }
      }
      else {
        if ( is_load ) {
          is_load = false; 
      }
    }
  }
  }
} 
