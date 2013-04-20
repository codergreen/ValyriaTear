///////////////////////////////////////////////////////////////////////////////
//            Copyright (C) 2004-2011 by The Allacrost Project
//            Copyright (C) 2012-2013 by Bertram (Valyria Tear)
//                         All Rights Reserved
//
// This code is licensed under the GNU GPL version 2. It is free software
// and you may modify it and/or redistribute it under the terms of this license.
// See http://www.gnu.org/copyleft/gpl.html for details.
///////////////////////////////////////////////////////////////////////////////

/** ***************************************************************************
*** \file    mode_bindings.cpp
*** \author  Daniel Steuernol, steu@allacrost.org
*** \author  Yohann Ferreira, yohann ferreira orange fr
*** \brief   Lua bindings for game mode code
***
*** All bindings for the game mode code is contained within this file.
*** Therefore, everything that you see bound within this file will be made
*** available in Lua.
***
*** \note To most C++ programmers, the syntax of the binding code found in this
*** file may be very unfamiliar and obtuse. Refer to the Luabind documentation
*** as necessary to gain an understanding of this code style.
*** **************************************************************************/

// Common code headers
#include "common/dialogue.h"
#include "common/global/global_actors.h"
#include "common/global/global_effects.h"

#include "modes/boot/boot.h"
#include "modes/battle/battle.h"
#include "modes/battle/battle_actors.h"
#include "modes/battle/battle_command.h"
#include "modes/battle/battle_dialogue.h"
#include "modes/battle/battle_effects.h"
#include "modes/battle/battle_utils.h"
#include "modes/map/map_mode.h"
#include "modes/map/map_dialogue.h"
#include "modes/map/map_events.h"
#include "modes/map/map_objects.h"
#include "modes/map/map_sprites.h"
#include "modes/map/map_treasure.h"
#include "modes/map/map_utils.h"
#include "modes/map/map_zones.h"
#include "modes/menu/menu.h"
#include "modes/shop/shop.h"

