LinksSystem system;

void setup() {
  size(700, 500);
  frameRate(30);

  system = new LinksSystem(new PVector(width/2, height/2));
}

void draw() {
  background(51);

  system.run();
}

void keyPressed() {
  if (key == 'C' || key == 'c') system.clear();
}

void mousePressed() {
  system.onMouseDown();
}

void mouseReleased() {
  system.onMouseUp();
}

void mouseDragged() {
  system.onMouseDrag();
}
