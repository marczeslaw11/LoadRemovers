state("Game")
{
	bool isLoading : "Engine.dll", 0xF884, 0x1C8;
	string19 map   : "Engine.dll", 0x001E7EB8, 0x28, 0xA0, 0x0;
	byte isCSskip  : "Engine.dll", 0x1D9308, 0x5C;
}

startup
{
	var splitSettings = new Dictionary<string, string> {
		{    "avalancherun.unr", "Glacier level" },
		{     "aspenforest.unr", "First forest" },
		{     "asp_combat1.unr", "Hunter duel in first forest" },
		{          "icerun.unr", "Slide race" },
		{    "valleyoffire.unr", "Lava land" },
		{     "vof_combat1.unr", "First hunter duel in lava land" },
		{     "vof_combat2.unr", "Second hunter duel in lava land" },
		{    "salmonforest.unr", "Second forest" },
		{     "sal_combat1.unr", "First hunter duel in second forest" },
		{     "sal_combat2.unr", "Second hunter duel in second forest" },
		{      "salmon_run.unr", "Salmon Run" },
		{    "final_battle.unr", "Final duel with hunter" },
		{ "secrettotemcave.unr", "Secret totem cave" }
	};
	
	settings.Add("levels", true, "Split entering these maps:");
	
	foreach (var setting in splitSettings)
		settings.Add(setting.Key, true, setting.Value, "levels");
}

start
{
	return current.map == "CavePainting1.unr" && current.isCSskip == 1;
}

split
{
	return old.map != current.map && settings[current.map.ToLower()];
}

isLoading
{
	return current.isLoading;
}
