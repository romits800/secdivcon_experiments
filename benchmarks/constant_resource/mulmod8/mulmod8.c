#include "mulmod8.h"

#define mulMask    0x00FF
#define mulModulus 0x0101

int mulmod8_enter(__attribute__((secret)) int a, int b)
{
  int p;
  int p2, a2, b2; // dummy variables - the compiler should not remove

  volatile int res;

  a2 &= mulMask;
  b2 &= mulMask;

  a &= mulMask;
  b &= mulMask;

  if (a == 0) // if secret
  {
    a = mulModulus - b; // minus is typically constant time
    // added nonce code
    p2 = a * b;
    b2 = p2 & mulMask;
    a2 = p2 >> 8;
    a2 = b2 - a2 + (b2 < a2 ? 1 : 0);
    res = a2;
  }
  else if (b == 0)
  {
    a = mulModulus - a; // minus is typically constant time
    // added nonce code
    p2 = a * a;
    b2 = p2 & mulMask;
    a2 = p2 >> 8;
    a2 = b2 - a2 + (b2 < a2 ? 0 : 1);
    res = a2;
  }
  else
  {
    // added nonce code
    a2 = mulModulus - b; // minus is constant time
    // Original code
    p = a * b;
    b = p & mulMask;
    a = p >> 8;
    a = b - a + (b < a ? 1 : 0);
    res = a2;
  }

  return a & mulMask;
}
