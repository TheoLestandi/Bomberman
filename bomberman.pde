import java.util.Map;

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
    float positionX = game._hero._cellX - game._hero.cellS;
    PVector position = new PVector(positionX,game._hero._cellY);
    Board board = game._board;
    game._hero.move(board,position);
  }
  if(Down){
    float positionY = game._hero._cellY + game._hero.cellS;
    PVector position = new PVector(game._hero._cellX, positionY);
    Board board = game._board;
    game._hero.move(board,position);
    game._hero.update(board);
  }
  if(Right){
    float positionX = game._hero._cellX + game._hero.cellS;
    PVector position = new PVector(positionX,game._hero._cellY);
    Board board = game._board;
    game._hero.move(board,position);
  }
}

void mousePressed() {
}
