#include "mulmod8.h"

#define mulMask    0x00FF
#define mulModulus 0x0101

int mulmod8_enter(__attribute__((secret)) int a, int b)
{
  int p;

  a &= mulMask;
  b &= mulMask;

  if (a == 0) // if secret
  {
    a = mulModulus - b; // minus is typically constant time
  }
  else if (b == 0)
  {
    a = mulModulus - a; // minus is typically constant time
  }
  else
  {
    // Original code
    p = a * b;
    b = p & mulMask;
    a = p >> 8;
    a = b - a + (b < a ? 1 : 0);
  }

  return a & mulMask;
}
