// HP5 autosplitter ver. 1.2 by Marczeslaw
// Works only with dedicated splits
// Check ReadMe.txt for instruction how to use and customise

state("hp") 
{
	string50 cutscene : 0x00884790, 0xC, 0x78, 0x24, 0x87;
	byte map: 0x000FE834, 0x3C;
}

startup
{
	settings.Add("autostart", true, "Autostart on first cutscene");
	settings.Add("splits", false, "Use dedicated Any& splits file (uploaded to Resources)");
	settings.Add("final", true, "Split on cutscene after defeating Voldemort");
	settings.SetToolTip("splits", "https://www.speedrun.com/hp5/resources");
}

start 
{
	return (current.cutscene != old.cutscene && current.cutscene == "LW_NEWGAME.vp6" && settings["autostart"]);
}

init
{
	vars.gamestate = 0;
}

update
{
	if (current.cutscene != old.cutscene)
	{
		if (current.cutscene == "LW_NEWGAME.vp6")									// starting new game
			{vars.gamestate = 10;}
		else if (current.cutscene == "GP04.vp6")									// leaving Grimmauld Place
			{vars.gamestate = 20;}
		else if (current.cutscene == "dh02_cs01_go_to_dada.vp6")					// enter DADA lesson
			{vars.gamestate = 30;}
		else if (current.cutscene == "DH03.vp6")									// detention
			{vars.gamestate = 40;}
		else if (current.cutscene == "DH04.vp6")									// talking with Sirius
			{vars.gamestate = 50;}
		else if (current.cutscene == "rr01.vp6")									// finding RoR
			{vars.gamestate = 60;}
		else if (current.cutscene == "LW_LOADGAME.vp6" && vars.gamestate == 60)		// first savewarp
			{vars.gamestate = 70;}
		else if (current.cutscene == "LW_LOADGAME.vp6" && vars.gamestate == 70)		// second savewarp
			{vars.gamestate = 80;}
		else if (current.cutscene == "RR26.vp6")									// kissing with Cho
			{vars.gamestate = 90;}
		else if (current.cutscene == "oc01_cs01.vp6")								// Dumbledore's office
			{vars.gamestate = 100;}
		else if (current.cutscene == "OC01.vp6")									// finishing first oclumency
			{vars.gamestate = 110;}
		else if (current.cutscene == "GP05.vp6")									// leaving grimmauld place
			{vars.gamestate = 120;}
		else if (current.cutscene == "DL03.vp6")									// after losing duel in RoR
			{vars.gamestate = 130;}
		else if (current.cutscene == "UH11.vp6")									// going to forest with Umbridge
			{vars.gamestate = 140;}
		else if (current.cutscene == "UH13.vp6")									// leaving Hogwarts
			{vars.gamestate = 150;}
		else if (current.cutscene == "mom_02_cs02_shotc.vp6")						// Sirius dies
			{vars.gamestate = 160;}
		else if (current.cutscene == "MOM4.vp6")									// winning oclumency with Voldie
			{vars.gamestate = 170;}

		else if (old.cutscene == "OCC_belltrix_kill.vp6"	||						// starting oclumency with Voldie
			old.cutscene == "OCC_sirius_blasted.vp6" 		||
			old.cutscene == "OCC_friends.vp6" 		 		||
			old.cutscene == "OCC_prophecy.vp6")
			{vars.gamestate = 165;}
	}
	else if (old.map == 36 && current.map == 60 && vars.gamestate == 130)			// leaving 5th floor corridor (after first speaker)
		{vars.gamestate = 135;} 
}

split
{
	if (settings["splits"])
		 {
		 	return (
			// by Metallicafan212: just for a bit better efficiency, only check curr cutscene vs last once 
			(current.cutscene != old.cutscene 	&& (current.cutscene == "GP01.vp6" 					||	// leaving Dudley
													current.cutscene == "GP04.vp6" 					||	// leaving Grimmauld Place
													current.cutscene == "dh02_cs01_go_to_dada.vp6" 	||	// enter DADA lesson
													current.cutscene == "DH03.vp6"	 				||	// detention
													current.cutscene == "DH04.vp6" 					||	// talking with Sirius
													current.cutscene == "rr01.vp6" 					||	// finding RoR
													current.cutscene == "LW_LOADGAME.vp6" 			||	// savewarp, laoding game
													current.cutscene == "RR26.vp6" 					||	// kissing with Cho
													current.cutscene == "oc01_cs01.vp6" 			||	// Dumbledore's office
													current.cutscene == "OC01.vp6" 					||	// finishing first oclumency
													current.cutscene == "GP05.vp6" 					||	// leaving grimmauld place
													current.cutscene == "DL03.vp6" 					||	// after losing duel in RoR
													current.cutscene == "UH11.vp6" 					||	// going to forest with Umbridge
													current.cutscene == "UH13.vp6" 					||	// leaving Hogwarts
													current.cutscene == "mom_02_cs02_shotc.vp6" 	||	// Sirius dies
													current.cutscene == "MOM4.vp6"))				||	// winning oclumency with Voldie																								
			(old.map == 3  && current.map == 4  && vars.gamestate == 10)  || 	// from Ginny to Hermione
			(old.map == 4  && current.map == 2  && vars.gamestate == 10)  || 	// from Hermione to Ron
			(old.map == 42 && current.map == 30 && vars.gamestate == 40)  ||	// from GS to 2nd floor corridor
			(old.map == 11 && current.map == 13 && vars.gamestate == 130) ||	// enter clocktower during pranks
			(old.map == 60 && current.map == 36 && vars.gamestate == 130) ||	// enter 5th floor corridor for 1st time
			(old.map == 73 && current.map == 70 && vars.gamestate == 135) ||	// leave transfig through 1st floor corridor during pranks
			(old.map == 42 && current.map == 15) ||		// entering commonroom
			(old.map == 53 && current.map == 30) ||		// leaving library
			(old.map == 17 && current.map == 20) ||		// leaving DADA
			(old.map == 29 && current.map == 42) ||		// leaving 1st floor
			(old.map == 75 && current.map == 44) ||		// leaving trophy room
			(old.map == 25 && current.map == 5)  ||		// way to boathouse
			(old.map == 1  && current.map == 59) ||		// entering paved courtyard
			(old.map == 59 && current.map == 28) ||		// leaving paved courtyard
			(old.map == 52 && current.map == 50) ||		// leaving hospital wing
			(old.map == 68 && current.map == 46) ||		// get close to Hagrid's Hut
			(old.map == 56 && current.map == 57) ||		// enter owlery
			(old.map == 23 && current.map == 24) ||		// leaving dungeons
			(old.map == 56 && current.map == 68) || 	// leave owlery
			(old.map == 28 && current.map == 59) ||		// entering paved courtyard
			(((
				current.cutscene == "OCC_belltrix_kill.vp6"  ||				// splits on starting Oclumency vs Voldie
				current.cutscene == "OCC_sirius_blasted.vp6" ||
				current.cutscene == "OCC_friends.vp6" 		 ||
				current.cutscene == "OCC_prophecy.vp6"		 )
				&& current.cutscene != old.cutscene && vars.gamestate == 160)	
			)
			);
		}
	else if (settings["final"])
	{
		return current.cutscene != old.cutscene && current.cutscene == "MOM4.vp6";
	}
}
