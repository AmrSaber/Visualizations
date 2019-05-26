LinksSystem system;

void setup(){
  size(700, 500);
  frameRate(30);
  
  system = new LinksSystem(new PVector(width/2, height/2));
}

void draw(){
  background(51);
  system.follow(new PVector(mouseX, mouseY));
  system.update();
  system.show();
}

void mousePressed() {
  system.onMouseDown();
}
