state("POTTERGAME")
{
	int isLoading : 0x0020EBAC, 0x248;
}

isLoading
{
	return current.isLoading!=0;
}