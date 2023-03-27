state("t6zmv41", "Redacted")
{
	int tick: 	0x002AA13C, 0x14;		//Tick counter	
	int round: 	0x004530D0, 0x4;		//Current round
	int bank: 	0x2623E00;				//Started game tick
	float zcord: 	0x1DC14FC;				//Player z cord
}

/*
state("plutonium-bootstrapper-win32", "Plutonium")
{
	int tick: 	0x002AA13C, 0x14;		//Tick counter	
	int round: 	0x004530D0, 0x4;		//Current round
	int bank: 	0x2623E00;				//Started game tick
	float zcord: 	0x1DC14FC;				//Player z cord
}
*/

state("t6zm", "Plutonium R353")
{
	int tick: 	0x002AA13C, 0x14;		//Tick counter	
	int round: 	0x004530D0, 0x4;		//Current round
	int bank: 	0x2623E00;				//Started game tick
	float zcord: 	0x1DC14FC;				//Player z cord
}

state("t6rzm", "Plutonium R334/R372")
{
	int tick: 	0x002AA13C, 0x14;		//Tick counter	
	int round: 	0x004530D0, 0x4;		//Current round
	int bank: 	0x2623E00;				//Started game tick
	float zcord: 	0x1DC14FC;				//Player z cord
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
	if( current.round > 0 && current.tick > 0 || current.zcord == 1336.125 && current.round == 0 )
	{
		vars.pauseticks = 0;
		if(old.round == 0)
		{
			vars.startTick = current.tick;
			game.WriteValue<UInt16>((IntPtr)game.MainModule.BaseAddress + 0x2623E00, (UInt16)current.tick);
		}	
		else
		{
			vars.startTick = current.bank;	
		}

		return true;		
	} 
}

reset
{
	return current.tick == 0;		
}

isLoading
{
	if(current.tick == old.tick)
	{
		if(vars.pauseticks > refreshRate/25 )
		{
			timer.CurrentPhase = TimerPhase.Paused;
			return true;
		}
		else
		{
			vars.pauseticks++;
			return false;
		}		
	}	
	else
	{
		vars.pauseticks = 0;
		timer.CurrentPhase = TimerPhase.Running;
		return false;
	}
}

gameTime
{
	return TimeSpan.FromMilliseconds( (current.tick - vars.startTick) * 50 );
}

split
{
	return current.round != old.round && settings[current.round.ToString()];
}