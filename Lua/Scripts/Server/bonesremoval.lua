NT.BreakLimb = function(character, limbtype, strength)
	strength = strength or 5
	local limbtoaffliction = {
        [LimbType.RightLeg] = "rl_fracture",
	    [LimbType.LeftLeg] = "ll_fracture",
	    [LimbType.RightArm] = "ra_fracture",
	    [LimbType.LeftArm] = "la_fracture",
	    [LimbType.Head] = "h_fracture",
	    [LimbType.Torso] = "t_fracture"
    }

	local removedbonesafflictions = {
        [LimbType.RightLeg] = "rl_bones_removed",
	    [LimbType.LeftLeg] = "ll_bones_removed",
	    [LimbType.RightArm] = "ra_bones_removed",
	    [LimbType.LeftArm] = "la_bones_removed",
	    [LimbType.Head] = "h_bones_removed",
	    [LimbType.Torso] = "t_bones_removed"
    }

	if limbtoaffliction[limbtype] == nil then
		return
	end

    if HF.HasAfflictionLimb(character, removedbonesafflictions[limbtype], limbtype, 1) then
        return
    end

	HF.AddAffliction(character, limbtoaffliction[limbtype], strength)

	if strength > 0 and NTConfig.Get("NT_fracturesRemoveCasts", true) then
		HF.SetAfflictionLimb(character, "gypsumcast", limbtype, 0)
	end
end

NT.SurgicallyAmputateLimbAndGenerateItem = function(usingCharacter, targetCharacter, limbtype)
	-- drop previously worn headgear item
	local previtem = HF.GetHeadWear(targetCharacter)
	if previtem ~= nil and limbtype == LimbType.Head then
		previtem.Drop(usingCharacter, true)
	end

	local removedbonesafflictions = {
        [LimbType.RightLeg] = "rl_bones_removed",
	    [LimbType.LeftLeg] = "ll_bones_removed",
	    [LimbType.RightArm] = "ra_bones_removed",
	    [LimbType.LeftArm] = "la_bones_removed",
	    [LimbType.Head] = "h_bones_removed"
    }

	local droplimb = not NT.LimbIsAmputated(targetCharacter, limbtype)
		and not HF.HasAfflictionLimb(targetCharacter, "gangrene", limbtype, 15)
        and not HF.HasAfflictionLimb(targetCharacter, removedbonesafflictions[limbtype], limbtype, 1)

	NT.SurgicallyAmputateLimb(targetCharacter, limbtype)
	if droplimb then
		local limbtoitem = {}
		limbtoitem[LimbType.RightLeg] = "rleg"
		limbtoitem[LimbType.LeftLeg] = "lleg"
		limbtoitem[LimbType.RightArm] = "rarm"
		limbtoitem[LimbType.LeftArm] = "larm"
		limbtoitem[LimbType.Head] = "headsa"
		if limbtoitem[limbtype] ~= nil then
			HF.GiveItem(usingCharacter, limbtoitem[limbtype])
			HF.GiveSurgerySkill(usingCharacter, 0.5)
		end
	end
end