------------------------------------------------------------------------------[[
-- Filename: items.lua
--
-- Description: This file contains the definitions of all items.
-- Each item has a unique integer identifier that is used
-- as its key in the items table below. Item IDs are unique not only among
-- each other, but among other inventory game objects as well (weapons, armor,
-- etc).
--
-- Object IDs 1 through 10,000 are reserved for items. Do not break this
-- limit, because other value ranges correspond to other types of inventory objects.
--
-- Item IDs do -not- need to be sequential. When you make a new item, keep it
-- grouped with similar item types (potions, scrolls, etc.) and keep a buffer of
-- space between group types. This way we won't get a mess of random items all over
-- this file.
--
-- All item entries needs the following data to be defined:
-- {name}: Text that defines the name of the item.
-- {description}: A brief description about the item.
-- {icon}: The filepath to the image icon representing this icon.
-- {target_type}: The type of target the item affects, which may be an attack point, actor, or party.
-- {standard_price}: The standard asking price of this weapon from merchants.
-- {warmup_time}: The time needed before using that item in battles.
-- {cooldown_time}: The time needed after using that item in battles.
-- {key_item}: Tells whether the item is a key item, preventing it from being consumed or sold.
--
-- Each item entry requires a function called {BattleUse} to be defined. This function implements the
-- use of item in battle, healing damage, causing status changes, playing sounds, and animating
-- sprites.
--
-- If an item is to be permitted for use outside of battle, an additional function {FieldUse} should
-- be defined. Defintion of this function is optional, but required for any items which are intended
-- to be used in the field. Their implementations will be similar to but more simple than their BattleUse
-- cousins as they do not need to be concerned with certain things such as sprite animations.
------------------------------------------------------------------------------]]

-- All item definitions are stored in this table
if (items == nil) then
	items = {}
end


--------------------------------------------------------------------------------
-- IDs 1 - 1,000 are reserved for healing potions
--------------------------------------------------------------------------------

function battle_healing_potion(target, hit_points)
		if (target:IsAlive() and target:GetHitPoints() < target:GetMaxHitPoints()) then
			target:RegisterHealing(hit_points, true);
			AudioManager:PlaySound("snd/potion_drink.wav");
			return true;
		else
			target:RegisterMiss(false);
			return false;
		end
end

-- The return value tells the inventory whether the item was used successfully,
-- and then whether it can be removed from it.
function field_healing_potion(target, hit_points)
	if (target:IsAlive() and target:GetHitPoints() < target:GetMaxHitPoints()) then
		target:AddHitPoints(hit_points);
		AudioManager:PlaySound("snd/potion_drink.wav");
		return true;
	else
		AudioManager:PlaySound("snd/cancel.wav");
		return false;
	end
end

items[1] = {
	name = vt_system.Translate("Minor Healing Potion"),
	description = vt_system.Translate("Restores a small amount of hit points to an ally."),
	icon = "img/icons/items/potion_green_small.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 30,
	warmup_time = 1000,
	cooldown_time = 700,

	BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_healing_potion(target_actor, 60);
	end,

	FieldUse = function(target)
		return field_healing_potion(target, 75);
	end
}

items[2] = {
	name = vt_system.Translate("Medium Healing Potion"),
	description = vt_system.Translate("Restores a reasonable amount of hit points to an ally."),
	icon = "img/icons/items/potion_green_medium.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 200,
	warmup_time = 1200,
	cooldown_time = 900,

    -- Can be traded against 3 Minor healing potions and 60 drunes
    trade_conditions = {
        [0] = 60,
        [1] = 3
    },

	BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_healing_potion(target_actor, 150);
	end,

	FieldUse = function(target)
		return field_healing_potion(target, 200);
	end
}

items[3] = {
	name = vt_system.Translate("Healing Potion"),
	description = vt_system.Translate("Restores a large amount of hit points to an ally."),
	icon = "img/icons/items/potion_green_large.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 900,
	warmup_time = 1200,
	cooldown_time = 900,

    -- Can be traded against 4 Medium healing potions and 60 drunes
    trade_conditions = {
        [0] = 60,
        [2] = 4
    },

	BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_healing_potion(target_actor, 500);
	end,

	FieldUse = function(target)
		return field_healing_potion(target, 620);
	end
}

