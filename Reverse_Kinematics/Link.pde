class Link{
  PVector start, end;
  float len;
  
  Link(float len) {
    this.len = len;
    this.start = new PVector();
    this.end = new PVector();
  }
  
  void follow(PVector target) {
    PVector dir = PVector.sub(target, start);
    dir.setMag(this.len);
    dir.mult(-1);
    
    this.end = target.copy();
    this.start = PVector.add(this.end, dir);
  }
  
  void show() {
    stroke(255, 100);
    strokeWeight(4);
    line(start.x, start.y, end.x, end.y);
  }
}
