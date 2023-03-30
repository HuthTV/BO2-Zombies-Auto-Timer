state("t6zmv41", "Redacted Christmas|Redacted LAN")
{
	int game_tick:		0x002AA13C, 0x14;	//Game ticks passed
	int round_number:	0x004530D0, 0x4;	//Current round number
	int memory_bank:	0x2623E00;		//Mem location for saving time data
	float z_coordinate:	0x1DC14FC;		//Player z cord
}

state("t6zm", "Plutonium R353")
{
	int game_tick:		0x002AA13C, 0x14;	//Game ticks passed
	int round_number:	0x004530D0, 0x4;	//Current round number
	int memory_bank:	0x2623E00;		//Mem location for saving time data
	float z_coordinate:	0x1DC14FC;		//Player z cord
}

state("t6rzm", "Plutonium R334|Plutonium R372")
{
	int game_tick:		0x002AA13C, 0x14;	//Game ticks passed
	int round_number:	0x004530D0, 0x4;	//Current round number
	int memory_bank:	0x2623E00;		//Mem location for saving time data
	float z_coordinate:	0x1DC14FC;		//Player z cord
}

startup
{
	refreshRate = 100;
	settings.Add("round_numbers", true, "round_number splits");
	for(int i = 2; i <= 255; i++)
		settings.Add(Convert.ToString(i), false, Convert.ToString(i), "round_numbers");
}

start
{
	if( current.round_number > 0 && current.game_tick > 0 || current.z_coordinate == 1336.125 && current.round_number == 0 )
	{
		vars.pausegame_ticks = 0;
		if(old.round_number == 0)
		{
			vars.startgame_tick = current.game_tick;
			game.WriteValue<UInt16>((IntPtr)game.MainModule.BaseAddress + 0x2623E00, (UInt16)current.game_tick);
		}	
		else
		{
			vars.startgame_tick = current.memory_bank;	
		}

		return true;		
	} 
}

reset
{
	return current.game_tick == 0;		
}

isLoading
{
	if(current.game_tick == old.game_tick)
	{
		if(vars.pausegame_ticks > refreshRate/25 )
		{
			timer.CurrentPhase = TimerPhase.Paused;
			return true;
		}
		else
		{
			vars.pausegame_ticks++;
			return false;
		}		
	}	
	else
	{
		vars.pausegame_ticks = 0;
		timer.CurrentPhase = TimerPhase.Running;
		return false;
	}
}

gameTime
{
	return TimeSpan.FromMilliseconds( (current.game_tick - vars.startgame_tick) * 50 );
}

split
{
	return current.round_number != old.round_number && settings[current.round_number.ToString()];
}