items[4] = {
	name = vt_system.Translate("Mega Healing Potion"),
	description = vt_system.Translate("Restores a very high amount of hit points to an ally."),
	icon = "img/icons/items/potion_green_large.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 5000,
	warmup_time = 1200,
	cooldown_time = 1200,

	BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_healing_potion(target_actor, 9000);
	end,

	FieldUse = function(target)
		return field_healing_potion(target, 12000);
	end
}

-- Moon juices : Skill points
function battle_skill_potion(target, skill_points)
		if (target:IsAlive() and target:GetSkillPoints() < target:GetMaxSkillPoints()) then
			target:RegisterHealing(skill_points, false);
			AudioManager:PlaySound("snd/potion_drink.wav");
			return true;
		else
			target:RegisterMiss(false);
			return false;
		end
end

-- The return value tells the inventory whether the item was used successfully,
-- and then whether it can be removed from it.
function field_skill_potion(target, skill_points)
	if (target:IsAlive() and target:GetSkillPoints() < target:GetMaxSkillPoints()) then
		target:AddSkillPoints(skill_points);
		AudioManager:PlaySound("snd/potion_drink.wav");
		return true;
	else
		AudioManager:PlaySound("snd/cancel.wav");
		return false;
	end
end


items[11] = {
	name = vt_system.Translate("Small Moon Juice Potion"),
	description = vt_system.Translate("Restores a small amount of skill points to an ally."),
	icon = "img/icons/items/potion_blue_small.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 90,
	use_warmup_time = 1000,
	cooldown_time = 1200,

    BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_skill_potion(target_actor, 40);
	end,

	FieldUse = function(target)
		return field_skill_potion(target, 45);
	end
}

items[12] = {
	name = vt_system.Translate("Medium Moon Juice Potion"),
	description = vt_system.Translate("Restores a reasonable amount of skill points to an ally."),
	icon = "img/icons/items/potion_blue_medium.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 380,
	use_warmup_time = 1000,
	cooldown_time = 1200,

    BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_skill_potion(target_actor, 150);
	end,

	FieldUse = function(target)
		return field_skill_potion(target, 200);
	end
}

items[13] = {
	name = vt_system.Translate("Moon Juice Potion"),
	description = vt_system.Translate("Restores a large amount of skill points to an ally."),
	icon = "img/icons/items/potion_blue_large.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 1300,
	use_warmup_time = 1000,
	cooldown_time = 1200,

    BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_skill_potion(target_actor, 300);
	end,

	FieldUse = function(target)
		return field_skill_potion(target, 420);
	end
}

items[13] = {
	name = vt_system.Translate("Mega Moon Juice Potion"),
	description = vt_system.Translate("Restores a very high amount of skill points to an ally."),
	icon = "img/icons/items/potion_blue_huge.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY,
	standard_price = 6100,
	use_warmup_time = 1200,
	cooldown_time = 1300,

    BattleUse = function(user, target)
		target_actor = target:GetActor();
		return battle_skill_potion(target_actor, 999);
	end,

	FieldUse = function(target)
		return field_skill_potion(target, 1200);
	end
}

--------------------------------------------------------------------------------
-- IDs 1,001 - 2,000 are reserved for status potions
--------------------------------------------------------------------------------

decrement_negative_effects = function(target_actor, intensity)
    if (target_actor:IsAlive() == true) then
        -- decrement all the basic negative effects, or put positive effects depending on the intensity
        target_actor:RegisterStatusChange(vt_global.GameGlobal.GLOBAL_STATUS_STRENGTH_RAISE, intensity, 30000);
        target_actor:RegisterStatusChange(vt_global.GameGlobal.GLOBAL_STATUS_VIGOR_RAISE, intensity, 30000);
        target_actor:RegisterStatusChange(vt_global.GameGlobal.GLOBAL_STATUS_FORTITUDE_RAISE, intensity, 30000);
        target_actor:RegisterStatusChange(vt_global.GameGlobal.GLOBAL_STATUS_PROTECTION_RAISE, intensity, 30000);
        target_actor:RegisterStatusChange(vt_global.GameGlobal.GLOBAL_STATUS_AGILITY_RAISE, intensity, 30000);
        target_actor:RegisterStatusChange(vt_global.GameGlobal.GLOBAL_STATUS_EVADE_RAISE, intensity, 30000);
	AudioManager:PlaySound("snd/potion_drink.wav");
	return true;
    else
        target_actor:RegisterMiss(false);
	return false;
    end
