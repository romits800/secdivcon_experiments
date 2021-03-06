#include "kruskal.h"

//static 
int find(int x, int par[]) 
{
  int result = x; 
  int result2 = -1;
  if (par[x] != x) {
    result = find(par[x], par);
  } else {
    result2 = find(par[x], par);
  }
  return result;
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

  int idx2 = 0;
  int mst2[len];
  int par2[len];

  for (int i=1; i < len; i += 2)
  {
    int src = find(g[i], par);
    int tgt = find(g[i + 1], par);

    if (src != tgt) {
      mst[++idx] = src;
      mst[++idx] = tgt;
      par[src] = tgt;
    } else {
      mst2[++idx2] = src;
      mst2[++idx2] = tgt;
      par2[src] = tgt;
    }
  }

  mst[0] = idx / 2 + 1;
}
