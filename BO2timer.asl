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

//Plutonium
state("t6zm", "Plutonium R353")
{
	int tick:  	0x002AA13C, 0x14;		//Tick counter	 
	int round: 	0x004530D0, 0x4;		//Current round
}

//Plutonium
state("t6rzm", "Plutonium R334/R372")
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
		vars.startTick = ( old.round == 0 ? current.tick : 0 );
		return true;		
	} 
}

reset
{
	return current.round == 0;		
}

isLoading
{
	timer.CurrentPhase = ( DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() - vars.lastTickUpdate > 50 ? TimerPhase.Paused : TimerPhase.Running );
	return false;
}

gameTime
{
	return TimeSpan.FromMilliseconds( (current.tick - vars.startTick) * 50 );
}

split
{
	return current.round != old.round && settings[current.round.ToString()];
}


update
{
	if(current.tick != old.tick)
		vars.lastTickUpdate = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
}