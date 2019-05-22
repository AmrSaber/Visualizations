class Slider {
  PVector origin;
  
  boolean selected;
  final float len, selectRadius;
  float value, minValue, maxValue;
  
  Slider(PVector origin) {
    this.origin = origin.copy();
    this.selected = false;
    
    this.len = 100;
    this.minValue = 0;
    this.maxValue = 100;
    this.selectRadius = 7;
  }
  
  void setRange(float minValue, float maxValue) {
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = minValue;
  }
  
  void setValue(float value) {
    this.value = value;
  }
  
  void onMouseDrag() {
    if (!selected) return;
    float mouseValue = constrain(mouseX * 1f, origin.x, origin.x + len);
    this.value = map(mouseValue, origin.x, origin.x + len, minValue, maxValue);
  }
  
  void onMouseDown() {
    PVector mouseVec = new PVector(mouseX, mouseY);
    float pos = map(value, minValue, maxValue, origin.x, origin.x + len);
    float diff = PVector.sub(mouseVec, new PVector(pos, origin.y)).mag();
    
    if (diff <= this.selectRadius) this.selected = true;
  }
  
  void onMouseUp() {
    this.selected = false;
  }
  
  void show() {
    stroke(255, 100);
    strokeWeight(5);
    line(origin.x, origin.y, origin.x + len, origin.y);
    
    noStroke();
    strokeWeight(0);
    if (selected) fill(255, 0, 0);
    else fill(255);
    
    ellipseMode(RADIUS);
    float pos = map(value, minValue, maxValue, 0, len);
    ellipse(origin.x + pos, origin.y, this.selectRadius, this.selectRadius);
  } 
}
