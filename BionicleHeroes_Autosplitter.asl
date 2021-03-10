state("Bionicle")
{
	int Level 	 : "Bionicle.exe", 0x24E4B4;	// current map
	float x_pos	 : "Bionicle.exe", 0x2171B8;	// camera's position
	float y_pos	 : "Bionicle.exe", 0x2171C0;	
	bool inMenu1 : "Bionicle.exe", 0x24E0E0;	// 1 when paused and in menu, 0 in loading screen
	bool inMenu2 : "Bionicle.exe", 0x24E0E8;	// 1 when paused and in menu, 1 in loading screen
	string32 cutscene : "Bionicle.exe", 0x030D6324, 0x540;		// path to played audio file
}

startup
{
	var pirakaNames = new Dictionary<int, string> {		// in order they're unlocked
		{2, "Vezok"},
		{3, "Avak"},
		{4, "Thok"},
		{6, "Reidak"},
		{1, "Hakann"},
		{5, "Zaktan"},
		{7, "Vezon"}
	};
	var LevelNames = new Dictionary<int, string> {			// in order they're unlocked
		{9,  "Piraka Bluff"},
		{10, "Smugglers Cove"},
		{11, "Shattered Wreck"},
		{12, "Vezok's Deluge"},
		{13, "Decrepit Dungeons"},
		{14, "Cleansing Plant"},
		{15, "Manacing Keep"},
		{16, "Avak's Dynamo"},
		{17, "Flooded Lowlands"},
		{18, "Mountain Path"},
		{19, "Blizzard Peaks"},
		{20, "Thok's Grotto"},
		{25, "Desert Outpost"},
		{26, "Bleak Refinery"},
		{27, "Ancient Citadel"},
		{28, "Reidak's Bastion"},
		{5,  "Scorched Earth"},
		{6,  "Volcanic Trail"},
		{7,  "Fiery Mine"},
		{8,  "Hakann's Pit"},
		{21, "Logging Post"},
		{22, "Ancient Forest"},
		{23, "Forgotten Shrine"},
		{24, "Zaktan's Chamber"},
		{29, "Vezon's Awakening"}
	};

	foreach (var piraka in pirakaNames)						// main categories - grouped by Piraka's name
	{
		settings.Add(piraka.Value, true, piraka.Value);
	}
	foreach (var setting in LevelNames)						// sub categories
	{
		settings.Add(setting.Key.ToString(), true, setting.Value, pirakaNames[((setting.Key-1)/4)]);		// specific level
		settings.Add(setting.Key.ToString() + "e", false, "Enter", setting.Key.ToString());					// check if entering
		settings.Add(setting.Key.ToString() + "l", true, "Leave", setting.Key.ToString());					// check if leaving
	}
	settings.Add("finalCS", true, "Vezon defeated", "29");	// final cutscene
}

start
{
	return 1 < current.x_pos && current.x_pos < 2 && -7 < current.y_pos && current.y_pos < -6 && current.Level == 3 && !old.inMenu1 && old.inMenu2;
}

split
{
	if (old.Level != current.Level)
	{
		return settings[current.Level.ToString() + "e"] || settings[old.Level.ToString() + "l"];
	}
	else if (old.cutscene != current.cutscene && current.cutscene == @"bigbad\bb_level_outro_alt.wgt" && settings["finalCS"])
	{
		return true;
	}
}
