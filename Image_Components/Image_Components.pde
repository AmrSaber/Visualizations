int image[][], labels[][];
int nextLabel, passNum, i, j;
DSU dsu;

HashMap<Integer, Integer> clrs;

float fontSize;
PFont arial;

float w, h;

boolean looping = true;

void setup(){
  size(600, 600);
  
  String lines[] = loadStrings("cat.txt");
  image = new int[lines.length][];
  for (int i = 0 ; i < lines.length ; ++i) {
    String bits[] = lines[i].split(" ");
    image[i] = int(bits);
  }
  
  clrs = new HashMap();
  labels = new int[image.length][image[0].length];
  dsu = new DSU(image.length * image[0].length);
  
  frameRate((image.length * image[0].length) / 10);
  w = (float) width/image[0].length;
  h = (float) height/image.length;
  fontSize = h/2;
  
  nextLabel = 1;
  passNum = 1;
  i = j = 0;
  
  arial = createFont("arial", fontSize);
  textFont(arial);
  
  drawImage();
  noLoop();
  looping = false;
}

void draw(){
  if (!looping) return;
  
  drawImage();
  
  if (passNum == 1) firstPass();
  else if (passNum == 2) secondPass();
  
  printLabels();
}

void drawImage(){
  stroke(0);
  strokeWeight(1);
  rectMode(CORNER);
  boolean end = false;
  
  for (int i = 0 ; i < image.length ; ++i) {
    for (int j = 0 ; j < image[i].length ; ++j) {
      if (passNum == 3) {
        fill(getClassColor(labels[i][j]));
        end = true;
      } else {
        if (image[i][j] == 1) fill(255);
        else fill(0);
      }
      rect(j * w, i * h, w, h);
    }
  }
  
  if (end) noLoop();
}

void printLabels() {  
  for (int ii = 0 ; ii < image.length ; ++ii) {
    for (int jj = 0 ; jj < image[i].length ; ++jj) {
      
      if(passNum == 1) fill(32, 64, 128);
      else if(passNum == 2) {
        if (ii < i || ii == i && jj < j) fill(32, 128, 64);
        else fill(32, 64, 128);
      }else fill(128, 32, 64);
      
      if (labels[ii][jj] != 0) {
        float tw = textWidth(labels[ii][jj] + "");
        text(labels[ii][jj] + "", jj * w + w/2 - tw/2, ii * h + h/2 + fontSize/2);
      }
    }
  }
}

void firstPass() {      
    if (i-1 >= 0 && image[i][j] == image[i-1][j] && j-1 >= 0 && image[i][j] == image[i][j-1]) {
      labels[i][j] = min(labels[i-1][j], labels[i][j-1]);
      dsu.merge(labels[i-1][j], labels[i][j-1]);
    } else if (j-1 >= 0 && image[i][j] == image[i][j-1]) {
      labels[i][j] = labels[i][j-1];
    } else if (i-1 >= 0 && image[i][j] == image[i-1][j]) {
       labels[i][j] = labels[i-1][j]; 
    }  else {
      labels[i][j] = nextLabel;
      ++nextLabel;
    }
    
    ++j;
    if (j == image[i].length) {
      ++i;
      j = 0;
    }
    if (i == image.length) {
      i = j = 0;
      passNum++;
    }
}

void secondPass() {
  labels[i][j] = dsu.root(labels[i][j]);
  
  ++j;
  if (j == image[i].length) {
    ++i;
    j = 0;
  }
  if (i == image.length) {
    i = j = 0;
    passNum++;
  }
}

color getClassColor(int id) {
  if (!clrs.containsKey(id)) clrs.put(id, color(random(256), random(256), random(256)));
  return clrs.get(id);
}

void keyPressed() {
  if (key == ' ') {
    if (looping) noLoop();
    else loop();
    looping = !looping;
  }
}
