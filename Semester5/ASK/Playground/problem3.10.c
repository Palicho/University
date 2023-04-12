short arith3(short x, short y, short z){
	short p1= y | z;
	short p2 = p1 >> 9;
	short p3 = ~(p2);
	short p4 = y - p3;
	return p4;
}
