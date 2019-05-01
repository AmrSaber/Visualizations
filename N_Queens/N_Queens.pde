import java.util.Stack;

final int GRID_SIZE = 8;
float cellH, cellW;
PImage img;

Stack<State> stack;

void setup() {
  size(500, 500);
  frameRate(3);

  cellH = (float) height / GRID_SIZE;
  cellW = (float) width / GRID_SIZE;

  img = loadImage("queen.png");

  stack = new Stack<State>();
  State state = new State();
  state.r = -1;
  state.c = -1;
  stack.push(state);
  
  noLoop();

}

void draw() {

  if (stack.size() == 0) {
    noLoop();
    return;
  }

  State current = stack.pop();
  drawGrid(current);

  if (current.r == GRID_SIZE - 1) {
    noLoop();
    return;
  }

  for (int c = GRID_SIZE - 1; c >= 0; --c) {
    State next = new State(current);

    if (!next.isValid(current.r+1, c)) continue;
    next.c = c;
    next.r = current.r + 1;
    next.affect();

    stack.push(next);
  }

}

void drawGrid(State state) {
  float cellH = (float) height / GRID_SIZE;
  float cellW = (float) width / GRID_SIZE;

  background(255);
  rectMode(CORNER);
  for (int r = 0; r < GRID_SIZE; ++r) {
    for (int c = 0; c < GRID_SIZE; ++c) {
      if ((r&1) != (c&1)) fill(0);
      else  fill(255);
      rect(c*cellW, r*cellH, cellW, cellH);
    }
  }

  PVector pos[] = state.getPositions();
  for (PVector vec : pos) {
    image(img, vec.x * cellW + cellW * 0.1, vec.y * cellH + cellH * 0.1, cellW * 0.8, cellH * 0.8);
  }
}

void keyPressed() {
  if (key == ' ') loop();
}