namespace vt_defs
{

void BindModeCode()
{
    // ----- Boot Mode Bindings
    {
        using namespace vt_boot;
        using namespace vt_boot::private_boot;

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_boot")
        [
            luabind::class_<BootMode, vt_mode_manager::GameMode>("BootMode")
            .def(luabind::constructor<>())
            .def("GetState", &BootMode::GetState)
            .def("ChangeState", &BootMode::ChangeState)

            // Namespace constants
            .enum_("constants") [
                // Boot states
                luabind::value("BOOT_STATE_INTRO", BOOT_STATE_INTRO),
                luabind::value("BOOT_STATE_MENU", BOOT_STATE_MENU)
            ]
        ];
    }

    // ----- Map Mode Bindings
    {
        using namespace vt_map;
        using namespace vt_map::private_map;

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<MapMode, vt_mode_manager::GameMode>("MapMode")
            .def(luabind::constructor<const std::string &, const std::string &>())
            .def_readonly("object_supervisor", &MapMode::_object_supervisor)
            .def_readonly("event_supervisor", &MapMode::_event_supervisor)
            .def_readonly("dialogue_supervisor", &MapMode::_dialogue_supervisor)

            .def_readwrite("camera", &MapMode::_camera)
            .def_readwrite("unlimited_stamina", &MapMode::_unlimited_stamina)
            .def_readwrite("running_disabled", &MapMode::_running_disabled)
            .def_readwrite("run_stamina", &MapMode::_run_stamina)

            .def("AddFlatGroundObject", &MapMode::AddFlatGroundObject, luabind::adopt(_2))
            .def("AddGroundObject", &MapMode::AddGroundObject, luabind::adopt(_2))
            .def("AddPassObject", &MapMode::AddPassObject, luabind::adopt(_2))
            .def("AddSkyObject", &MapMode::AddSkyObject, luabind::adopt(_2))
            .def("AddAmbientSoundObject", &MapMode::AddAmbientSoundObject, luabind::adopt(_2))
            .def("AddZone", &MapMode::AddZone, luabind::adopt(_2))
            .def("AddSavePoint", &MapMode::AddSavePoint)
            .def("AddHalo", &MapMode::AddHalo)
            .def("AddLight", (void(MapMode:: *)(const std::string &, const std::string &, float, float,
                                                const vt_video::Color&, const vt_video::Color&))&MapMode::AddLight)
            .def("AddLight", (void(MapMode:: *)(private_map::Light*))&MapMode::AddLight, luabind::adopt(_2))
            .def("SetCamera", (void(MapMode:: *)(private_map::VirtualSprite *))&MapMode::SetCamera)
            .def("SetCamera", (void(MapMode:: *)(private_map::VirtualSprite *, uint32))&MapMode::SetCamera)
            .def("MoveVirtualFocus", (void(MapMode:: *)(float, float))&MapMode::MoveVirtualFocus)
            .def("MoveVirtualFocus", (void(MapMode:: *)(float, float, uint32))&MapMode::MoveVirtualFocus)
            .def("IsCameraOnVirtualFocus", &MapMode::IsCameraOnVirtualFocus)
            .def("IsCameraMoving", &MapMode::IsCameraMoving)
            .def("GetScreenXCoordinate", &MapMode::GetScreenXCoordinate)
            .def("GetScreenYCoordinate", &MapMode::GetScreenYCoordinate)
            .def("SetShowGUI", &MapMode::SetShowGUI)
            .def("IsShowGUI", &MapMode::IsShowGUI)
            .def("PushState", &MapMode::PushState)
            .def("PopState", &MapMode::PopState)
            .def("CurrentState", &MapMode::CurrentState)
            .def("DrawMapLayers", &MapMode::_DrawMapLayers)
            .def("ShowMinimap", &MapMode::ShowMinimap)

            // Namespace constants
            .enum_("constants") [
                // Map states
                luabind::value("STATE_EXPLORE", STATE_EXPLORE),
                luabind::value("STATE_SCENE", STATE_SCENE),
                luabind::value("STATE_DIALOGUE", STATE_DIALOGUE),
                luabind::value("STATE_TREASURE", STATE_TREASURE),
                // Map Collision types
                luabind::value("NO_COLLISION", NO_COLLISION),
                luabind::value("CHARACTER_COLLISION", CHARACTER_COLLISION),
                luabind::value("ENEMY_COLLISION", ENEMY_COLLISION),
                luabind::value("WALL_COLLISION", WALL_COLLISION),
                luabind::value("ALL_COLLISION", ALL_COLLISION),
                // Object types
                luabind::value("PHYSICAL_TYPE", PHYSICAL_TYPE),
                luabind::value("VIRTUAL_TYPE", VIRTUAL_TYPE),
                luabind::value("SPRITE_TYPE", SPRITE_TYPE),
                // Sprite directions
                luabind::value("NORTH", NORTH),
                luabind::value("SOUTH", SOUTH),
                luabind::value("EAST", EAST),
                luabind::value("WEST", WEST),
                luabind::value("NW_NORTH", NW_NORTH),
                luabind::value("NW_WEST", NW_WEST),
                luabind::value("NE_NORTH", NE_NORTH),
                luabind::value("NE_EAST", NE_EAST),
                luabind::value("SW_SOUTH", SW_SOUTH),
                luabind::value("SW_WEST", SW_WEST),
                luabind::value("SE_SOUTH", SE_SOUTH),
                luabind::value("SE_EAST", SE_EAST),
                // Sprite animations
                luabind::value("ANIM_SOUTH", ANIM_SOUTH),
                luabind::value("ANIM_NORTH", ANIM_NORTH),
                luabind::value("ANIM_WEST", ANIM_WEST),
                luabind::value("ANIM_EAST", ANIM_EAST),
                // Sprite speeds
                luabind::value("VERY_SLOW_SPEED", static_cast<uint32>(VERY_SLOW_SPEED)),
                luabind::value("SLOW_SPEED", static_cast<uint32>(SLOW_SPEED)),
                luabind::value("NORMAL_SPEED", static_cast<uint32>(NORMAL_SPEED)),
                luabind::value("ENEMY_SPEED", static_cast<uint32>(ENEMY_SPEED)),
                luabind::value("FAST_SPEED", static_cast<uint32>(FAST_SPEED)),
                luabind::value("VERY_FAST_SPEED", static_cast<uint32>(VERY_FAST_SPEED))
            ]
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<ObjectSupervisor>("ObjectSupervisor")
            .def_readonly("virtual_focus", &ObjectSupervisor::_virtual_focus)

            .def("GenerateObjectID", &ObjectSupervisor::GenerateObjectID)
            .def("GetNumberObjects", &ObjectSupervisor::GetNumberObjects)
            .def("GetObjectByIndex", &ObjectSupervisor::GetObjectByIndex)
            .def("GetObject", &ObjectSupervisor::GetObject)
            .def("SetPartyMemberVisibleSprite", &ObjectSupervisor::SetPartyMemberVisibleSprite)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<MapObject>("MapObject")
            .def("SetObjectID", &MapObject::SetObjectID)
            .def("SetXPosition", &MapObject::SetXPosition)
            .def("SetYPosition", &MapObject::SetYPosition)
            .def("SetPosition", &MapObject::SetPosition)
            .def("SetImgHalfWidth", &MapObject::SetImgHalfWidth)
            .def("SetImgHeight", &MapObject::SetImgHeight)
            .def("SetCollHalfWidth", &MapObject::SetCollHalfWidth)
            .def("SetCollHeight", &MapObject::SetCollHeight)
            .def("SetUpdatable", &MapObject::SetUpdatable)
            .def("SetVisible", &MapObject::SetVisible)
            .def("SetCollisionMask", &MapObject::SetCollisionMask)
            .def("SetDrawOnSecondPass", &MapObject::SetDrawOnSecondPass)
            .def("GetObjectID", &MapObject::GetObjectID)
            .def("GetXPosition", &MapObject::GetXPosition)
            .def("GetYPosition", &MapObject::GetYPosition)
            .def("GetImgHalfWidth", &MapObject::GetImgHalfWidth)
            .def("GetImgHeight", &MapObject::GetImgHeight)
            .def("GetCollHalfWidth", &MapObject::GetCollHalfWidth)
            .def("GetCollHeight", &MapObject::GetCollHeight)
            .def("IsUpdatable", &MapObject::IsUpdatable)
            .def("IsVisible", &MapObject::IsVisible)
            .def("GetCollisionMask", &MapObject::GetCollisionMask)
            .def("IsDrawOnSecondPass", &MapObject::IsDrawOnSecondPass)
            .def("Emote", &MapObject::Emote)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<ParticleObject, MapObject>("ParticleObject")
            .def(luabind::constructor<const std::string &, float, float>())
            .def("Stop", &ParticleObject::Stop)
            .def("Start", &ParticleObject::Start)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<Light, MapObject>("Light")
            .def(luabind::constructor<const std::string&, const std::string&, float, float,
                 const vt_video::Color&, const vt_video::Color&>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<SoundObject, MapObject>("SoundObject")
            .def(luabind::constructor<const std::string&, float, float, float>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<PhysicalObject, MapObject>("PhysicalObject")
            .def(luabind::constructor<>())
            .def("AddAnimation", (int32(PhysicalObject:: *)(const std::string &))&PhysicalObject::AddAnimation)
            .def("AddStillFrame", &PhysicalObject::AddStillFrame)
            .def("SetCurrentAnimation", &PhysicalObject::SetCurrentAnimation)
            .def("SetAnimationProgress", &PhysicalObject::SetAnimationProgress)
            .def("GetCurrentAnimation", &PhysicalObject::GetCurrentAnimation)
            .def("SetEventWhenTalking", &PhysicalObject::SetEventWhenTalking)
            .def("ClearEventWhenTalking", &PhysicalObject::ClearEventWhenTalking)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<TreasureObject, PhysicalObject>("TreasureObject")
            .def(luabind::constructor<const std::string &, const std::string &, const std::string &, const std::string &>())
            .def("SetDrunes", &TreasureObject::SetDrunes)
            .def("AddObject", &TreasureObject::AddObject)
            .def("AddEvent", &TreasureObject::AddEvent)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<TriggerObject, PhysicalObject>("TriggerObject")
            .def(luabind::constructor<const std::string &, const std::string &, const std::string &, const std::string &, const std::string &>())
            .def("SetState", &TriggerObject::SetState)
            .def("GetState", &TriggerObject::GetState)
            .def("GetTriggerName", &TriggerObject::GetTriggerName)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<VirtualSprite, MapObject>("VirtualSprite")
            .def(luabind::constructor<>())
            .def("SetMoving", &VirtualSprite::SetMoving)
            .def("SetDirection", &VirtualSprite::SetDirection)
            .def("SetMovementSpeed", &VirtualSprite::SetMovementSpeed)
            .def("GetMoving", &VirtualSprite::GetMoving)
            .def("GetDirection", &VirtualSprite::GetDirection)
            .def("GetMovementSpeed", &VirtualSprite::GetMovementSpeed)
            .def("LookAt", (void(VirtualSprite:: *)(float, float))&VirtualSprite::LookAt)
            .def("LookAt", (void(VirtualSprite:: *)(MapObject *))&VirtualSprite::LookAt)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<MapSprite, VirtualSprite>("MapSprite")
            .def(luabind::constructor<>())
            .def("SetName", (void(MapSprite:: *)(const std::string &))&MapSprite::SetName)
            .def("SetName", (void(MapSprite:: *)(const vt_utils::ustring &))&MapSprite::SetName)
            .def("SetCurrentAnimationDirection", &MapSprite::SetCurrentAnimationDirection)
            .def("GetCurrentAnimationDirection", &MapSprite::GetCurrentAnimationDirection)
            .def("LoadFacePortrait", &MapSprite::LoadFacePortrait)
            .def("LoadStandingAnimations", &MapSprite::LoadStandingAnimations)
            .def("LoadWalkingAnimations", &MapSprite::LoadWalkingAnimations)
            .def("LoadRunningAnimations", &MapSprite::LoadRunningAnimations)
            .def("LoadCustomAnimation", &MapSprite::LoadCustomAnimation)
            .def("ClearAnimations", &MapSprite::ClearAnimations)
            .def("SetCustomAnimation", &MapSprite::SetCustomAnimation)
            .def("DisableCustomAnimation", &MapSprite::DisableCustomAnimation)
            .def("AddDialogueReference", (void(MapSprite:: *)(uint32))&MapSprite::AddDialogueReference)
            .def("AddDialogueReference", (void(MapSprite:: *)(SpriteDialogue *))&MapSprite::AddDialogueReference)
            .def("ClearDialogueReferences", &MapSprite::ClearDialogueReferences)
            .def("RemoveDialogueReference", (void(MapSprite:: *)(uint32))&MapSprite::RemoveDialogueReference)
            .def("RemoveDialogueReference", (void(MapSprite:: *)(SpriteDialogue *))&MapSprite::RemoveDialogueReference)
            .def("SetSpriteName", &MapSprite::SetSpriteName)
            .def("GetSpriteName", &MapSprite::GetSpriteName)
            .def("ReloadSprite", &MapSprite::ReloadSprite)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<EnemySprite, MapSprite>("EnemySprite")
            .def(luabind::constructor<>())
            .def(luabind::constructor<std::string>())
            .def("Reset", &EnemySprite::Reset)
            .def("NewEnemyParty", &EnemySprite::NewEnemyParty)
            .def("AddEnemy", (void(EnemySprite:: *)(uint32, float, float))&EnemySprite::AddEnemy)
            .def("AddEnemy", (void(EnemySprite:: *)(uint32))&EnemySprite::AddEnemy)
            .def("GetAggroRange", &EnemySprite::GetAggroRange)
            .def("GetTimeToChange", &EnemySprite::GetTimeToChange)
            .def("GetTimeToSpawn", &EnemySprite::GetTimeToSpawn)
            .def("GetBattleMusicTheme", &EnemySprite::GetBattleMusicTheme)
            .def("IsDead", &EnemySprite::IsDead)
            .def("IsSpawning", &EnemySprite::IsSpawning)
            .def("IsHostile", &EnemySprite::IsHostile)
            .def("SetZone", &EnemySprite::SetZone)
            .def("SetAggroRange", &EnemySprite::SetAggroRange)
            .def("SetTimeToChange", &EnemySprite::SetTimeToChange)
            .def("SetTimeToSpawn", &EnemySprite::SetTimeToSpawn)
            .def("SetBattleMusicTheme", &EnemySprite::SetBattleMusicTheme)
            .def("SetBattleBackground", &EnemySprite::SetBattleBackground)
            .def("AddBattleScript", &EnemySprite::AddBattleScript)
            .def("ChangeStateDead", &EnemySprite::ChangeStateDead)
            .def("ChangeStateSpawning", &EnemySprite::ChangeStateSpawning)
            .def("ChangeStateHostile", &EnemySprite::ChangeStateHostile)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<MapZone>("MapZone")
            .def(luabind::constructor<>())
            .def(luabind::constructor<uint16, uint16, uint16, uint16>())
            .def("AddSection", &MapZone::AddSection)
            .def("IsInsideZone", &MapZone::IsInsideZone)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<CameraZone, MapZone>("CameraZone")
            .def(luabind::constructor<>())
            .def(luabind::constructor<uint16, uint16, uint16, uint16>())
            .def("IsCameraInside", &CameraZone::IsCameraInside)
            .def("IsCameraEntering", &CameraZone::IsCameraEntering)
            .def("IsCameraExiting", &CameraZone::IsCameraExiting)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<EnemyZone, MapZone>("EnemyZone")
            .def(luabind::constructor<>())
            .def(luabind::constructor<uint16, uint16, uint16, uint16>())
            .def("AddEnemy", &EnemyZone::AddEnemy, luabind::adopt(_2))
            .def("AddSpawnSection", &EnemyZone::AddSpawnSection)
            .def("IsRoamingRestrained", &EnemyZone::IsRoamingRestrained)
            .def("GetSpawnTime", &EnemyZone::GetSpawnTime)
            .def("SetRoamingRestrained", &EnemyZone::SetRoamingRestrained)
            .def("SetSpawnTime", &EnemyZone::SetSpawnTime)
            .def("SetSpawnsLeft", &EnemyZone::SetSpawnsLeft)
            .def("GetSpawnsLeft", &EnemyZone::GetSpawnsLeft)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<DialogueSupervisor>("DialogueSupervisor")
            .def("AddDialogue", &DialogueSupervisor::AddDialogue, luabind::adopt(_2))
            .def("BeginDialogue", &DialogueSupervisor::BeginDialogue)
            .def("EndDialogue", &DialogueSupervisor::EndDialogue)
            .def("GetDialogue", &DialogueSupervisor::GetDialogue)
            .def("GetCurrentDialogue", &DialogueSupervisor::GetCurrentDialogue)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<SpriteDialogue, vt_common::CommonDialogue>("SpriteDialogue")
            .def(luabind::constructor<uint32>())
            .def(luabind::constructor<>())
            .def("AddLine", (void(SpriteDialogue:: *)(const std::string &, uint32))&SpriteDialogue::AddLine)
            .def("AddLine", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *))&SpriteDialogue::AddLine)
            .def("AddLineEmote", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, const std::string &))&SpriteDialogue::AddLineEmote)

