-- This script executes for the very first battle that the player encounters in a new game.
-- Its purpose is to present a dialogue to the player at the start of the battle to provide
-- a brief explanation of the battle system.
--
-- This script is only used by the river cave access map. All battles on that map load this script,
-- but we only want the script to execute for the first battle. So the "global_events" event group is
-- used to record when the first battle occurs. If it has already occurred, this script effectively does
-- nothing

local ns = {}
setmetatable(ns, {__index = _G})
tutorial_battle_dialogs = ns;
setfenv(1, ns);

local hand1_image_id = 0;
local hand2_image_id = 0;
-- hand coordinates
local hand1_origin_x = 0.0;
local hand1_origin_y = 0.0;
local hand2_origin_x = 0.0;
local hand2_origin_y = 0.0;
-- bouncing coordinates
local hand1_bouncing_x = 0.0;
local bouncing1_force = 0.0;
local hand2_bouncing_y = 0.0;
local bouncing2_force = 0.0;
-- whether the hand should be shown
local trigger_show_hand1 = false;
local trigger_show_hand2 = false;
-- whether the hand should be visible
local hand1_visible = false;
local hand2_visible = false;
-- Keeps track of the latest line.
local last_line = 0;

local Battle = {};
local Script = {};
local DialogueManager = {};
local stop_script = false;
local start_timer = {};
local main_dialogue = {};

function Initialize(battle_instance)
    Battle = battle_instance;
    Script = Battle:GetScriptSupervisor();

    stop_script = false;

    if (GlobalManager:DoesEventExist("story", "first_battle") == false) then
        GlobalManager:SetEventValue("story", "first_battle", 1);
        stop_script = false;
    else
        stop_script = true;
        return;
    end

    -- Load the hand cursors
    hand1_image_id = Script:AddImage("img/menus/hand.png", 47.0, 26.0);
    hand2_image_id = Script:AddImage("img/menus/hand_down.png", 26.0, 47.0);

    DialogueManager = Battle:GetDialogueSupervisor();

    -- Add all speakers for the dialogues to be added
    -- TODO: all of these custom speaker calls should be replaced with calls to AddCharacterSpeaker() later
    DialogueManager:AddCustomSpeaker(1000, "Bronann", "img/portraits/bronann.png");
    DialogueManager:AddCustomSpeaker(1002, "Kalya", "img/portraits/kalya.png");

    local text;
    -- The dialogue constructed below offers the player instructions on how to do battle. It is displayed only once in the first few seconds
    -- of battle, before any action can be taken. The player is presented with several options that they can read to get more information on
    -- the battle system. One of the options that the player may select from will finish the dialogue, allow the battle to resume.
    main_dialogue = vt_battle.BattleDialogue(1);
        text = vt_system.Translate("Woah, I wouldn't have expected enemies so close to the village. Bronann, do you need a quick reminder about the basics in battles?");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("...");
        main_dialogue:AddLine(text, 1000);
        text = vt_system.Translate("Ask about battle basics.");
        main_dialogue:AddOption(text, 2);
        text = vt_system.Translate("Ask nothing. I know how to fight.");
        main_dialogue:AddOption(text, 13);
        -- [Line 2] After selecting option: Ask about battle basics.
        text = vt_system.Translate("Er, I could use a refresher on the fundamentals of combat.");
        main_dialogue:AddLine(text, 1000);
        text = vt_system.Translate("Here you can find the Hit Points (HP) and Skill Points (SP) of all the ally party. Don't let our HP reach 0 or we're doomed!");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("In battles, our stamina icons and the ones of our enemy are going up the Stamina Bar. The more Agility you have, the quickest you'll reach the upper part of it.");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("Once one of us has reached the action level, you can select an action for the one concerned. Don't panic, the battle is then paused and you've got all the time needed to select one.");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("There are several action types: The basic one 'Weapon', and later 'Magic' skills. Last but not least, you'll also be able to use our 'Items'. Simply choose one action and a target to trigger it.");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("The icon will the reach the top of the Stamina Bar before being triggering it. It's called the 'preparation time'. The stronger is the skill, the longer it has to be prepared.");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("By the way, you're not forced to wait for your icon to reach the action level before acting. The two little arrows here can be triggered, using your up and down keys, to preselect an action for either of us.");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("As long as the little arrows there are visible, you can change the selected action.");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("Don't forget you can press '") .. InputManager:GetHelpKeyName() .. vt_system.Translate("' if you need more details.");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("Shall I repeat?");
        main_dialogue:AddLine(text, 1002);
        text = vt_system.Translate("...");
        main_dialogue:AddLine(text, 1000);
        text = vt_system.Translate("Yes, please!");
        main_dialogue:AddOption(text, 3);
        text = vt_system.Translate("No, it's alright!");
        main_dialogue:AddOption(text, 14);

        -- [Line 13] End
        text = vt_system.Translate("Don't worry Kalya, I have not forgotten my training.");
        main_dialogue:AddLine(text, 1000, 15);
        -- [Line 14] After selecting option: Ask nothing. (After a topic has already been asked).
        text = vt_system.Translate("Thanks Kalya, I'm prepared now.");
        main_dialogue:AddLine(text, 1000);
        -- [Line 25] Final line of dialogue
        text = vt_system.Translate("Good. Now let us quickly dispatch this minor threat.");
        main_dialogue:AddLine(text, 1002);
    DialogueManager:AddDialogue(main_dialogue);

    -- Construct a timer so we can start the dialogue a couple seconds after the battle begins
    start_timer = vt_system.SystemTimer(100, 0);
