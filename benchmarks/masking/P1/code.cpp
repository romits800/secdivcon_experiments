//P1, AES shift rows
unsigned compute(unsigned r1, unsigned r2, unsigned st2_orig, unsigned st10_orig){
  unsigned r25;
  unsigned r24;
  unsigned st2;
  unsigned sTT2;
  unsigned st10;
  unsigned sTT10;
  st10 = st10_orig ^ r1;
  st2 = st2_orig ^ r1;
  r24  = st2 ^0;
  r25  = st10 ^0;
  sTT2 = r25 ^ 0;
  sTT10 = r24 ^ 0;
  return(sTT2 - sTT10);
} 
