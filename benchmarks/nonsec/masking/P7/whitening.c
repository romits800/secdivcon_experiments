#define MASK(i)  st ## i = pt ## i ^ (key ## i ^ mask ## i)
void whitening(unsigned char key0, unsigned char key1, unsigned char key2, unsigned char key3, 
               unsigned char key4, unsigned char key5, unsigned char key6, unsigned char key7, 
               unsigned char key8, unsigned char key9, unsigned char key10, unsigned char key11, 
               unsigned char key12, unsigned char key13, unsigned char key14, unsigned char key15, 
               unsigned char pt0, unsigned char pt1, unsigned char pt2, unsigned char pt3, 
               unsigned char pt4, unsigned char pt5, unsigned char pt6, unsigned char pt7, 
               unsigned char pt8, unsigned char pt9, unsigned char pt10, unsigned char pt11, 
               unsigned char pt12, unsigned char pt13, unsigned char pt14, unsigned char pt15, 
               unsigned char mask0, unsigned char mask1, unsigned char mask2, unsigned char mask3, 
               unsigned char mask4, unsigned char mask5, unsigned char mask6, unsigned char mask7, 
               unsigned char mask8, unsigned char mask9, unsigned char mask10, unsigned char mask11, 
               unsigned char mask12, unsigned char mask13, unsigned char mask14, unsigned char mask15) { 

   volatile unsigned char   st0,  st1,  st2,  st3, 
                            st4,  st5,  st6,  st7, 
                            st8,  st9,  st10,  st11, 
                            st12,  st13,  st14,  st15;
   MASK(0);
   MASK(1);
   MASK(2);
   MASK(3);
   MASK(4);
   MASK(5);
   MASK(6);
   MASK(7);
   MASK(8);
   MASK(9);
   MASK(10);
   MASK(11);
   MASK(12);
   MASK(13);
   MASK(14);
   MASK(15);

}