end


function Update()
    if (stop_script == true) then
        return;
    end

    start_timer:Update();

    -- Wait until the initial battle sequence ends to begin running the dialogue start timer
    if ((start_timer:IsInitial() == true) and (Battle:GetState() ~= vt_battle.BattleMode.BATTLE_STATE_INITIAL)) then
        start_timer:Run();
    end

    -- If the dialogue has not been seen yet, check if its time to start it
    if ((start_timer:IsFinished() == true) and (DialogueManager:IsDialogueActive() == false)) then
        DialogueManager:BeginDialogue(1);
    end

    -- Set up whether the hand should be shown and where
    if (DialogueManager:GetLineCounter() < 3) then
        hand1_visible = false;
        hand2_visible = false;
    elseif (last_line ~= 3 and DialogueManager:GetLineCounter() == 3) then
        hand1_visible = false;
        hand2_visible = true;
        hand2_origin_x = 350.0;
        hand2_origin_y = 598.0;
        trigger_show_hand2 = false;
        last_line = 3;
    elseif (last_line ~= 4 and DialogueManager:GetLineCounter() == 4) then
        hand1_visible = true;
        hand2_visible = false;
        hand1_origin_x = 850.0;
        hand1_origin_y = 468.0;
        trigger_show_hand1 = false;
        last_line = 4;
    elseif (last_line ~= 5 and DialogueManager:GetLineCounter() == 5) then
        hand1_visible = true;
        hand2_visible = false;
        hand1_origin_x = 850.0;
        hand1_origin_y = 278.0;
        trigger_show_hand1 = false;
        last_line = 5;
    elseif (last_line ~= 6 and DialogueManager:GetLineCounter() == 6) then
        hand1_visible = false;
        hand2_visible = true;
        hand2_origin_x = 650.0;
        hand2_origin_y = 598.0;
        trigger_show_hand2 = false;
        last_line = 6;
    elseif (last_line ~= 7 and DialogueManager:GetLineCounter() == 7) then
        hand1_visible = true;
        hand2_visible = false;
        hand1_origin_x = 850.0;
        hand1_origin_y = 168.0;
        trigger_show_hand1 = false;
        last_line = 7;
    elseif (last_line ~= 8 and DialogueManager:GetLineCounter() == 8) then
        hand1_visible = false;
        hand2_visible = true;
        hand2_origin_x = 550.0;
        hand2_origin_y = 598.0;
        trigger_show_hand2 = false;
        last_line = 8;
    elseif (last_line ~= 10 and DialogueManager:GetLineCounter() == 10) then
        hand1_visible = false;
        hand2_visible = false;
        last_line = 10;
    elseif (DialogueManager:GetLineCounter() >= 13) then
        hand1_visible = false;
        hand2_visible = false;
        last_line = 15;
        stop_script = true;
    end

    -- get time expired
    local time_expired = SystemManager:GetUpdateTime();

    -- Left to right hand handling
    -- The hand has reached the origin point, let's make it bounce
    if (hand1_bouncing_x >= hand1_origin_x) then
        bouncing1_force = 5.0;
    end

    -- Apply pseudo gravity
    bouncing1_force = bouncing1_force - (time_expired * 0.01);

    hand1_bouncing_x = hand1_bouncing_x - bouncing1_force;

    -- Update the hand shown.
    if (hand1_visible == true) then
        if (trigger_show_hand1 == false) then
            trigger_show_hand1 = true;
            hand1_bouncing_x = hand1_origin_x;
        end
    end

    -- Top to bottom hand handling
    -- The hand has reached the origin point, let's make it bounce
    if (hand2_bouncing_y >= hand2_origin_y) then
        bouncing2_force = 5.0;
    end

    -- Apply pseudo gravity
    bouncing2_force = bouncing2_force - (time_expired * 0.01);

    hand2_bouncing_y = hand2_bouncing_y - bouncing2_force;

    -- Update the hand shown.
    if (hand2_visible == true) then
        if (trigger_show_hand2 == false) then
            trigger_show_hand2 = true;
            hand2_bouncing_y = hand2_origin_y;
        end
    end
end

function DrawPostEffects()

    -- Draw the hands
    if (hand1_visible == true) then
        Script:DrawImage(hand1_image_id, hand1_bouncing_x, hand1_origin_y, vt_video.Color(1.0, 1.0, 1.0, 1.0));
    end
    if (hand2_visible == true) then
        Script:DrawImage(hand2_image_id, hand2_origin_x, hand2_bouncing_y, vt_video.Color(1.0, 1.0, 1.0, 1.0));
    end
end
