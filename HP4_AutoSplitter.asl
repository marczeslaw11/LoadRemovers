state("gof_f")
{
    string20 map : 0x530020;
    bool isLoading: 0x51F368;
    byte isCutscene: 0x0038ADA0, 0x3C4;
    byte health: 0x38ADD0, 0x4, 0x8C, 0x24, 0x18, 0x4, 0x34, 0x78;
}

init
{
	vars.Voldie = 0;
	vars.gameRunning = true;
}

startup
{
	settings.Add("leave-map", true, "Split when leaving the map");
	settings.Add("final-split", true, "Split when beating the Voldemort (let marczeslaw know if there're issues)");
}


update
{
	if (current.map == "lvl_012_Voldemort")
	{
		if (old.map != "lvl_012_Voldemort")
			{vars.Voldie = 0;}
		if (old.isCutscene != current.isCutscene)
			{vars.Voldie++;}
		else if (old.health != 0 && current.health == 0)
			{vars.Voldie = 4;}
	}
}

split
{
    return ((old.map != "FrontEnd_EndOfLevel" && current.map == "FrontEnd_EndOfLevel" && settings["leave-map"]) || 
    	(vars.Voldie == 15 && (old.isCutscene != current.isCutscene) && settings["final-split"]));
}

start 
{
    return (old.map == "FrontEnd_CharacterSe" && current.map == "lvl_001_CampsiteWood");
}

isLoading
{
    return current.isLoading && vars.gameRunning;
}

exit
{
    vars.gameRunning = false;
}
