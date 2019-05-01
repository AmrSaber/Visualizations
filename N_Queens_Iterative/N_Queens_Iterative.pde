final int GRID_SIZE = 8;
float cellH, cellW;
PImage img;

// represents the column of the queen in ith row
int pos[];

int colCount[];
int diagsCount[][];

boolean playing = false;

void setup() {
  size(500, 500);
  frameRate(50);

  cellH = (float) height / GRID_SIZE;
  cellW = (float) width / GRID_SIZE;

  img = loadImage("queen.png");

  pos = new int[GRID_SIZE];
  colCount = new int[GRID_SIZE];
  diagsCount = new int[2][2*GRID_SIZE];

  for (int i = 0; i < pos.length; ++i) {
    pos[i] = (int) random(GRID_SIZE);
    ++colCount[pos[i]];
    ++diagsCount[0][i+pos[i]];
    ++diagsCount[1][i-pos[i]+GRID_SIZE];
  }
}

void draw() {  
  drawGrid();
  
  if (!playing) {
    noLoop();
    return;
  }

  // select a conflicted variable (row)
  ArrayList<Integer> conflicts = new ArrayList();
  for (int i = 0; i < pos.length; ++i) {
    if (colCount[pos[i]] > 1 || diagsCount[0][i+pos[i]] > 1 || diagsCount[1][i-pos[i]+GRID_SIZE] > 1) {
      conflicts.add(i);
    }
  }


  if (conflicts.size() == 0) {
    println("DONE");
    noLoop();
    return;
  }

  int conflictedRow = conflicts.get(int(random(conflicts.size())));
  int conflictedCol = pos[conflictedRow];

  // assign new min-cost value to conflicted variable
  ArrayList<Integer> bestCols = new ArrayList();
  int minCost = 2 * GRID_SIZE;
  --colCount[conflictedCol];
  --diagsCount[0][conflictedRow+conflictedCol];
  --diagsCount[1][conflictedRow-conflictedCol+GRID_SIZE];

  for (int col = 0; col < GRID_SIZE; ++col) {
    int cost = colCount[col] + diagsCount[0][conflictedRow+col] + diagsCount[0][conflictedRow-col+GRID_SIZE];

    if (cost < minCost && col != conflictedCol) {
      minCost = cost;
      bestCols.clear();
    }

    if (cost == minCost) {
      bestCols.add(col);
    }
  }

  int bestCol = bestCols.get(int(random(bestCols.size())));
  
  pos[conflictedRow] = bestCol;
  ++colCount[bestCol];
  ++diagsCount[0][conflictedRow+bestCol];
  ++diagsCount[1][conflictedRow-bestCol+GRID_SIZE];
}

void drawGrid() {
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

  for (int i = 0; i < pos.length; ++i) {
    image(img, pos[i] * cellW + cellW * 0.1, i * cellH + cellH * 0.1, cellW * 0.8, cellH * 0.8);
  }
}

void keyPressed() {
  if (key == ' ') {
    playing = !playing;
    loop();
  }
}
