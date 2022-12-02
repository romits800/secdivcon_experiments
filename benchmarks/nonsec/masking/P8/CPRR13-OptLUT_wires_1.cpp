//#include <iostream>

unsigned OptLUT(unsigned x, unsigned x0, unsigned r1_01, unsigned p1_01, unsigned r2_01, unsigned p2_01, unsigned r3, unsigned r4, unsigned Ox51)
{
    //unsigned x; //secret
    //unsigned x0, r1_01, p1_01, r2_01, p2_01, r3, r4; //random variable
    //unsigned x1, z0_0, z0_1, t1, r1_10, y0, y1, w0_0, w0_1, t2, r2_10, t3_0, t3_1, p3, r3_prime, t4_0, t4_1, p4, r4_prime;
    unsigned x1, z0_0, z0_1, t1, r1_10,t1_s1, r1_10_s1, t1_s2, t1_s3, r1_10_s2, t1_s4, r1_10_s3, y0, y0_s1, y1, y1_s1;
    unsigned w0_0, w0_1, t2, r2_10, t2_s1, r2_10_s1, t2_s2, t2_s3;
    x1 = x ^ x0;
    z0_0 = x0; //z0_0 = pow2 x0;
    z0_1 = x1; //z0_1 = pow2 x1;
    //(* y = x * (pow2 x) *)
    //r1_01 = $distr;
    //p1_01 = $distr;
    t1 = x0 ^ p1_01;
    //t1 = lut2 t1;
    r1_10 = r1_01 ^ t1;
    t1_s1 = x1 ^ p1_01;
    //t1 = lut2 t1;
    r1_10_s1 = r1_10 ^ t1_s1;
    t1_s2 = x0 ^ p1_01;
    t1_s3 = t1_s2 ^ x1;
    //t1 = lut2 t1;
    r1_10_s2 = r1_10_s1 ^ t1_s3;
    t1_s4 = p1_01;//t1 = lut2 p1_01;
    r1_10_s3 = r1_10_s2 ^ t1_s4;
    y0 = x0; //y0 = lut2 x0;
    y0_s1 = y0 ^ r1_01;
    y1 = x1;//y1 = lut2 x1;
    y1_s1 = y1 ^ r1_10_s3;//y1 = y1 ^ r1_10;
    w0_0 = y0_s1; //w0_0 = pow4 y0;
    w0_1 = y1_s1; //w0_1 = pow4 y1;
    //(* y = y * (pow4 y) *)
    //r2_01 = $distr;
    //p2_01 = $distr;
    t2 = y0_s1 ^ p2_01;
    //t2 = lut4 t2;
    r2_10 = r2_01 ^ t2;
    t2_s1 = y1_s1 ^ p2_01;
    //t2 = lut4 t2;
    r2_10_s1 = r2_10 ^ t2_s1;
    t2_s2 = y0_s1 ^ p2_01;
    t2_s3 = t2_s2 ^ y1;
    //t2 = lut4 t2;
    unsigned r2_10_s2, t2_s4, r2_10_s3, y0_s2, y1_s2, t3_0, t3_1, p3;
    unsigned r3_prime, p3_s1, r3_prime_s1, y0_s3, y1_s3, t4_0, t4_1, p4;
    unsigned r4_prime, p4_s1, r4_prime_s1, y0_s4, y1_s4, y0_s5;
    r2_10_s2 = r2_10_s1 ^ t2_s3;
    t2_s4 = p2_01;//t2 = lut4 p2_01;
    r2_10_s3 = r2_10_s2 ^ t2_s4;
    //y0 = lut4 y0;
    y0_s2 = y0_s1 ^ r2_01;
    //y1 = lut4 y1;
    y1_s2 = y1_s1 ^ r2_10_s3;
    //(* y0 = exp y 16 *)
    //y0 = pow16 y0;
    //y1 = pow16 y1;
    //(* y = y * w0_ *)
    t3_0 = y0_s2 * w0_0;
    t3_1 = y1_s2 * w0_1;
    //r3 = $distr;
    p3 = y0_s2 * w0_1;
    r3_prime = r3 ^ p3;
    p3_s1 = y1_s2 * w0_0;
    r3_prime_s1 = r3_prime ^ p3_s1;
    y0_s3 = t3_0 ^ r3;
    y1_s3 = t3_1 ^ r3_prime_s1;
    //(* y = y * z0_ *)
    t4_0 = y0_s3 * z0_0;
    t4_1 = y1_s3 * z0_1;
    //r4 = $distr;
    p4 = y0_s3 * z0_1;
    r4_prime = r4 ^ p4;
    p4_s1 = y1_s3 * z0_0;
    r4_prime_s1 = r4_prime ^ p4_s1;
    y0_s4 = t4_0 ^ r4;
    y1_s4 = t4_1 ^ r4_prime_s1;
    //(* y = affineF y *)
    //y0 = affineF y0;
    //y1 = affineF y1;
    y0_s5 = y0_s4 ^ Ox51;
    return y0_s5 ^ y1_s4;
}
