NTCE = {}
NTCE.Name="Neurotrauma Cyberengineering"
NTCE.Version = "0.0.1"
NTCE.VersionNum = 0
NTCE.MinNTVersion = "A1.9.4h1"
NTCE.MinNTVersionNum = 01090401
NTCE.Path = table.pack(...)[1]
Timer.Wait(function() if NTC ~= nil then NTC.RegisterExpansion(NTCE) end end,1)


Timer.Wait(function() 
	if SERVER and NTC == nil then
		print("Error loading NT Cyberengineerung: Neurotrauma didn`t load correctly!")
		return
	end
	
	if SERVER or (CLIENT and not Game.IsMultiplayer) then
		dofile(NTCE.Path.."/Lua/Scripts/Server/bonesremoval.lua")
	end
	
	--if CLIENT then
        --dofile(NTCE.Path.."/Lua/Scripts/Client/.lua")
	--end
end, 1)


