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
