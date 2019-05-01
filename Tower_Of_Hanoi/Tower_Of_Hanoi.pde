import java.util.Stack;

final int BLOCKS_COUNT = 5;

color clrs[];
Stack<Integer> columns[];
Stack<State> stack;

PFont arial;
int step, totalSteps;
boolean looping = false;

void setup() {
  size(750, 600);
  frameRate(2);
  //noCursor();

  init();
  setColors();
  
  arial = createFont("Arial", 24);
  textFont(arial);
}

void draw() {
  drawState();
    
  if (!looping || stack.size() == 0) {
    noLoop();
    return;
  }
  
  State currentState = stack.pop();
  
  while (currentState.n != 1) {
    int third = 3 - (currentState.from + currentState.to);
    stack.push(new State(currentState.n-1, third, currentState.to));
    stack.push(new State(1, currentState.from, currentState.to));
    stack.push(new State(currentState.n-1, currentState.from, third));
    currentState = stack.pop();
  }
    
  if (currentState.n == 1) {
    int value = columns[currentState.from].pop();
    columns[currentState.to].push(value);
    
    ++step;
    
    //if (stack.size() != 0) currentState = stack.pop();
    //else return;
  }
}

void drawState() {
  background(80, 130, 200);
  
  String header = String.format("[Step %d/%d]", step, totalSteps);
  fill(0);
  text(header, width/2 - textWidth(header) / 2, 32);

  // draw the table
  stroke(0);
  fill(120, 80, 80);
  rectMode(CENTER);
  float tableHeight = 20;
  float tableWidth = width * 0.85;
  rect(width/2, height - tableHeight / 2, tableWidth, tableHeight);
  
  translate(0, -tableHeight);

  // draw the columns
  fill(0);
  noStroke();
  rectMode(CORNERS);
  float colStart = (width - tableWidth) / 2 + tableWidth / 6;
  float colOffset = tableWidth / 3;
  float colHeight = height * 0.5;
  float colWidth = 7;
  for (int i = 0; i < 3; ++i) {
    float xCenter = colStart + colOffset * i;
    rect(xCenter - colWidth / 2, height, xCenter + colWidth/2, height - colHeight);
  }
  
  // draw the blocks ...
  float blockWidth = tableWidth * 0.85 / 3;
  float blockHeight = 150f / BLOCKS_COUNT;
  for (int i = 0; i < 3; ++i) {
    float colXCenter = colStart + colOffset * i;
    Stack<Integer> temp = new Stack<Integer>();
    while (columns[i].size() != 0) temp.push(columns[i].pop());
    for (int j = 0; temp.size() != 0; ++j) {
      int value = temp.pop();
      columns[i].push(value);
      
      // draw the block with size "value" at level "j" from the table
      fill(clrs[value-1]);
      stroke(0);
      strokeWeight(1);
      rectMode(CENTER);
      float blockY = height - blockHeight /2 - blockHeight * j;
      float actualWidth = blockWidth * value / BLOCKS_COUNT;
      rect(colXCenter, blockY, actualWidth, blockHeight);
    }
  }
}

void init() {
  stack = new Stack<State>();
  columns = new Stack[] {new Stack<Integer>(), new Stack<Integer>(), new Stack<Integer>()};
  for (int i = 0; i < BLOCKS_COUNT; ++i) columns[0].push(BLOCKS_COUNT - i);
  
  stack.push(new State(BLOCKS_COUNT, 0, 2));
  
  step = 0;
  totalSteps = (int) (pow(2, BLOCKS_COUNT) - 1);
}

void setColors() {
      clrs = new color[BLOCKS_COUNT];
    for (int i = 0 ; i < clrs.length ; ++i) clrs[i] = color(random(256), random(256), random(256));

}

void keyPressed() {
  if (key == ' ') {
    looping = !looping;
    if (looping) loop();
    else noLoop();
  } else if (key == 'r' || key == 'R') {
    init();
    loop();
    looping = false;
  } else if (key == 'c' || key == 'C') {
    setColors();
    loop();
  }
}
