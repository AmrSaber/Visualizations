class State {
  private final int SIZE = 8;
  private boolean grid[][], visC[], visR[], visMD[], visSD[];
  
  int r, c;
  
  State() {
    visC = new boolean[SIZE];
    visR = new boolean[SIZE];
    visMD = new boolean[2*SIZE];
    visSD = new boolean[2*SIZE];
    grid = new boolean[SIZE][SIZE];
  }

  State(State other) {
    this();
    cpyArr(other.visMD, this.visMD);
    cpyArr(other.visSD, this.visSD);
    cpyArr(other.visC, this.visC);
    cpyArr(other.visR, this.visR);
    
    for (int i = 0 ; i < other.grid.length ; ++i)
      for (int j = 0 ; j < other.grid[i].length ; ++j)
        this.grid[i][j] = other.grid[i][j];
    
    this.r = other.r;
    this.c = other.c;
  }
  
  void cpyArr(boolean from[], boolean to[]) {
    for (int i = 0 ; i < from.length ; ++i) to[i] = from[i];
  }
  
  boolean isValid(int r, int c) {
    return (r < SIZE && c < SIZE && !visR[r] && !visC[c] && !visMD[SIZE + r - c] && !visSD[r + c]);
  }

  void affect() {
    grid[r][c] = visC[c] = visMD[SIZE + r - c] = visSD[r + c] = true;
  }

  PVector[] getPositions() {
    ArrayList<PVector> ret = new ArrayList<PVector>();
    for (int i = 0; i < SIZE; ++i)
      for (int j = 0; j < SIZE; ++j)
        if (grid[i][j]) ret.add(new PVector(j, i));
    return ret.toArray(new PVector[0]);
  }
}
