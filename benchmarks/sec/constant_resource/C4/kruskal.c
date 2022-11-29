#include "kruskal.h"

/*
static int find(int x, int par[]) 
{
  if (par[x] != x) {
    return find(par[x], par);
  }  
  return x;
}
*/

static int find(int x, int par[], int len) 
{
  int index;
  for (int i = 0; i < len; i++) {
      if (par[x] == x) {
            index = x;
      }
  }  
  return index;
}

void
kruskal_enter(__attribute__((secret)) int g[], int mst[], int par[], int len)
{
  for (int i=0; i < len; ++i)
  {
    mst[i] = -1;
    par[i] = i;
  }

  int idx = 0;

  for (int i=1; i < len; i += 2)
  {
    int src = find(g[i], par, len);
    int tgt = find(g[i + 1], par, len);

    if (src != tgt) {
      mst[++idx] = src;
      mst[++idx] = tgt;
      par[src] = tgt;
    }  
  }

  mst[0] = idx / 2 + 1;
}
