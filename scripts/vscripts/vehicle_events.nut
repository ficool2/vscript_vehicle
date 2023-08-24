// Template script that passes mandatory events to vehicles and setups crosshair tracing for each player

ClearGameEventCallbacks();

::Vehicle_FindInCrosshair <- function(player)
{
	if (!vehicle)
	{
		local buttons = NetProps.GetPropInt(player, "m_nButtons");
		
		if ((buttons & IN_USE) || NetProps.GetPropBool(player, "m_bUsingActionSlot"))
		{	
			local eye_pos = player.EyePosition();
			local trace =
			{
				start = eye_pos,
				end = eye_pos + player.EyeAngles().Forward() * 192.0,
				ignore = player
			}
			
			TraceLineEx(trace);
			
			if (trace.hit && trace.enthit.GetClassname() == "prop_vehicle_driveable")
			{
				trace.enthit.GetScriptScope().Enter(player);
			}
		}
	}	
}

::PlayerThink <- function()
{
	Vehicle_FindInCrosshair(self);
	return 0.1;
}

function OnGameEvent_player_spawn(params)
{
	Vehicle_OnPlayerSpawn(params);
	
	local player = GetPlayerFromUserID(params.userid);
	if (player)
		AddThinkToEnt(player, "PlayerThink");
}

function OnGameEvent_player_death(params)
{
	Vehicle_OnPlayerDeath(params);
}

function OnGameEvent_player_disconnect(params)
{
	Vehicle_OnPlayerDisconnect(params);
}

function OnGameEvent_scorestats_accumulated_update(params)
{
	Vehicle_OnRoundReset(params);
}

function OnScriptHook_OnTakeDamage(params)
{
	Vehicle_OnTakeDamage(params);
}

__CollectGameEventCallbacks(this);