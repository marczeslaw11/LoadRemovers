state("Gothic III Forsaken Gods")
{
	bool  loading  : "Game.dll", 0x000D1654, 0x3C, 0xA94;
	bool  unpaused : "Game.dll", 0x004513E8, 0x2C;
	float igt 	   : "Engine.dll", 0x006DF180, 0x330;
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
