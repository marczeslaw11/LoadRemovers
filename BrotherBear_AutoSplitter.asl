state("Game")
{
	bool isLoading : "Engine.dll", 0xF884, 0x1E8;
	string50 map   : "Engine.dll", 0x001E7EB8, 0x28, 0xA0, 0x0;
	bool FBDefeated : "Engine.dll", 0x001DB62C, 0x2C, 0x6E0, 0x344;
	bool inLauncher: "Window.dll", 0x49214;
	//byte isCSskip  : "Engine.dll", 0x1D9308, 0x5C;
}

startup
{
	var splitSettings = new Dictionary<string, string> {
		{     "aspenforest", "First forest" },
		{     "asp_combat1", "Hunter duel in first forest" },
		{          "icerun", "Slide race" },
		{    "valleyoffire", "Lava land" },
		{     "vof_combat1", "First hunter duel in lava land" },
		{     "vof_combat2", "Second hunter duel in lava land" },
		{    "salmonforest", "Second forest" },
		{     "sal_combat1", "First hunter duel in second forest" },
		{     "sal_combat2", "Second hunter duel in second forest" },
		{      "salmon_run", "Salmon Run" },
		{    "final_battle", "Final duel with hunter" }
	};
	
	settings.Add("levels", true, "Split entering these maps:");
	settings.Add("loading", true, "Split loading the save from launcher");
	settings.Add("end", true, "Split when Denahi's health bar disappears in the final battle");
	
	foreach (var setting in splitSettings)
		settings.Add(setting.Key, true, setting.Value, "levels");
}

start
{
	return old.map == "CavePainting1.unr" && current.map != "CavePainting1.unr";
}

split 
{
    if (old.map != current.map) 
    {
        return settings[current.map.Split('.')[0].ToLower()];
    }
    else if (old.inLauncher && !current.inLauncher)
    {
    	return settings["loading"];
    }
    else if (current.map == "Final_Battle.unr" && !old.FBDefeated && current.FBDefeated)
    {
    	return settings["end"];
    }
}

isLoading
{
	return current.isLoading && !current.inLauncher;
}

exit
{
    timer.IsGameTimePaused = false;
}
