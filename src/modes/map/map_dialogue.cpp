///////////////////////////////////////////////////////////////////////////////
//            Copyright (C) 2004-2011 by The Allacrost Project
//            Copyright (C) 2012-2013 by Bertram (Valyria Tear)
//                         All Rights Reserved
//
// This code is licensed under the GNU GPL version 2. It is free software
// and you may modify it and/or redistribute it under the terms of this license.
// See http://www.gnu.org/copyleft/gpl.html for details.
///////////////////////////////////////////////////////////////////////////////

/** ****************************************************************************
*** \file    map_dialogue.cpp
*** \author  Tyler Olsen, roots@allacrost.org
*** \author  Yohann Ferreira, yohann ferreira orange fr
*** \brief   Source file for map mode dialogue.
*** ***************************************************************************/

#include "modes/map/map_dialogue.h"

#include "modes/map/map_mode.h"
#include "modes/map/map_events.h"
#include "modes/map/map_sprites.h"

#include "engine/input.h"

namespace vt_common {
extern bool COMMON_DEBUG;
}

using namespace vt_utils;
using namespace vt_audio;
using namespace vt_video;
using namespace vt_gui;
using namespace vt_input;
using namespace vt_mode_manager;
using namespace vt_script;
using namespace vt_system;
using namespace vt_global;
using namespace vt_common;

