Game game;

void setup() {
  size(800, 800, P2D);
  game = new Game();
  println();
}

void draw() {
  game.update();
  game.drawIt();
}

void keyPressed() {
  game.handleKey(key);
}

void mousePressed() {
}
