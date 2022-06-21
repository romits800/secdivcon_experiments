#include "kruskal.h"

//static 
/*
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
*/

int find(int x, int par[], int len) 
{
  int result = x; 
  int x2;
  int result2 = -1;
  volatile int res;
  for (int i = 0; i < len; i++) {
    if (par[x] == x) {
        result = x;
        x2 = par[x];
        res = x2;
    } else {
        result2 = x;
        x = par[x];
        res = result2;
    }
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

  for (int i=1; i < len; i += 2)
  {
    int src = find(g[i], par, len);
    int tgt = find(g[i + 1], par, len);

    if (src != tgt)
    {
      mst[++idx] = src;
      mst[++idx] = tgt;
      par[src] = tgt;
    }
  }

  mst[0] = idx / 2 + 1;
}
