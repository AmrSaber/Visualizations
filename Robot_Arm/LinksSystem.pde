class LinksSystem {
  ArrayList<Link> links;
  ArrayList<Slider> angleSliders, lengthSliders;
  Button plusButton, minusButton, clearButton;

  PVector origin;

  final float dy = 20;
  float nextY;

  LinksSystem(PVector origin) {
    this.origin = origin.copy();
    this.links = new ArrayList<Link>();
    this.angleSliders = new ArrayList<Slider>();
    this.lengthSliders = new ArrayList<Slider>();

    this.plusButton = new Button(new PVector(width - 30, 30), true);
    this.minusButton = new Button(new PVector(width - 80, 30), false);
    this.clearButton = new Button(new PVector(width - 130, 30), true);

    this.nextY = dy;
  }

  void addLink(float len) {
    Link newLink = new Link(len);

    int lastIndex = links.size() - 1;
    if (lastIndex != -1) {
      Link prnt = links.get(lastIndex);
      prnt.child = newLink;
      newLink.parent = prnt;
    }

    links.add(newLink);

    Slider angleSlider = new Slider(new PVector(20, nextY));
    angleSlider.setRange(-PI, PI);
    angleSlider.value = 0;
    angleSliders.add(angleSlider);

    Slider lengthSlider = new Slider(new PVector(140, nextY));
    lengthSlider.setRange(len/3, 3*len);
    lengthSlider.value = len;
    lengthSliders.add(lengthSlider);

    nextY += dy;
  }

  void popLink() {
    if (links.size() == 0) return;

    int lastIndex = links.size() - 1;

    links.remove(lastIndex);
    angleSliders.remove(lastIndex);
    lengthSliders.remove(lastIndex);

    if (lastIndex > 0) links.get(lastIndex - 1).child = null;

    nextY -= dy;
  }

  float getLinkAngle(int index) {
    return links.get(index).angle;
  }

  void setLinkAngle(int index, float angle) {
    links.get(index).angle = angle;
  }

  float getLinkLength(int index) {
    return links.get(index).len;
  }

  void setLinkLength(int index, float newLength) {
    links.get(index).len = newLength;
  }

  void run() {
    this.update();
    this.show();
  }

  void clear() {
    links.clear();
    angleSliders.clear();
    lengthSliders.clear();
    this.nextY = 20;
  }

  void update() {
    for (int i = 0; i < links.size(); ++i) {
      Link link = links.get(i);
      float angle = angleSliders.get(i).value;
      float len = lengthSliders.get(i).value;
      link.angle = angle;
      link.len = len;
    }

    if (this.plusButton.isClicked()) this.addLink(50);
    if (this.minusButton.isClicked()) this.popLink();
    if (this.clearButton.isClicked()) this.clear();
  }

  void show() {
    for (Slider s : angleSliders) s.show();
    for (Slider s : lengthSliders) s.show();
    this.plusButton.show();
    this.minusButton.show();

    pushMatrix();
    translate(this.clearButton.origin.x, this.clearButton.origin.y);
    rotate(PI/4);
    translate(-this.clearButton.origin.x, -this.clearButton.origin.y);
    this.clearButton.show();
    popMatrix();

    noStroke();
    fill(0, 0, 255, 200);
    ellipseMode(RADIUS);
    ellipse(origin.x, origin.y, 5, 5);

    if (this.links.size() == 0) return;

    pushMatrix();
    translate(origin.x, origin.y);

    links.get(0).update();
    links.get(0).show();

    popMatrix();
  }

  void onMouseDown() {
    this.plusButton.onMouseDown();
    this.minusButton.onMouseDown();
    this.clearButton.onMouseDown();

    for (Slider s : angleSliders) s.onMouseDown();
    for (Slider s : lengthSliders) s.onMouseDown();
  }

  void onMouseUp() {
    for (Slider s : angleSliders) s.onMouseUp();
    for (Slider s : lengthSliders) s.onMouseUp();
  }

  void onMouseDrag() {
    for (Slider s : angleSliders) s.onMouseDrag();
    for (Slider s : lengthSliders) s.onMouseDrag();
  }
}
