//test

/* original version */
// unsigned compute(unsigned R, unsigned rx, unsigned x){
unsigned compute(unsigned pub, unsigned sec, unsigned rand){
    unsigned rsec;
    unsigned res;
    rsec = rand ^ sec;
    res = rsec ^ pub;
    return res;
} 
