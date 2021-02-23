state("Game")
{
	bool isLoading : "Engine.dll", 0xF884, 0x1C8;
}

isLoading
{
	return current.isLoading;
}