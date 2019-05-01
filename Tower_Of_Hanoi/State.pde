class State{
  int n, from, to;
  
  State(int _n, int _from, int _to) {
    this.n = _n;
    this.from = _from;
    this.to = _to;
  }
  
  void print() {
    println(String.format("State.. N: %d, from: %d, to: %d", n, from, to));
  }
}
