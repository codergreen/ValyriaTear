------------------------------------------------------------------------------[[
-- Filename: status.lua
--
-- Description: This file contains the implementations of all status effects.
-- The list of different types of status effects and their
-- corresponding names may be found in src/modes/common/global/global_effects.*.
--
-- Each status effect implementation requires the following data to be defined.
-- {name} - The name of the status effect as it will be shown to the player
-- {default_duration} - The default duration that the effect lasts, in milliseconds
-- {opposite_effect} - The status which acts as an opposite status to this one
-- {Apply} - A function executed when the status effect is applied to the target
-- {Update} - A function executed periodically while the status is still in effect
-- {Remove} - A function executed when the status effect is no longer active on the target
--
-- To verify what a status effect's icon_index should be, examine the image file
-- img/icons/effects/status.png and find the appropriate row of icons.
--
-- The opposite_status property is only applicable to some pairs of status effects.
-- For example, a pair of effects that increase strength and decrease strength. Each status
-- effect can have only one opposite effect, not several. If the status effect has no opposite
-- effect, this member should be set to vt_global.GameGlobal.GLOBAL_STATUS_INVALID.
--
-- The Apply, Update, and Remove functions are all called with an argument, {effect},
-- which is a pointer to the BattleStatusEffect object that was constructed to represent
-- this status. Use this object to access data relevant to the status effect. Most
-- implementations of these functions will want to grab pointers to the following pieces of
-- data.
--
-- effect:GetTimer() - returns the BattleTimer object for the effect
-- effect:GetAffectedActor() - returns the BattleActor object that the effect is active on
-- effect:GetIntensity() - returns the current intensity of the active effect
-- effect:HasIntensityChanged() - returns true if the intensity level has undergone a recent change
--
-- NOTE: Unlike elemental effects, status effects only ever have intensity levels that are
-- neutral or in the positive range of values, never the negative range. You should not concern
-- yourself with negative intensity values in this file.
------------------------------------------------------------------------------]]

-- All item definitions are stored in this table
if (status_effects == nil) then
   status_effects = {}
end


