int SecMult(int a, int b, int a0, int b0, int r0){
    int a1;
    int b1;
    int c0, c1;
    int r0_prime, p0;
    int p0_1;
    int c0_1, c1_1, res;
    // (* Presharing a *)
    // a0 = $distr;
    a1 = a ^ a0;
    // (* Presharing b *)
    // b0 = $distr;
    b1 = b ^ b0;
    // (* c = a * b *)
    c0 = a0 * b0;
    c1 = a1 * b1;
    // r0 = $distr;
    p0 = a0 * b1;
    r0_prime = r0 ^ p0;
    
    p0_1 = a1 * b0;
    r0_prime = r0_prime ^ p0_1;

    c0_1 = c0 ^ r0;
    c1_1 = c1 ^ r0_prime;
    // This is a*b but that is a secret value
    //res = c0_1 ^ c1_1;
    res = c1_1 ^ c0_1;
    return res;
  }
