long M(long x);

long F(long x){
	if ( x == 0)
		return 1;
	return M( F(x-1));
}
