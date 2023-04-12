long F(long x);

long M(long x){
	if ( x == 0)
		return 0;
	return x- F( M( x-1));
}
