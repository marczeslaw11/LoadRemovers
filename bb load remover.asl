state("Game")
{
	bool isLoading : "Engine.dll", 0xF884, 0x1C8;
	string50 map : "Engine.dll", 0x001E7EB8, 0x28, 0xA0, 0x0;
	byte isCSskip: "Engine.dll", 0x1D9308, 0x5C;
}

isLoading
{
	return current.isLoading;
}

start
{
	return (current.map=="CavePainting1.unr" && current.isCSskip==1);
}

startup
{
	settings.Add("levels", true, "Split entering these maps:");
	vars.splitSettings = new List<string> {
		"Glacier level",
		"First forest",
		"Hunter duel in first forest",
		"Slide race",
		"Lava land",
		"First hunter duel in lava land",
		"Second hunter duel in lava land",
		"Second forest",
		"First hunter duel in second forest",
		"Second hunter duel in second forest",
		"Salmon Run",
		"Final duel with hunter",
		"Secret totem cave",
	};
	settings.CurrentDefaultParent = "levels";
	foreach (string splits in vars.splitSettings) {
		settings.Add(splits, true);
	}
}

split
{
	if (old.map != current.map)
		{
		return ((settings["Glacier level"] && (current.map.ToLower() == "avalancherun.unr" || current.map.ToLower() == "avalancherun")) ||
			   (settings["First forest"] && (current.map.ToLower() == "aspenforest.unr" || current.map.ToLower() == "aspenforest")) ||
			   (settings["Hunter duel in first forest"] && (current.map.ToLower() == "asp_combat1.unr" || current.map.ToLower() == "asp_combat1")) ||
			   (settings["Slide race"] && (current.map.ToLower() == "icerun.unr" || current.map.ToLower() == "icerun")) ||
			   (settings["Lava land"] && (current.map.ToLower() == "valleyoffire.unr" || current.map.ToLower() == "valleyoffire")) ||
			   (settings["First hunter duel in lava land"] && (current.map.ToLower() == "vof_combat1.unr" || current.map.ToLower() == "vof_combat1")) ||
			   (settings["Second hunter duel in lava land"] && (current.map.ToLower() == "vof_combat2.unr" || current.map.ToLower() == "vof_combat2")) ||
			   (settings["Second forest"] && (current.map.ToLower() == "salmonforest.unr" || current.map.ToLower() == "salmonforest")) ||
			   (settings["First hunter duel in second forest"] && (current.map.ToLower() == "sal_combat1.unr" || current.map.ToLower() == "sal_combat1")) ||
			   (settings["Second hunter duel in second forest"] && (current.map.ToLower() == "sal_combat2.unr" || current.map.ToLower() == "sal_combat2")) ||
			   (settings["Salmon Run"] && (current.map.ToLower() == "salmon_run.unr" || current.map.ToLower() == "salmon_run")) ||
			   (settings["Final duel with hunter"] && (current.map.ToLower() == "final_battle.unr" || current.map.ToLower() == "final_battle")) ||
			   (settings["Secret totem cave"] && (current.map.ToLower() == "secrettotemcave.unr" || current.map.ToLower() == "secrettotemcave")));
		}
}
