class Button{
  PVector origin;
  int counter;
  float size;
  
  boolean isPlus;
  
  Button(PVector origin, boolean isPlus) {
    this.origin = origin.copy();
    this.counter = 0;
    this.size = 20;
    this.isPlus = isPlus;
  }
  
  void onMouseDown() {
    PVector mouseVec = new PVector(mouseX, mouseY);
    float diff = PVector.sub(origin, mouseVec).mag();
    if (diff <= size) ++counter;
  }
  
  void show() {
    noStroke();
    fill(255, 100);
    
    ellipseMode(RADIUS);
    ellipse(origin.x, origin.y, this.size, this.size);
    
    fill(255);
    rectMode(CENTER);
    rect(origin.x, origin.y, this.size , this.size / 4);
    if (isPlus) rect(origin.x, origin.y, this.size / 4, this.size);
  }
  
  boolean isClicked() {
    if (counter > 0) {
      --counter;
      return true;
    }
    return false;
  }
}
