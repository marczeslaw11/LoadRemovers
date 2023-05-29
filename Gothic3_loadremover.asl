state("Gothic3")
{
	bool  loading  : 0x0002638C, 0xF0, 0x8, 0x20, 0x4, 0xE68;
	bool  unpaused : "Game.dll", 0x003F54B0, 0x2C;
	float igt 	   : "Engine.dll", 0x00614BD0, 0x330;
}

startup
{
	vars.currentRunTime = 0;
}

onReset
{
	vars.currentRunTime = 0;
}

start 
{
	return !current.loading && old.loading;
}

gameTime
{
	if (!current.loading && !current.unpaused) {
		return;
	}

	if (!old.loading && !old.unpaused) {
		vars.currentRunTime = System.TimeSpan.Parse(timer.CurrentTime.GameTime.ToString()).TotalMilliseconds;
	}

	if (current.igt - old.igt <= 0 ||
		(current.igt - old.igt) * 7200 > 0.1) {
		return System.TimeSpan.FromMilliseconds(vars.currentRunTime);
	}

	vars.currentRunTime += (current.igt - old.igt) * 7200 * 1000;
	return System.TimeSpan.FromMilliseconds(vars.currentRunTime);
}

isLoading
{
	return current.loading || current.unpaused;
}