            .def("AddLine", (void(SpriteDialogue:: *)(const std::string &, uint32, int32))&SpriteDialogue::AddLine)
            .def("AddLine", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, int32))&SpriteDialogue::AddLine)

            .def("AddLineTimed", (void(SpriteDialogue:: *)(const std::string &, uint32, uint32))&SpriteDialogue::AddLineTimed)
            .def("AddLineTimed", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, uint32))&SpriteDialogue::AddLineTimed)

            .def("AddLineTimed", (void(SpriteDialogue:: *)(const std::string &, uint32, int32, uint32))&SpriteDialogue::AddLineTimed)
            .def("AddLineTimed", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, int32, uint32))&SpriteDialogue::AddLineTimed)

            .def("AddLineEvent", (void(SpriteDialogue:: *)(const std::string &, uint32, const std::string &, const std::string &))&SpriteDialogue::AddLineEvent)
            .def("AddLineEvent", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, const std::string &, const std::string &))&SpriteDialogue::AddLineEvent)
            .def("AddLineEventEmote", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, const std::string &, const std::string &, const std::string &))&SpriteDialogue::AddLineEventEmote)

            .def("AddLineEvent", (void(SpriteDialogue:: *)(const std::string &, uint32, int32, const std::string &, const std::string &))&SpriteDialogue::AddLineEvent)
            .def("AddLineEvent", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, int32, const std::string &, const std::string &))&SpriteDialogue::AddLineEvent)

            .def("AddLineTimedEvent", (void(SpriteDialogue:: *)(const std::string &, uint32, uint32, const std::string &, const std::string &))&SpriteDialogue::AddLineTimedEvent)
            .def("AddLineTimedEvent", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, uint32, const std::string &, const std::string &))&SpriteDialogue::AddLineTimedEvent)

            .def("AddLineTimedEvent", (void(SpriteDialogue:: *)(const std::string &, uint32, int32, uint32, const std::string &, const std::string &, const std::string &))&SpriteDialogue::AddLineTimedEvent)
            .def("AddLineTimedEvent", (void(SpriteDialogue:: *)(const std::string &, VirtualSprite *, int32, uint32, const std::string &, const std::string &))&SpriteDialogue::AddLineTimedEvent)

            .def("AddOption", (void(SpriteDialogue:: *)(const std::string &))&SpriteDialogue::AddOption)
            .def("AddOption", (void(SpriteDialogue:: *)(const std::string &, int32))&SpriteDialogue::AddOption)

            .def("AddOptionEvent", (void(SpriteDialogue:: *)(const std::string &, const std::string &))&SpriteDialogue::AddOptionEvent)
            .def("AddOptionEvent", (void(SpriteDialogue:: *)(const std::string &, int32, const std::string &))&SpriteDialogue::AddOptionEvent)

            .def("Validate", &SpriteDialogue::Validate)
            .def("SetInputBlocked", &SpriteDialogue::SetInputBlocked)
            .def("SetRestoreState", &SpriteDialogue::SetRestoreState)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<EventSupervisor>("EventSupervisor")
            .def("RegisterEvent", &EventSupervisor::RegisterEvent, luabind::adopt(_2))
            .def("StartEvent", (void(EventSupervisor:: *)(const std::string &))&EventSupervisor::StartEvent)
            .def("StartEvent", (void(EventSupervisor:: *)(const std::string &, uint32))&EventSupervisor::StartEvent)
            .def("StartEvent", (void(EventSupervisor:: *)(MapEvent *))&EventSupervisor::StartEvent)
            .def("StartEvent", (void(EventSupervisor:: *)(MapEvent *, uint32))&EventSupervisor::StartEvent)
            .def("TerminateEvents", (void(EventSupervisor:: *)(const std::string &, bool))&EventSupervisor::TerminateEvents)
            .def("TerminateEvents", (void(EventSupervisor:: *)(MapEvent *, bool))&EventSupervisor::TerminateEvents)
            .def("TerminateAllEvents", &EventSupervisor::TerminateAllEvents)
            .def("IsEventActive", &EventSupervisor::IsEventActive)
            .def("HasActiveEvent", &EventSupervisor::HasActiveEvent)
            .def("HasActiveDelayedEvent", &EventSupervisor::HasActiveDelayedEvent)
            .def("GetEvent", &EventSupervisor::GetEvent)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<MapEvent>("MapEvent")
            .def("GetEventID", &MapEvent::GetEventID)
            .def("AddEventLinkAtStart", (void(MapEvent:: *)(const std::string &))&MapEvent::AddEventLinkAtStart)
            .def("AddEventLinkAtStart", (void(MapEvent:: *)(const std::string &, uint32))&MapEvent::AddEventLinkAtStart)
            .def("AddEventLinkAtEnd", (void(MapEvent:: *)(const std::string &))&MapEvent::AddEventLinkAtEnd)
            .def("AddEventLinkAtEnd", (void(MapEvent:: *)(const std::string &, uint32))&MapEvent::AddEventLinkAtEnd)
        ];


        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<DialogueEvent, MapEvent>("DialogueEvent")
            .def(luabind::constructor<std::string, uint32>())
            .def(luabind::constructor<std::string, SpriteDialogue *>())
            .def("SetStopCameraMovement", &DialogueEvent::SetStopCameraMovement)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<SoundEvent, MapEvent>("SoundEvent")
            .def(luabind::constructor<std::string, std::string>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<MapTransitionEvent, MapEvent>("MapTransitionEvent")
            .def(luabind::constructor<std::string, std::string, std::string, std::string>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<ScriptedEvent, MapEvent>("ScriptedEvent")
            .def(luabind::constructor<std::string, std::string, std::string>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<SpriteEvent, MapEvent>("SpriteEvent")
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<ScriptedSpriteEvent, SpriteEvent>("ScriptedSpriteEvent")
            .def(luabind::constructor<std::string, uint16, std::string, std::string>())
            .def(luabind::constructor<std::string, VirtualSprite *, std::string, std::string>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<ChangeDirectionSpriteEvent, SpriteEvent>("ChangeDirectionSpriteEvent")
            .def(luabind::constructor<std::string, uint16, uint16>())
            .def(luabind::constructor<std::string, VirtualSprite *, uint16>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<LookAtSpriteEvent, SpriteEvent>("LookAtSpriteEvent")
            .def(luabind::constructor<std::string, uint16, uint16>())
            .def(luabind::constructor<std::string, VirtualSprite *, VirtualSprite *>())
            .def(luabind::constructor<std::string, VirtualSprite *, float, float>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<PathMoveSpriteEvent, SpriteEvent>("PathMoveSpriteEvent")
            .def(luabind::constructor<std::string, uint32, float, float, bool>())
            .def(luabind::constructor<std::string, VirtualSprite *, float, float, bool>())
            .def(luabind::constructor<std::string, VirtualSprite *, VirtualSprite *, bool>())
            .def("SetDestination", (void(PathMoveSpriteEvent:: *)(float, float, bool))&PathMoveSpriteEvent::SetDestination)
            .def("SetDestination", (void(PathMoveSpriteEvent:: *)(VirtualSprite *, bool))&PathMoveSpriteEvent::SetDestination)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<RandomMoveSpriteEvent, SpriteEvent>("RandomMoveSpriteEvent")
            .def(luabind::constructor<std::string, VirtualSprite *, uint32, uint32>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<AnimateSpriteEvent, MapEvent>("AnimateSpriteEvent")
            .def(luabind::constructor<const std::string &, VirtualSprite *, const std::string &, uint32>())
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<BattleEncounterEvent, MapEvent>("BattleEncounterEvent")
            .def(luabind::constructor<std::string>())
            .def("SetMusic", &BattleEncounterEvent::SetMusic)
            .def("SetBackground", &BattleEncounterEvent::SetBackground)
            .def("AddScript", &BattleEncounterEvent::AddScript)
            .def("AddEnemy", &BattleEncounterEvent::AddEnemy)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<ShopEvent, MapEvent>("ShopEvent")
            .def(luabind::constructor<std::string>())
            .def("AddObject", &ShopEvent::AddObject)
            .def("AddTrade", &ShopEvent::AddTrade)
            .def("SetPriceLevels", &ShopEvent::SetPriceLevels)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_map")
        [
            luabind::class_<TreasureEvent, MapEvent>("TreasureEvent")
            .def(luabind::constructor<std::string>())
            .def("SetDrunes", &TreasureEvent::SetDrunes)
            .def("AddObject", &TreasureEvent::AddObject)
            .def("AddEvent", &TreasureEvent::AddEvent)
        ];

    } // End using map mode namespaces



    // ----- Battle Mode bindings
    {
        using namespace vt_battle;
        using namespace vt_battle::private_battle;

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::def("CalculateStandardEvasion", (bool( *)(BattleTarget *)) &CalculateStandardEvasion),
            luabind::def("CalculateStandardEvasionAdder", (bool( *)(BattleTarget *, float)) &CalculateStandardEvasion),
            luabind::def("CalculateStandardEvasionMultiplier", (bool( *)(BattleTarget *, float)) &CalculateStandardEvasionMultiplier),
            luabind::def("CalculatePhysicalDamage", (uint32( *)(BattleActor *, BattleTarget *)) &CalculatePhysicalDamage),
            luabind::def("CalculatePhysicalDamage", (uint32( *)(BattleActor *, BattleTarget *, float)) &CalculatePhysicalDamage),
            luabind::def("CalculatePhysicalDamageAdder", (uint32( *)(BattleActor *, BattleTarget *, int32)) &CalculatePhysicalDamageAdder),
            luabind::def("CalculatePhysicalDamageAdder", (uint32( *)(BattleActor *, BattleTarget *, int32, float)) &CalculatePhysicalDamageAdder),
            luabind::def("CalculatePhysicalDamageMultiplier", (uint32( *)(BattleActor *, BattleTarget *, float)) &CalculatePhysicalDamageMultiplier),
            luabind::def("CalculatePhysicalDamageMultiplier", (uint32( *)(BattleActor *, BattleTarget *, float, float)) &CalculatePhysicalDamageMultiplier),
            luabind::def("CalculateMagicalDamage", (uint32( *)(BattleActor *, BattleTarget *)) &CalculateMagicalDamage),
            luabind::def("CalculateMagicalDamage", (uint32( *)(BattleActor *, BattleTarget *, float)) &CalculateMagicalDamage),
            luabind::def("CalculateMagicalDamageAdder", (uint32( *)(BattleActor *, BattleTarget *, int32)) &CalculateMagicalDamageAdder),
            luabind::def("CalculateMagicalDamageAdder", (uint32( *)(BattleActor *, BattleTarget *, int32, float)) &CalculateMagicalDamageAdder),
            luabind::def("CalculateMagicalDamageMultiplier", (uint32( *)(BattleActor *, BattleTarget *, float)) &CalculateMagicalDamageMultiplier),
            luabind::def("CalculateMagicalDamageMultiplier", (uint32( *)(BattleActor *, BattleTarget *, float, float)) &CalculateMagicalDamageMultiplier)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleMode, vt_mode_manager::GameMode>("BattleMode")
            .def(luabind::constructor<>())
            .def("AddEnemy", (void(BattleMode:: *)(uint32, float, float))&BattleMode::AddEnemy)
            .def("RestartBattle", &BattleMode::RestartBattle)
            .def("AreActorStatesPaused", &BattleMode::AreActorStatesPaused)
            .def("GetState", &BattleMode::GetState)
            .def("ChangeState", &BattleMode::ChangeState)
            .def("OpenCommandMenu", &BattleMode::OpenCommandMenu)
            .def("IsBattleFinished", &BattleMode::IsBattleFinished)
            .def("GetNumberOfCharacters", &BattleMode::GetNumberOfCharacters)
            .def("GetNumberOfEnemies", &BattleMode::GetNumberOfEnemies)
            .def("GetMedia", &BattleMode::GetMedia)
            .def("GetDialogueSupervisor", &BattleMode::GetDialogueSupervisor)
            .def("GetCommandSupervisor", &BattleMode::GetCommandSupervisor)
            .def("GetBattleType", &BattleMode::GetBattleType)
            .def("SetBattleType", &BattleMode::SetBattleType)
            .def("TriggerBattleParticleEffect", &BattleMode::TriggerBattleParticleEffect)

            // Namespace constants
            .enum_("constants") [
                // Battle states
                luabind::value("BATTLE_STATE_INITIAL", BATTLE_STATE_INITIAL),
                luabind::value("BATTLE_STATE_NORMAL", BATTLE_STATE_NORMAL),
                luabind::value("BATTLE_STATE_COMMAND", BATTLE_STATE_COMMAND),
                luabind::value("BATTLE_STATE_VICTORY", BATTLE_STATE_VICTORY),
                luabind::value("BATTLE_STATE_DEFEAT", BATTLE_STATE_DEFEAT),
                luabind::value("BATTLE_STATE_EXITING", BATTLE_STATE_EXITING),

                // Battle settings
                luabind::value("BATTLE_TYPE_INVALID", BATTLE_TYPE_INVALID),
                luabind::value("BATTLE_TYPE_WAIT", BATTLE_TYPE_WAIT),
                luabind::value("BATTLE_TYPE_SEMI_ACTIVE", BATTLE_TYPE_SEMI_ACTIVE),
                luabind::value("BATTLE_TYPE_ACTIVE", BATTLE_TYPE_ACTIVE),
                luabind::value("BATTLE_TYPE_TOTAL", BATTLE_TYPE_TOTAL)
            ]
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleMedia>("BattleMedia")
            .def("SetBackgroundImage", &BattleMedia::SetBackgroundImage)
            .def("SetBattleMusic", &BattleMedia::SetBattleMusic)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleActor, vt_global::GlobalActor>("BattleActor")
            .def("ChangeSpriteAnimation", &BattleActor::ChangeSpriteAnimation)
            .def("RegisterDamage", (void(BattleActor:: *)(uint32)) &BattleActor::RegisterDamage)
            .def("RegisterDamage", (void(BattleActor:: *)(uint32, BattleTarget *)) &BattleActor::RegisterDamage)
            .def("RegisterHealing", &BattleActor::RegisterHealing)
            .def("RegisterRevive", &BattleActor::RegisterRevive)
            .def("RegisterMiss", &BattleActor::RegisterMiss)
            .def("RegisterStatusChange", &BattleActor::RegisterStatusChange)
            .def("SetStunned", &BattleActor::SetStunned)
            .def("ResetHitPoints", &BattleActor::ResetHitPoints)
            .def("ResetMaxHitPoints", &BattleActor::ResetMaxHitPoints)
            .def("ResetSkillPoints", &BattleActor::ResetSkillPoints)
            .def("ResetMaxSkillPoints", &BattleActor::ResetMaxSkillPoints)
            .def("ResetStrength", &BattleActor::ResetStrength)
            .def("ResetVigor", &BattleActor::ResetVigor)
            .def("ResetFortitude", &BattleActor::ResetFortitude)
            .def("ResetProtection", &BattleActor::ResetProtection)
            .def("ResetAgility", &BattleActor::ResetAgility)
            .def("SetAgility", &BattleActor::SetAgility)
            .def("ResetEvade", &BattleActor::ResetEvade)
            .def("GetXOrigin", &BattleActor::GetXOrigin)
            .def("GetYOrigin", &BattleActor::GetYOrigin)
            .def("GetXLocation", &BattleActor::GetXLocation)
            .def("GetYLocation", &BattleActor::GetYLocation)
            .def("SetXLocation", &BattleActor::SetXLocation)
            .def("SetYLocation", &BattleActor::SetYLocation)
            .def("GetSpriteWidth", &BattleActor::GetSpriteWidth)
            .def("GetSpriteHeight", &BattleActor::GetSpriteHeight)
            .def("SetShowAmmo", &BattleActor::SetShowAmmo)
            .def("SetAmmoPosition", &BattleActor::SetAmmoPosition)
            .def("GetAmmo", &BattleActor::GetAmmo)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleAmmo, BattleActor>("BattleAmmo")

            .def("LoadAmmoAnimatedImage", &BattleAmmo::LoadAmmoAnimatedImage)
            .def("SetFlyingHeight", &BattleAmmo::SetFlyingHeight)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleCharacter, BattleActor>("BattleCharacter")
            .def("ChangeSpriteAnimation", &BattleCharacter::ChangeSpriteAnimation)
            .def("GetSpriteWidth", &BattleCharacter::GetSpriteWidth)
            .def("GetSpriteHeight", &BattleCharacter::GetSpriteHeight)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleEnemy, BattleActor>("BattleEnemy")
            .def("ChangeSpriteAnimation", &BattleEnemy::ChangeSpriteAnimation)
            .def("GetSpriteWidth", &BattleEnemy::GetSpriteWidth)
            .def("GetSpriteHeight", &BattleEnemy::GetSpriteHeight)
            .def("GetSpriteAlpha", &BattleEnemy::GetSpriteAlpha)
            .def("SetSpriteAlpha", &BattleEnemy::SetSpriteAlpha)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<CommandSupervisor>("CommandSupervisor")
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleDialogue, vt_common::CommonDialogue>("BattleDialogue")
            .def(luabind::constructor<uint32>())
            .def("AddLine", (void(BattleDialogue:: *)(const std::string &, uint32))&BattleDialogue::AddLine)
            .def("AddLine", (void(BattleDialogue:: *)(const std::string &, uint32, int32))&BattleDialogue::AddLine)
            .def("AddLineTimed", (void(BattleDialogue:: *)(const std::string &, uint32, uint32))&BattleDialogue::AddLineTimed)
            .def("AddLineTimed", (void(BattleDialogue:: *)(const std::string &, uint32, int32, uint32))&BattleDialogue::AddLineTimed)
            .def("AddOption", (void(BattleDialogue:: *)(const std::string &))&BattleDialogue::AddOption)
            .def("AddOption", (void(BattleDialogue:: *)(const std::string &, int32))&BattleDialogue::AddOption)
            .def("Validate", &BattleDialogue::Validate)
            .def("SetHaltBattleAction", &BattleDialogue::SetHaltBattleAction)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<DialogueSupervisor>("DialogueSupervisor")
            .def("AddDialogue", &DialogueSupervisor::AddDialogue, luabind::adopt(_2))
            .def("AddCharacterSpeaker", &DialogueSupervisor::AddCharacterSpeaker)
            .def("AddEnemySpeaker", &DialogueSupervisor::AddEnemySpeaker)
            .def("AddCustomSpeaker", &DialogueSupervisor::AddCustomSpeaker)
            .def("ChangeSpeakerName", &DialogueSupervisor::ChangeSpeakerName)
            .def("ChangeSpeakerPortrait", &DialogueSupervisor::ChangeSpeakerPortrait)
            .def("BeginDialogue", &DialogueSupervisor::BeginDialogue)
            .def("EndDialogue", &DialogueSupervisor::EndDialogue)
            .def("ForceNextLine", &DialogueSupervisor::ForceNextLine)
            .def("IsDialogueActive", &DialogueSupervisor::IsDialogueActive)
            .def("GetCurrentDialogue", &DialogueSupervisor::GetCurrentDialogue)
            .def("GetLineCounter", &DialogueSupervisor::GetLineCounter)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleTarget>("BattleTarget")
            .def("SetPointTarget", &BattleTarget::SetPointTarget)
            .def("SetActorTarget", &BattleTarget::SetActorTarget)
            .def("SetPartyTarget", &BattleTarget::SetPartyTarget)
            .def("IsValid", &BattleTarget::IsValid)
            .def("SelectNextPoint", &BattleTarget::SelectNextPoint)
            .def("SelectNextActor", &BattleTarget::SelectNextActor)
            .def("GetType", &BattleTarget::GetType)
            .def("GetPoint", &BattleTarget::GetPoint)
            .def("GetActor", &BattleTarget::GetActor)
            .def("GetPartyActor", &BattleTarget::GetPartyActor)
        ];

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_battle")
        [
            luabind::class_<BattleStatusEffect, vt_global::GlobalStatusEffect>("BattleStatusEffect")
            .def("GetAffectedActor", &BattleStatusEffect::GetAffectedActor)
            .def("GetTimer", &BattleStatusEffect::GetTimer)
            .def("HasIntensityChanged", &BattleStatusEffect::HasIntensityChanged)
        ];

    } // End using battle mode namespaces

    // ----- Menu Mode Bindings
    {
        using namespace vt_menu;

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_menu")
        [
            luabind::class_<MenuMode, vt_mode_manager::GameMode>("MenuMode")
            .def(luabind::constructor<>())
        ];

    } // End using menu mode namespaces


    // ----- Shop Mode Bindings
    {
        using namespace vt_shop;

        luabind::module(vt_script::ScriptManager->GetGlobalState(), "vt_shop")
        [
            luabind::class_<ShopMode, vt_mode_manager::GameMode>("ShopMode")
            .def(luabind::constructor<>())
            .def("AddObject", &ShopMode::AddObject)
            .def("AddTrade", &ShopMode::AddTrade)
            .def("SetPriceLevels", &ShopMode::SetPriceLevels)

            .enum_("constants") [
                // Price levels
                luabind::value("SHOP_PRICE_VERY_GOOD", SHOP_PRICE_VERY_GOOD),
                luabind::value("SHOP_PRICE_GOOD", SHOP_PRICE_GOOD),
                luabind::value("SHOP_PRICE_STANDARD", SHOP_PRICE_STANDARD),
                luabind::value("SHOP_PRICE_POOR", SHOP_PRICE_POOR),
                luabind::value("SHOP_PRICE_VERY_POOR", SHOP_PRICE_VERY_POOR)
            ]
        ];

    } // End using shop mode namespaces
} // void BindModeCode()

} // namespace vt_defs
