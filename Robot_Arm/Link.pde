class Link {
  float len, angle, t = 0;
  Link child, parent;

  Link(float len) {
    this.len = len;
    this.angle = 0;
    this.child = this.parent = null;
  }

  void update() {
    if (true) return;
    if (child != null) child.update();
  }

  void show() {
    stroke(255, 150);
    strokeWeight(5);

    pushMatrix();
    rotate(this.angle);

    line(0, 0, len, 0);

    if (this.child != null) {
      translate(len, 0);
      this.child.show();
    }

    popMatrix();
  }
}
