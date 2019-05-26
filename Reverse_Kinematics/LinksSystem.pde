class LinksSystem {
  PVector origin;
  ArrayList<Link> links;

  Button plusButton, minusButton, clearButton;

  LinksSystem(PVector origin) {
    this.origin = origin;
    this.links = new ArrayList<Link>();

    this.plusButton = new Button(new PVector(width - 30, 30), true);
    this.minusButton = new Button(new PVector(width - 80, 30), false);
    this.clearButton = new Button(new PVector(width - 130, 30), true);
  }

  void addLink(float len) {
    this.links.add(new Link(len));
  }

  void popLink() {
    int size = this.links.size();
    if (size != 0) this.links.remove(size-1);
  }

  void clear() {
    this.links.clear();
  }

  void follow(PVector target) {
    int size = this.links.size();
    if (size == 0) return;

    // make the last link follow the target
    Link last = this.links.get(size-1);
    last.follow(target);

    // propagate the "follow", so the system stays connected
    for (int i = size - 2; i >= 0; --i) {
      Link current = this.links.get(i);
      Link child = this.links.get(i+1);
      current.follow(child.start);
    }

    // shift system to origin
    PVector shift = PVector.sub(this.origin, this.links.get(0).start);

    for (Link link : this.links) {
      link.start.add(shift);
      link.end.add(shift);
    }
  }

  void update() {
    if (this.plusButton.isClicked()) this.addLink(50);
    if (this.minusButton.isClicked()) this.popLink();
    if (this.clearButton.isClicked()) this.clear();
  }

  void show() {
    for (Link link : links) link.show();

    this.plusButton.show();
    this.minusButton.show();

    pushMatrix();
    translate(this.clearButton.origin.x, this.clearButton.origin.y);
    rotate(PI/4);
    translate(-this.clearButton.origin.x, -this.clearButton.origin.y);
    this.clearButton.show();
    popMatrix();

    noStroke();
    fill(255, 0, 0, 200);
    ellipseMode(RADIUS);
    ellipse(origin.x, origin.y, 5, 5);
  }

  void onMouseDown() {
    this.plusButton.onMouseDown();
    this.minusButton.onMouseDown();
    this.clearButton.onMouseDown();
  }
}
