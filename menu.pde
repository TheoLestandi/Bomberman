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
    fill(white);
    rect(topleft.x, topleft.y, size.x, size.y);
    textAlign(CENTER);
    fill(black); 
    textSize(size.x);
    text(text, size.x, size.y) ;
  }
  
}

class Menu {
  String txt_menu =  "Menu Pause";
  PVector center_menu;
  PVector size_menu;
  
  Menu() {
    //center
  }

  void drawIt() {
  }

  void update(Game game) {
  }

  void handleMouse() {
  }
}
