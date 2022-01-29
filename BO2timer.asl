//Redacted
state("t6zmv41", "Redacted")
{
	int tick: 	0x002AA13C, 0x14;		//Tick counter	
	int round: 	0x004530D0, 0x4;		//Current round
}

//Plutonium
state("plutonium-bootstrapper-win32", "Plutonium")
{
	int tick:  	0x002AA13C, 0x14;		//Tick counter	 
	int round: 	0x004530D0, 0x4;		//Current round
}

startup
{
	refreshRate = 100;
	settings.Add("rounds", true, "Round splits");
	
	for(int i = 2; i <= 255; i++)
		settings.Add(Convert.ToString(i), false, Convert.ToString(i), "rounds");
}

start
{
	if(current.round > 0)
	{
		refreshRate = 20;
		vars.startTick = ( old.round == 0 ? current.tick : 0 );
		return true;		
	} 
}

reset
{
	if(current.round == 0)
	{
		refreshRate = 100;
		return true;	
	}
		
}

isLoading
{
	timer.CurrentPhase = ( current.tick == old.tick ? TimerPhase.Paused : TimerPhase.Running );
	return false;
}

gameTime
{
	return TimeSpan.FromMilliseconds( (current.tick - vars.startTick) * 50 );
}

split
{
	if(current.round != old.round && settings[current.round.ToString()])
		return true;
}