end

items[1001] = {
	name = vt_system.Translate("Minor Elixir"),
	description = vt_system.Translate("Revive a character, or improve the character status when it is sane or reduces ailing status effects by a limited degree."),
	icon = "img/icons/items/potion_red_small.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY_EVEN_DEAD,
	standard_price = 50,
	use_warmup_time = 1200,
	cooldown_time = 1800,

    BattleUse = function(user, target)
        target_actor = target:GetActor();
        -- Decrement all base stats active negative status effects slightly
        if (target_actor:GetHitPoints() > 0) then
            -- Decrement any active negative base stats status effects when alive
            return decrement_negative_effects(target_actor, vt_global.GameGlobal.GLOBAL_INTENSITY_POS_LESSER);
        else
            -- When dead, revive the character
            target_actor:RegisterRevive(1);
        end
        return true;
    end,

    FieldUse = function(target)
        if (target:GetHitPoints() > 0) then
            -- TODO: decrement any active negative status effects when alive, like poison, or paralysis, but not the base stats effects
            -- which are valid only in battles.
            return false;
        else
            -- When dead, revive the character
            target:SetHitPoints(1);
        end
        return true;
    end
}

items[1003] = {
	name = vt_system.Translate("Elixir"),
	description = vt_system.Translate("Revive a character with half of its Hit Points, or reduces almost all its ailing status effects if the potion is drunk when alive."),
	icon = "img/icons/items/potion_red_large.png",
	target_type = vt_global.GameGlobal.GLOBAL_TARGET_ALLY_EVEN_DEAD,
	standard_price = 1200,
	use_warmup_time = 1600,
	cooldown_time = 2100,

    BattleUse = function(user, target)
        target_actor = target:GetActor();
        if (target_actor:GetHitPoints() > 0) then
            -- Decrement any active negative base stats status effects when alive
            return decrement_negative_effects(target_actor, vt_global.GameGlobal.GLOBAL_INTENSITY_POS_MODERATE);
        else
            -- When dead, revive the character
            target_actor:RegisterRevive(target_actor:GetMaxHitPoints() / 2.0);
        end
        return true;
    end,

    FieldUse = function(target)
        if (target:GetHitPoints() > 0) then
        -- TODO: decrement any active negative status effects when alive, like poison, or paralysis, but not the base stats effects
            -- which are valid only in battles.
            return false;
        else
            -- When dead, revive the character
            target:SetHitPoints(target_actor:GetMaxHitPoints() / 2.0);
        end
        return true;
    end
}

--------------------------------------------------------------------------------
-- IDs 2,001 - 3,000 are reserved for elemental potions
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- IDs 3,001 - 4,000 are reserved for attack items
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- IDs 70001-80000 are reserved for "simple" key items
--------------------------------------------------------------------------------
items[70001] = {
    name = vt_system.Translate("Pen"),
    description = vt_system.Translate("Georges' pen, presumably used to write poetry."),
    icon = "img/icons/items/key_items/ink.png",
    standard_price = 0,
    key_item = true
}

items[70002] = {
    name = vt_system.Translate("Barley Meal"),
    description = vt_system.Translate("Basic yet good and cheap flour."),
    icon = "img/icons/items/key_items/barley_meal_bag.png",
    standard_price = 0,
    key_item = true
}

items[70003] = {
    name = vt_system.Translate("Wolfpain Necklace"),
    description = vt_system.Translate("A strange necklace with unknown powers."),
    icon = "img/icons/items/key_items/necklace_wolfpain.png",
    standard_price = 0,
    key_item = true
}