status_effects[vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_RAISE] = {
	name = vt_system.Translate("Raise Strength"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_LOWER,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_RAISE].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_RAISE].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetStrength();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetStrength();
		base_value = actor:GetStrength();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifer = 1.2;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 1.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 1.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 1.8;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetStrength(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_LOWER] = {
	name = vt_system.Translate("Lower Strength"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_RAISE,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_LOWER].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_LOWER].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetStrength();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetStrength();
		base_value = actor:GetStrength();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifier = 0.8;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 0.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 0.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 0.2;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetStrength(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_RAISE] = {
	name = vt_system.Translate("Raise Vigor"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_LOWER,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_RAISE].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_RAISE].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetVigor();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetVigor();
		base_value = actor:GetVigor();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifer = 1.2;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 1.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 1.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 1.8;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetVigor(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_LOWER] = {
	name = vt_system.Translate("Lower Vigor"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_RAISE,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_LOWER].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_LOWER].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetVigor();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetVigor();
		base_value = actor:GetVigor();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifier = 0.8;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 0.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 0.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 0.2;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetVigor(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_RAISE] = {
	name = vt_system.Translate("Raise Fortitude"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_LOWER,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_RAISE].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_RAISE].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetFortitude();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetFortitude();
		base_value = actor:GetFortitude();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifer = 1.2;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 1.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 1.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 1.8;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetFortitude(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_LOWER] = {
	name = vt_system.Translate("Lower Fortitude"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_RAISE,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_LOWER].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_LOWER].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetFortitude();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetFortitude();
		base_value = actor:GetFortitude();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifier = 0.8;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 0.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 0.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 0.2;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetFortitude(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_RAISE] = {
	name = vt_system.Translate("Raise Protection"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_LOWER,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_RAISE].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_RAISE].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetProtection();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetProtection();
		base_value = actor:GetProtection();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifer = 1.2;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 1.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 1.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 1.8;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetProtection(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_LOWER] = {
	name = vt_system.Translate("Lower Protection"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_RAISE,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_LOWER].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_LOWER].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetProtection();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetProtection();
		base_value = actor:GetProtection();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifier = 0.8;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 0.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 0.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 0.2;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetProtection(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_RAISE] = {
	name = vt_system.Translate("Raise Agility"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_LOWER,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_RAISE].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_RAISE].ModifyAttribute(effect);
		end
	end,

	-- Note: This modifies the actor's idle state wait time accordingly.
	Remove = function(effect)
		effect:GetAffectedActor():ResetAgility();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetAgility();
		base_value = actor:GetAgility();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifer = 1.2;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 1.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 1.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 1.8;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		-- Note: This modifies the actor's idle state wait time accordingly.
		actor:SetAgility(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_LOWER] = {
	name = vt_system.Translate("Lower Agility"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_RAISE,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_LOWER].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_LOWER].ModifyAttribute(effect);
		end
	end,

	-- Note: This modifies the actor's idle state wait time accordingly.
	Remove = function(effect)
		effect:GetAffectedActor():ResetAgility();
	end,

	-- Note: This modifies the actor's idle state wait time accordingly.
	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetAgility();
		base_value = actor:GetAgility();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifier = 0.8;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 0.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 0.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 0.2;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetAgility(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_EVADE_RAISE] = {
	name = vt_system.Translate("Raise Evasion"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_EVADE_LOWER,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_EVADE_RAISE].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_EVADE_RAISE].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetEvade();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetEvade();
		base_value = actor:GetEvade();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifer = 1.2;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 1.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 1.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 1.8;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		-- Note: this has a possiblitiy to set the evade above the max value of 1.0 (100%). This shouldn't
		-- pose a problem though, and its probably very unlikely that any actor would have an evade rating
		-- high enough to cause this condition.
		actor:SetEvade(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_EVADE_LOWER] = {
	name = vt_system.Translate("Lower Evasion"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_EVADE_RAISE,

	Apply = function(effect)
		status_effects[vt_global.GameGlobal.GLOBAL_STATUS_EVADE_LOWER].ModifyAttribute(effect);
	end,

	Update = function(effect)
		if (effect:HasIntensityChanged() == true) then
			status_effects[vt_global.GameGlobal.GLOBAL_STATUS_EVADE_LOWER].ModifyAttribute(effect);
		end
	end,

	Remove = function(effect)
		effect:GetAffectedActor():ResetEvade();
	end,

	ModifyAttribute = function(effect)
		actor = effect:GetAffectedActor();
		intensity = effect:GetIntensity();

		actor:ResetEvade();
		base_value = actor:GetEvade();
		attribute_modifier = 1;

		if (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_NEUTRAL) then
			attribute_modifier = 1;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER) then
			attribute_modifier = 0.8;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE) then
			attribute_modifier = 0.6;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_GREATER) then
			attribute_modifier = 0.4;
		elseif (intensity == vt_global.GameGlobal.GLOBAL_INTENSITY_POS_EXTREME) then
			attribute_modifier = 0.2;
		else
			print("Lua warning: status effect had an invalid intensity value: " .. intensity);
		end

		actor:SetEvade(base_value * attribute_modifier);
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_HP_REGEN] = {
	name = vt_system.Translate("Regenerate HP"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_HP_DRAIN,

	Apply = function(effect)
		-- TODO
	end,

	Update = function(effect)
		-- TODO
	end,

	Remove = function(effect)
		-- TODO
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_HP_DRAIN] = {
	name = vt_system.Translate("Drain HP"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_HP_REGEN,

	Apply = function(effect)
		-- TODO
	end,

	Update = function(effect)
		-- TODO
	end,

	Remove = function(effect)
		-- TODO
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_SP_REGEN] = {
	name = vt_system.Translate("Regenerate SP"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_SP_DRAIN,

	Apply = function(effect)
		-- TODO
	end,

	Update = function(effect)
		-- TODO
	end,

	Remove = function(effect)
		-- TODO
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_SP_DRAIN] = {
	name = vt_system.Translate("Drain SP"),
	default_duration = 30000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_SP_REGEN,

	Apply = function(effect)
		-- TODO
	end,

	Update = function(effect)
		-- TODO
	end,

	Remove = function(effect)
		-- TODO
	end
}

status_effects[vt_global.GameGlobal.GLOBAL_STATUS_PARALYSIS] = {
	name = vt_system.Translate("Paralysis"),
	default_duration = 10000,
	opposite_effect = vt_global.GameGlobal.GLOBAL_STATUS_INVALID,

	Apply = function(effect)
		battle_actor = effect:GetAffectedActor();
		battle_actor:SetStunned(true);
	end,

	Update = function(effect)
		-- Nothing needs to be updated for this effect
	end,

	Remove = function(effect)
		battle_actor = effect:GetAffectedActor();
		battle_actor:SetStunned(false);
	end
}