namespace vt_map
{

namespace private_map
{

///////////////////////////////////////////////////////////////////////////////
// SpriteDialogue Class Functions
///////////////////////////////////////////////////////////////////////////////

SpriteDialogue::SpriteDialogue(uint32 id) :
    CommonDialogue(id),
    _input_blocked(false),
    _restore_state(true),
    _event_name("dialogue#" + vt_utils::NumberToString(id))
{}

SpriteDialogue::SpriteDialogue() :
    CommonDialogue(MapMode::CurrentInstance()->GetDialogueSupervisor()->GenerateDialogueID()),
    _input_blocked(false),
    _restore_state(true)
{
    _event_name = "dialogue#" + vt_utils::NumberToString(GetDialogueID());
}

void SpriteDialogue::AddLine(const std::string &text, uint32 speaker_id)
{
    AddLineTimedEvent(text, speaker_id, COMMON_DIALOGUE_NEXT_LINE, COMMON_DIALOGUE_NO_TIMER,
                      std::string(), std::string(), std::string());
}

void SpriteDialogue::AddLine(const std::string &text, VirtualSprite *speaker)
{
    AddLine(text, speaker->GetObjectID());
}

void SpriteDialogue::AddLineEmote(const std::string &text, VirtualSprite *speaker,
                                  const std::string &emote_id)
{
    AddLineTimedEvent(text, speaker->GetObjectID(), COMMON_DIALOGUE_NEXT_LINE, COMMON_DIALOGUE_NO_TIMER,
                      std::string(), std::string(), emote_id);
}

void SpriteDialogue::AddLine(const std::string &text, uint32 speaker_id, int32 next_line)
{
    AddLineTimedEvent(text, speaker_id, next_line, COMMON_DIALOGUE_NO_TIMER,
                      std::string(), std::string(), std::string());
}

void SpriteDialogue::AddLine(const std::string &text, VirtualSprite *speaker, int32 next_line)
{
    AddLine(text, speaker->GetObjectID(), next_line);
}

void SpriteDialogue::AddLineTimed(const std::string &text, uint32 speaker_id, uint32 display_time)
{
    AddLineTimedEvent(text, speaker_id, COMMON_DIALOGUE_NEXT_LINE, display_time,
                      std::string(), std::string(), std::string());
}

void SpriteDialogue::AddLineTimed(const std::string &text, VirtualSprite *speaker, uint32 display_time)
{
    AddLineTimed(text, speaker->GetObjectID(), display_time);
}

void SpriteDialogue::AddLineTimed(const std::string &text, uint32 speaker_id, int32 next_line, uint32 display_time)
{
    AddLineTimedEvent(text, speaker_id, next_line, display_time,
                      std::string(), std::string(), std::string());
}

void SpriteDialogue::AddLineTimed(const std::string &text, VirtualSprite *speaker, int32 next_line, uint32 display_time)
{
    AddLineTimed(text, speaker->GetObjectID(), next_line, display_time);
}

void SpriteDialogue::AddLineEvent(const std::string &text, uint32 speaker_id,
                                  const std::string &begin_event_id, const std::string &end_event_id)
{
    AddLineTimedEvent(text, speaker_id, COMMON_DIALOGUE_NEXT_LINE, COMMON_DIALOGUE_NO_TIMER,
                      begin_event_id, end_event_id, std::string());
}

void SpriteDialogue::AddLineEvent(const std::string &text, VirtualSprite *speaker,
                                  const std::string &begin_event_id, const std::string &end_event_id)
{
    AddLineEvent(text, speaker->GetObjectID(), begin_event_id, end_event_id);
}

void SpriteDialogue::AddLineEventEmote(const std::string &text, VirtualSprite *speaker,
                                       const std::string &begin_event_id,
                                       const std::string &end_event_id,
                                       const std::string &emote_id)
{
    AddLineTimedEvent(text, speaker->GetObjectID(), COMMON_DIALOGUE_NEXT_LINE,
                      COMMON_DIALOGUE_NO_TIMER,
                      begin_event_id, end_event_id, emote_id);
}

void SpriteDialogue::AddLineEvent(const std::string &text, uint32 speaker_id, int32 next_line,
                                  const std::string &begin_event_id, const std::string &end_event_id)
{
    AddLineTimedEvent(text, speaker_id, next_line, COMMON_DIALOGUE_NO_TIMER,
                      begin_event_id, end_event_id, std::string());
}

void SpriteDialogue::AddLineEvent(const std::string &text, VirtualSprite *speaker, int32 next_line,
                                  const std::string &begin_event_id, const std::string &end_event_id)
{
    AddLineEvent(text, speaker->GetObjectID(),
                 next_line, begin_event_id, end_event_id);
}

void SpriteDialogue::AddLineTimedEvent(const std::string &text, uint32 speaker_id, uint32 display_time,
                                       const std::string &begin_event_id, const std::string &end_event_id)
{
    AddLineTimedEvent(text, speaker_id, COMMON_DIALOGUE_NEXT_LINE, display_time,
                      begin_event_id, end_event_id, std::string());
}

void SpriteDialogue::AddLineTimedEvent(const std::string &text, VirtualSprite *speaker, uint32 display_time,
                                       const std::string &begin_event_id, const std::string &end_event_id)
{
    AddLineTimedEvent(text, speaker->GetObjectID(), display_time,
                      begin_event_id, end_event_id);
}

void SpriteDialogue::AddLineTimedEvent(const std::string &text, uint32 speaker_id, int32 next_line, uint32 display_time,
                                       const std::string &begin_event_id, const std::string &end_event_id,
                                       const std::string &emote_id)
{
    CommonDialogue::AddLineTimed(text, next_line, display_time);
    _speakers.push_back(speaker_id);
    _begin_events.push_back(begin_event_id);
    _end_events.push_back(end_event_id);
    _emote_events.push_back(emote_id);
}

void SpriteDialogue::AddLineTimedEvent(const std::string &text, VirtualSprite *speaker, int32 next_line, uint32 display_time,
                                       const std::string &begin_event_id, const std::string &end_event_id)
{
    AddLineTimedEvent(text, speaker->GetObjectID(), next_line, display_time,
                      begin_event_id, end_event_id, std::string());
}

void SpriteDialogue::AddOption(const std::string &text)
{
    AddOptionEvent(text, COMMON_DIALOGUE_NEXT_LINE, std::string());
}

void SpriteDialogue::AddOption(const std::string &text, int32 next_line)
{
    AddOptionEvent(text, next_line, std::string());
}

void SpriteDialogue::AddOptionEvent(const std::string &text, const std::string &event_id)
{
    AddOptionEvent(text, COMMON_DIALOGUE_NEXT_LINE, event_id);
}

void SpriteDialogue::AddOptionEvent(const std::string &text, int32 next_line, const std::string &event_id)
{
    if(_line_count == 0) {
        IF_PRINT_WARNING(MAP_DEBUG) << "Attempted to add an option to a dialogue with no lines" << std::endl;
        return;
    }

    uint32 current_line = _line_count - 1;

    // If the line the options will be added to currently has no options, create a new instance of the MapDialogueOptions class to store the options in.
    if(_options[current_line] == NULL) {
        _options[current_line] = new MapDialogueOptions();
    }

    MapDialogueOptions *options = dynamic_cast<MapDialogueOptions *>(_options[current_line]);
    options->AddOptionEvent(text, next_line, event_id);
}

bool SpriteDialogue::Validate()
{
    if(CommonDialogue::Validate() == false) {
        // The CommonDialogue::Validate() call will print the appropriate warning if debugging is enabled (common code debugging that is)
        return false;
    }

    // Construct containers that hold all unique sprite and event ids for this dialogue
    std::set<uint32> sprite_ids;
    std::set<std::string> event_ids;
    for(uint32 i = 0; i < _line_count; i++) {
        sprite_ids.insert(_speakers[i]);
        event_ids.insert(_end_events[i]);
    }

    // Check that all sprites and events referrenced by the dialogue exist
    for(std::set<uint32>::iterator i = sprite_ids.begin(); i != sprite_ids.end(); i++) {
        if(MapMode::CurrentInstance()->GetObjectSupervisor()->GetSprite(*i) == NULL) {
            IF_PRINT_WARNING(MAP_DEBUG) << "Validation failed for dialogue #" << _dialogue_id
                                        << ": dialogue referenced invalid sprite with id: " << *i << std::endl;
            return false;
        }
    }

    for(std::set<std::string>::iterator i = event_ids.begin(); i != event_ids.end(); i++) {
        if(!(*i).empty()) {
            if(MapMode::CurrentInstance()->GetEventSupervisor()->GetEvent(*i) == NULL) {
                IF_PRINT_WARNING(MAP_DEBUG) << "Validation failed for dialogue #" << _dialogue_id
                                            << ": dialogue referenced invalid event with id: " << *i << std::endl;
                return false;
            }
        }
    }

    return true;
}

///////////////////////////////////////////////////////////////////////////////
// MapDialogueOptions Class Functions
///////////////////////////////////////////////////////////////////////////////

void MapDialogueOptions::AddOption(const std::string &text)
{
    AddOptionEvent(text, COMMON_DIALOGUE_NEXT_LINE, std::string());
}

void MapDialogueOptions::AddOption(const std::string &text, int32 next_line)
{
    AddOptionEvent(text, next_line, std::string());
}

void MapDialogueOptions::AddOptionEvent(const std::string &text, const std::string &event_id)
{
    AddOptionEvent(text, COMMON_DIALOGUE_NEXT_LINE, event_id);
}

void MapDialogueOptions::AddOptionEvent(const std::string &text, int32 next_line, const std::string &event_id)
{
    CommonDialogueOptions::AddOption(text, next_line);
    _events.push_back(event_id);
}

///////////////////////////////////////////////////////////////////////////////
// DialogueSupervisor Class Functions
///////////////////////////////////////////////////////////////////////////////

DialogueSupervisor::DialogueSupervisor() :
    _state(DIALOGUE_STATE_INACTIVE),
    _current_dialogue(NULL),
    _current_options(NULL),
    _line_timer(),
    _line_counter(0),
    _dialogue_window(),
    _emote_triggered(false)
{
    _dialogue_window.SetPosition(512.0f, 760.0f);
}

DialogueSupervisor::~DialogueSupervisor()
{
    _current_dialogue = NULL;
    _current_options = NULL;

    // Delete all dialogues
    for(std::map<uint32, SpriteDialogue *>::iterator i = _dialogues.begin(); i != _dialogues.end(); i++) {
        delete i->second;
    }
    _dialogues.clear();
}

void DialogueSupervisor::Update()
{
    if(_current_dialogue == NULL) {
        IF_PRINT_WARNING(MAP_DEBUG) << "attempted to update when no dialogue was active" << std::endl;
        return;
    }

    _line_timer.Update();

    switch(_state) {
    case DIALOGUE_STATE_EMOTE:
        _UpdateEmote();
        break;
    case DIALOGUE_STATE_LINE:
        _UpdateLine();
        break;
    case DIALOGUE_STATE_OPTION:
        _UpdateOptions();
        break;
    default:
        IF_PRINT_WARNING(MAP_DEBUG) << "dialogue supervisor was in an unknown state: " << _state << std::endl;
        _state = DIALOGUE_STATE_LINE;
        break;
    }
}

void DialogueSupervisor::Draw()
{
    if(_state != DIALOGUE_STATE_EMOTE)
        _dialogue_window.Draw();
}

void DialogueSupervisor::AddDialogue(SpriteDialogue *dialogue)
{
    if(dialogue == NULL) {
        PRINT_WARNING << "function received NULL argument" << std::endl;
        return;
    }

    if(GetDialogue(dialogue->GetDialogueID()) != NULL) {
        PRINT_WARNING << "A dialogue was already registered with this ID: " << dialogue->GetDialogueID() << std::endl;
        delete dialogue;
        return;
    } else {
        _dialogues.insert(std::make_pair(dialogue->GetDialogueID(), dialogue));
    }
}

void DialogueSupervisor::BeginDialogue(uint32 dialogue_id)
{
    SpriteDialogue *dialogue = GetDialogue(dialogue_id);

    if(dialogue == NULL) {
        IF_PRINT_WARNING(COMMON_DEBUG) << "could not begin dialogue because none existed for id# " << dialogue_id << std::endl;
        return;
    }

    if(_current_dialogue != NULL) {
        IF_PRINT_WARNING(COMMON_DEBUG) << "beginning a new dialogue while another dialogue is still active" << std::endl;
    }

    _line_counter = 0;
    _current_dialogue = dialogue;
    _emote_triggered = false;
    _BeginLine();
    MapMode::CurrentInstance()->PushState(STATE_DIALOGUE);
}

void DialogueSupervisor::EndDialogue()
{
    if(_current_dialogue == NULL) {
        IF_PRINT_WARNING(COMMON_DEBUG) << "tried to end a dialogue when there was no dialogue active" << std::endl;
        return;
    }

    _current_dialogue->SetAsSeen();

    // We only want to call the RestoreState function *once* for each speaker, so first we have to construct a list of pointers
    // for all speakers without duplication (i.e. the case where a speaker spoke more than one line of dialogue).

    // Get a unique set of all sprites that participated in the dialogue
    std::set<MapSprite *> speakers;
    for(uint32 i = 0; i < _current_dialogue->GetLineCount(); i++) {
        speakers.insert(dynamic_cast<MapSprite *>(MapMode::CurrentInstance()->GetObjectSupervisor()->GetObject(_current_dialogue->GetLineSpeaker(i))));
    }

    for(std::set<MapSprite *>::iterator i = speakers.begin(); i != speakers.end(); i++) {
        if(!(*i))
            continue;
        // Each sprite needs to know that this dialogue completed so that they can update their data accordingly
        (*i)->UpdateDialogueStatus();

        // Restore the state (orientation, animation, etc.) of all speaker sprites if necessary
        if(_current_dialogue->IsRestoreState() == true) {
            if((*i)->IsStateSaved() == true)
                (*i)->RestoreState();
        }
    }

    _current_dialogue = NULL;
    _current_options = NULL;
    MapMode::CurrentInstance()->PopState();
}

SpriteDialogue *DialogueSupervisor::GetDialogue(uint32 dialogue_id)
{
    std::map<uint32, SpriteDialogue *>::iterator it = _dialogues.find(dialogue_id);
    if(it == _dialogues.end())
        return NULL;

    return it->second;
}

void DialogueSupervisor::_UpdateEmote()
{
    MapObject *object = MapMode::CurrentInstance()->GetObjectSupervisor()->GetObject(_current_dialogue->GetLineSpeaker(_line_counter));
    if(!object || !object->HasEmote()) {
        _emote_triggered = true;
        _BeginLine();
    }
}

void DialogueSupervisor::_UpdateLine()
{
    _dialogue_window.GetDisplayTextBox().Update();

    // If the line has a valid display time and the timer is finished, move on to the next line
    if((_line_timer.GetDuration() > 0) && (_line_timer.IsFinished() == true)) {
        _EndLine();
        return;
    }

    // Set the correct indicator
    if(_current_dialogue->IsInputBlocked() || _current_options != NULL || _dialogue_window.GetDisplayTextBox().IsFinished() == false) {
        _dialogue_window.SetIndicator(COMMON_DIALOGUE_NO_INDICATOR);
    } else if(_line_counter == _current_dialogue->GetLineCount() - 1) {
        _dialogue_window.SetIndicator(COMMON_DIALOGUE_LAST_INDICATOR);
    } else {
        _dialogue_window.SetIndicator(COMMON_DIALOGUE_NEXT_INDICATOR);
    }

    // If this dialogue does not allow user input, we are finished
    if(_current_dialogue->IsInputBlocked() == true) {
        return;
    }

    if(InputManager->ConfirmPress()) {
        // If the line is not yet finished displaying, display the rest of the text
        if(_dialogue_window.GetDisplayTextBox().IsFinished() == false) {
            _dialogue_window.GetDisplayTextBox().ForceFinish();
        }
        // Proceed to option selection if the line has options
        else if(_current_options != NULL) {
            _state = DIALOGUE_STATE_OPTION;
        } else {
            _EndLine();
        }
    }
}

void DialogueSupervisor::_UpdateOptions()
{
    _dialogue_window.GetDisplayTextBox().Update();
    _dialogue_window.GetDisplayOptionBox().Update();
    if(InputManager->ConfirmPress()) {
        _dialogue_window.GetDisplayOptionBox().InputConfirm();
        _EndLine();
    }

    else if(InputManager->UpPress()) {
        _dialogue_window.GetDisplayOptionBox().InputUp();
    }

    else if(InputManager->DownPress()) {
        _dialogue_window.GetDisplayOptionBox().InputDown();
    }
}

void DialogueSupervisor::_BeginLine()
{
    // Starts possible events at new line.
    MapMode *map_mode = MapMode::CurrentInstance();
    std::string line_event = _current_dialogue->GetLineBeginEvent(_line_counter);
    if(!line_event.empty() && !map_mode->GetEventSupervisor()->IsEventActive(line_event)) {
        map_mode->GetEventSupervisor()->StartEvent(line_event);
    }

    // Starts possible emote first.
    std::string emote_event = _current_dialogue->GetLineEmote(_line_counter);
    if(!emote_event.empty() && !_emote_triggered) {
        MapSprite *sprite = dynamic_cast<MapSprite *>(map_mode->GetObjectSupervisor()->GetObject(_current_dialogue->GetLineSpeaker(_line_counter)));
        if(sprite) {
            sprite->Emote(emote_event, (vt_map::private_map::ANIM_DIRECTIONS)sprite->GetCurrentAnimationDirection());
            _state = DIALOGUE_STATE_EMOTE;
            _emote_triggered = true;
            return;
        }
    }

    _emote_triggered = true;
    _state = DIALOGUE_STATE_LINE;
    _current_options = dynamic_cast<MapDialogueOptions *>(_current_dialogue->GetLineOptions(_line_counter));

    // Initialize the line timer
    if(_current_dialogue->GetLineDisplayTime(_line_counter) >= 0) {
        _line_timer.Initialize(_current_dialogue->GetLineDisplayTime(_line_counter));
        _line_timer.Run();
    }
    // If the line has no timer specified, set the line time to zero and put the timer in the finished state
    else {
        _line_timer.Initialize(0);
        _line_timer.Finish();
    }

    // Setup the text and graphics for the dialogue window
    _dialogue_window.Clear();
    _dialogue_window.GetDisplayTextBox().SetDisplayText(_current_dialogue->GetLineText(_line_counter));

    MapObject *object = map_mode->GetObjectSupervisor()->GetObject(_current_dialogue->GetLineSpeaker(_line_counter));
    if(object == NULL) {
        IF_PRINT_WARNING(MAP_DEBUG) << "dialogue #" << _current_dialogue->GetDialogueID()
                                    << " referenced a sprite that did not exist with id: " << _current_dialogue->GetLineSpeaker(_line_counter) << std::endl;
        return;
    } else if(object->GetType() != SPRITE_TYPE) {
        IF_PRINT_WARNING(MAP_DEBUG) << "dialogue #" << _current_dialogue->GetDialogueID()
                                    << " referenced a map object which was not a sprite with id: " << _current_dialogue->GetLineSpeaker(_line_counter) << std::endl;
        return;
    } else {
        MapSprite *speaker = dynamic_cast<MapSprite *>(object);
        _dialogue_window.GetNameText().SetText(speaker->GetName());
        _dialogue_window.SetPortraitImage(speaker->GetFacePortrait());
    }

    if(_current_options) {
        for(uint32 i = 0; i < _current_options->GetNumberOptions(); ++i)
            _dialogue_window.GetDisplayOptionBox().AddOption(_current_options->GetOptionText(i));

        _dialogue_window.GetDisplayOptionBox().SetSelection(0);
        _state = DIALOGUE_STATE_OPTION;
    }
}

void DialogueSupervisor::_EndLine()
{
    // Execute any scripted events that should occur after this line of dialogue has finished
    std::string line_event = _current_dialogue->GetLineEndEvent(_line_counter);
    if(!line_event.empty()) {
        MapMode::CurrentInstance()->GetEventSupervisor()->StartEvent(line_event);
    }

    if(_current_options != NULL) {
        uint32 selected_option = _dialogue_window.GetDisplayOptionBox().GetSelection();
        std::string selected_event = _current_options->GetOptionEvent(selected_option);
        if(!selected_event.empty()) {
            MapMode::CurrentInstance()->GetEventSupervisor()->StartEvent(selected_event);
        }
    }

    // Determine the next line to read
    int32 next_line = _current_dialogue->GetLineNextLine(_line_counter);
    // If this line had options, the selected option next line overrides the line's next line that we set above
    if(_current_options != NULL) {
        uint32 selected_option = _dialogue_window.GetDisplayOptionBox().GetSelection();
        next_line = _current_options->GetOptionNextLine(selected_option);
    }

    // --- Case 1: Explicitly setting the next line. Warn and end the dialogue if the line to move to is invalid
    if(next_line >= 0) {
        if(static_cast<uint32>(next_line) >= _current_dialogue->GetLineCount()) {
            IF_PRINT_WARNING(MAP_DEBUG) << "dialogue #" << _current_dialogue->GetDialogueID()
                                        << " tried to set dialogue to invalid line. Current/next line values: {" << _line_counter
                                        << ", " << next_line << "}" << std::endl;
            next_line = COMMON_DIALOGUE_END;
        }
    }
    // --- Case 2: Request to incrementing the current line. If we're incrementing past the last line, end the dialogue
    else if(next_line == COMMON_DIALOGUE_NEXT_LINE) {
        next_line = _line_counter + 1;
        if(static_cast<uint32>(next_line) >= _current_dialogue->GetLineCount())
            next_line = COMMON_DIALOGUE_END;
    }
    // --- Case 3: Request to end the current dialogue
    else if(next_line == COMMON_DIALOGUE_END) {
        // Do nothing
    }
    // --- Case 4: Unknown negative value. Warn and end dialogue
    else {
        IF_PRINT_WARNING(MAP_DEBUG) << "dialogue #" << _current_dialogue->GetDialogueID()
                                    << " unknown next line control value: " << next_line << std::endl;
        next_line = COMMON_DIALOGUE_END;
    }

    // Now either end the dialogue or move on to the next line
    if(next_line == COMMON_DIALOGUE_END) {
        EndDialogue();
    } else {
        _line_counter = next_line;
        // Reset the emote trigger flag for the next line.
        _emote_triggered = false;
        _BeginLine();
    }
}

} // namespace private_map

} // namespace vt_map
