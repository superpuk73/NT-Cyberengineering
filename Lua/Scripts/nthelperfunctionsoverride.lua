NT.BreakLimb = function(character, limbtype, strength)
	strength = strength or 5
	local limbtoaffliction = {}
	limbtoaffliction[LimbType.RightLeg] = {"rl_fracture", "right_shin_fracture", "right_foot_fracture"}
	limbtoaffliction[LimbType.LeftLeg] = {"ll_fracture", "left_shin_fracture", "left_foot_fracture"}
	limbtoaffliction[LimbType.RightArm] = {"ra_fracture", "right_forearm_fracture", "right_hand_fracture"}
	limbtoaffliction[LimbType.LeftArm] = {"la_fracture, left_forearm_fracture", "left_hand_fracture"}
	limbtoaffliction[LimbType.Head] = {"h_fracture, frontal_skull_fracture, rear_skull_fracture"}
	limbtoaffliction[LimbType.Torso] = {"t_fracture, pelvis_fracture"}

	if limbtoaffliction[limbtype] == nil then
		return
	end

    if limbtype == LimbType.Torso then
        random = math.random()
        if random <= 0.55 then
            HF.AddAffliction(character, limbtoaffliction[limbtype][0], strength)
        if random >= 0.45 then
            HF.AddAffliction(character, limbtoaffliction[limbtype][1], strength)
        else return
    else
        if random <= 0.38 then
            HF.AddAffliction(character, limbtoaffliction[limbtype][0], strength)
        if random >= 0.28 and random <= 0.71 then
            HF.AddAffliction(character, limbtoaffliction[limbtype][1], strength)
        if random >= 0.62 then
            HF.AddAffliction(character, limbtoaffliction[limbtype][2], strength)
        else return
    end

	if strength > 0 and NTConfig.Get("NT_fracturesRemoveCasts", true) then
		HF.SetAfflictionLimb(character, "gypsumcast", limbtype, 0)
	end
end

NT.LimbIsBroken = function(character, limbtype)
	local limbtoaffliction = {}
	limbtoaffliction[LimbType.RightLeg] = {"rl_fracture", "right_shin_fracture", "right_foot_fracture"}
	limbtoaffliction[LimbType.LeftLeg] = {"ll_fracture", "left_shin_fracture", "left_foot_fracture"}
	limbtoaffliction[LimbType.RightArm] = {"ra_fracture", "right_forearm_fracture", "right_hand_fracture"}
	limbtoaffliction[LimbType.LeftArm] = {"la_fracture, left_forearm_fracture", "left_hand_fracture"}

    result = false

    for i = 0, 2 do
        result = HF.HasAffliction(character, limbtoaffliction[limbtype][i], 1)
    end
    
	return result
end