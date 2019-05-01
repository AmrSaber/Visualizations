class DSU {
  int prnt[];
  
  DSU(int size) {
    prnt = new int[size];
    for (int i = 0 ; i < size ; ++i) prnt[i] = i;
  }
  
  int root(int i) {
    if (prnt[i] == i) return i;
    return (prnt[i] = root(prnt[i]));
  }
  
  void merge(int i, int j) {
    int nw = min(root(i), root(j));
    prnt[root(i)] = prnt[root(j)] = nw;
  }
}
