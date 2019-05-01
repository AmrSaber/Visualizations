Wheel w;

void setup(){
  size(800, 600);
  frameRate(30);
  
  w = new Wheel(new PVector(width/2, height/2), min(width/2, height/2) - 50, 24);
}

void draw(){
  background(255);
  w.display();
}

void mousePressed(){
  w.mouseClick();
}

void keyPressed(){
  w.keyPress();
}
