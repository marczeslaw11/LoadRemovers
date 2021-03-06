state("Game")
{
	bool isLoading : "Engine.dll", 0xF884, 0x1C8;
	string50 map   : "Engine.dll", 0x001E7EB8, 0x28, 0xA0, 0x0;
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
}

isLoading
{
	return current.isLoading;
}
