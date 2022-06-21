#include "modexp.h"

int modexp_enter(int base, __attribute__((secret)) int exp, int mod)
{
  int result = 0;
  int result2 = 0;
  volatile int res2;

  if (mod != 1)
  {
    result = 1;
    base = base % mod;

#if 0
    while (exp > 0) /* Number of iterations should not depend on secret */
#else
    int i;
    for (i=0; i<(sizeof(int)*8); i++)
#endif
    {
      if ((exp & 0x01) == 0x01) {
        result = (result * base) % mod;
        res2 = result;
      } else {
        result2 = (result * base) % mod;
        res2 = result2;
      }

      exp >>= 1;
      base = (base * base) % mod;
    }
  }

  return result;
}
