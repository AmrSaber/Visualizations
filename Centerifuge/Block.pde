class Block{
  boolean isChecked;
  PVector center;
  
  float size = 30;
  
  Block(){
    this.center = new PVector();
    this.isChecked = false;
  }
  
  void mouseClick(){
    PVector dist = PVector.sub(new PVector(mouseX, mouseY), this.center);
    if (dist.mag() <= size/2) {
      this.isChecked = !this.isChecked;
    }
  }
  
  void display(){
    strokeWeight(1);
    stroke(0);
    if (this.isChecked) {
      fill(51);
    } else {
      fill(255);
    }
    
    ellipse(this.center.x, this.center.y, size, size);
  }
}
