# VScript Vehicles
Allows [prop_vehicle_driveable](https://developer.valvesoftware.com/wiki/Prop_vehicle_driveable) entities to function in TF2 via VScript.
This is *not* func_vehicle!

# Usage
Create a `prop_vehicle_driveable` entity and set up its model and vehicle script file as usual.
In the `Entity Scripts` section, assign the `vehicle.nut` script. This script must be assigned to all vehicles.
If your vehicle behaves like an Airboat, you will need to set `spawnflags` to 8 or the physics will glitch out. This can be done by turning off SmartEdit in Hammer.
 
Finally, create a `logic_script` and assign it the `vehicle_events.nut` file. Everything will now work.

**NOTE**: If using HL2 vehicles such as buggy or airboat, you must add the contents of `scripts/game_sounds_vehicle.txt` (located in `hl2/hl2_misc.vpk`) to your `maps/<map_name>_level_sounds.txt` for sounds to work.

**NOTE**: `vehicle_events.nut` setups required event listeners for vehicles and adds a think function to the player.
If your map uses scripts with their own events and clears them, or adds a custom think function to the player, you will need to modify `vehicle_events.nut` for compatibility.
The following sources of compatibility need to be considered:
- If you have `ClearGameEventCallbacks` in one of your scripts, then remove it from `vehicle_events.nut`.
- If you have a think function assigned to players, then remove it from `vehicle_events.nut` and call `Vehicle_FindInCrosshair` from your own think function.
- If you are using `OnScriptHook_OnTakeDamage`, then remove it from `vehicle_events.nut` and call `Vehicle_OnTakeDamage` from your own hook function. 

**NOTE**: Vehicles require `sv_turbophysics 0` for player collisions, so this script will automatically set that.

# Limitations
The camera will behave weirdly if the player exceeds extreme angles such as flipping upside down. 
A potential way to resolve this is to assign a `point_viewcontrol` to the vehicle, but that is out of scope for this project.

Entry/exit animations do not function, but this isn't too much of a big deal.

# License
Do whatever the hell you want