state("HP", "US") 
{
	bool load : "Core.dll", 0x00095AD8, 0x4C;
}

state("HP", "EU") 
{
	bool load : "Core.dll", 0x00095AB8, 0x28;
}

init
{
	// Determine version from the last edit of Core.dll
	vars.gameModule = modules.First();
	vars.gamePath = vars.gameModule.FileName;
	vars.dllFileName = vars.gamePath + "/../Core.dll";
	vars.Date = File.GetLastWriteTime(vars.dllFileName);

	switch (vars.Date)
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

