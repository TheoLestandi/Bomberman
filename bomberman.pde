Game game;


void setup() {
  size(800, 800, P2D);
  game = new Game();
}

void draw() {
  game.update();
  game.drawIt();
}

void keyPressed() {
  game.handleKey(key);
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
