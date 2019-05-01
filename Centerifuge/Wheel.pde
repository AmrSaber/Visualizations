class Wheel {
  PVector center;
  float radius;

  PVector indicator, iVel, iAcc;
  float innerRadius;
  float indicatorRadius;

  private ArrayList<Block> blocks;

  float rotationAngle;
  boolean rotating;

  Wheel(PVector center, float radius, int n) {
    this.center = center;
    this.radius = radius;
    this.innerRadius = this.radius / 4;
    this.indicatorRadius = 5;

    this.rotating = false;
    this.rotationAngle = 0;

    this.indicator = new PVector();
    this.iVel = new PVector();
    this.iAcc = new PVector();

    this.blocks = new ArrayList();
    for (int i = 0; i < n; ++i) {
      Block block = new Block();
      float angle = map(i, 0, n, 0, TWO_PI);
      float r = this.radius - block.size/2 - 20;
      float x = r * cos(angle);
      float y = r * sin(angle);
      block.center = new PVector(this.center.x + x, this.center.y + y);
      this.blocks.add(block);
    }
  }

  void display() {

    if (rotating) {
      rotationAngle = (rotationAngle + 0.01) % TWO_PI;

      for (int i = 0; i < blocks.size(); ++i) {
        float angle = map(i, 0, this.blocks.size(), 0, TWO_PI) + rotationAngle;
        float r = this.radius - blocks.get(i).size/2 - 20;
        float x = r * cos(angle);
        float y = r * sin(angle);
        blocks.get(i).center = new PVector(this.center.x + x, this.center.y + y);
      }
    }

    for (Block b : blocks) {
      if (b.isChecked) {
        PVector force = PVector.sub(b.center, PVector.add(this.center, this.indicator));
        force.mult(0.3);
        this.iAcc.add(force);
      }
    }

    if (this.iAcc.mag() <= 2) this.iAcc.mult(0);

    this.iAcc.limit(12);

    PVector force = PVector.mult(this.indicator, -1);
    force.mult(0.3);
    this.iAcc.add(force);

    this.iVel.add(this.iAcc);
    this.iVel.mult(0.4);
    this.iVel.limit(5);

    this.indicator.add(this.iVel);
    this.indicator.limit(this.innerRadius - this.indicatorRadius);

    this.iAcc.mult(0);

    strokeWeight(1);
    stroke(0);

    // the main wheel
    fill(32, 64, 128, 150);
    ellipse(this.center.x, this.center.y, this.radius*2, this.radius*2);

    for (Block b : blocks) {     
      stroke(0);
      PVector dir = PVector.sub(this.center, b.center);
      dir.normalize();

      PVector start = PVector.add(this.center, PVector.mult(dir, innerRadius));
      PVector end = PVector.add(b.center, PVector.mult(dir, -b.size/2)); 
      line(start.x, start.y, end.x, end.y);
    }

    // the inner circle
    fill(255);
    ellipse(this.center.x, this.center.y, this.innerRadius*2, this.innerRadius*2);

    // mark the incdicator center
    fill(32, 64, 128);
    ellipse(this.center.x, this.center.y, 5, 5);

    // the indicator
    fill(200, 32, 64);
    ellipse(this.center.x + this.indicator.x, this.center.y + this.indicator.y, this.indicatorRadius*2, this.indicatorRadius*2);

    // the blocks
    for (Block b : blocks) {
      b.display();
    }
  }

  void mouseClick() {
    for (Block b : blocks) {
      b.mouseClick();
    }
  }

  void keyPress() {
    if (key == 'c' || key == 'C') this.clear();
    if (key == ' ' || key == ' ') this.toggleRotation();
    if (key == 'n' || key == 'N') this.randomize();
  }

  void clear() {
    for (Block b : blocks) b.isChecked = false;
  }

  void toggleRotation() {
    this.rotating = !this.rotating;
  }

  void randomize() {
    for (Block b : blocks) b.isChecked = random(1) < 0.4;
  }
}
