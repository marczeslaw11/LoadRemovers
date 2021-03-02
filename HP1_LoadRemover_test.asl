state("HP", "US") 
{
	bool load : "Core.dll", 0x00095AD8, 0x4C;
}

state("HP", "EU") 
{
	bool load : "Core.dll", 0x00095AB8, 0x28;
}


init {
	switch (File.GetLastWriteTime(modules.First().FileName + "/../Core.dll") 
	{
		case "29.10.2001 16:16:10": {version = "US"; } break;
		case "21.10.2001 22:48:14": {version = "EU"; } break;
	}
}


start
{
	return current.load;
}

isLoading
{
	return current.load;
}



