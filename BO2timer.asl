//Redacted
state("t6zmv41", "Redacted")
{
	int frame: 0x00067800, 0x0;		//Tick counter	
	int round: 0x004530D0, 0x4;		//Current round
}

//Plutonium
state("plutonium-bootstrapper-win32", "Plutonium")
{
	int frame: 0x002E4000, 0x0;		//Tick counter	 
	int round: 0x004530D0, 0x4;		//Current round
}

startup
{
	settings.Add("rounds", true, "Round splits");
	
	for(int i = 2; i <= 255; i++)
	{
		settings.Add(Convert.ToString(i), false, Convert.ToString(i), "rounds");
	}
}

start
{
	if(current.round == 1)
	{
		vars.startFrame = current.frame;
		return true;
	} 
}

reset
{
	if(current.round == 0)
		return true;
}

isLoading
{
	if(current.frame == old.frame)
		timer.CurrentPhase = TimerPhase.Paused;
	else
		timer.CurrentPhase = TimerPhase.Running;
	return false;
}

gameTime
{
	return TimeSpan.FromMilliseconds(current.frame - vars.startFrame);
}

split
{
	if(current.round != old.round)
	{
		if(settings[current.round.ToString()])
			return true;
	}
}
