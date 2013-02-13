///////////////////////////////////////////////////////////////////////////////
//            Copyright (C) 2004-2010 by The Allacrost Project
//                         All Rights Reserved
//
// This code is licensed under the GNU GPL version 2. It is free software
// and you may modify it and/or redistribute it under the terms of this license.
// See http://www.gnu.org/copyleft/gpl.html for details.
///////////////////////////////////////////////////////////////////////////////

#include "defs.h"
#include "utils.h"

#include "engine/audio/audio.h"
#include "engine/input.h"
#include "engine/system.h"
#include "engine/video/video.h"

#include "common/global/global.h"

#include "shop.h"
#include "shop_trade.h"

using namespace hoa_utils;
using namespace hoa_audio;
using namespace hoa_input;
using namespace hoa_system;
using namespace hoa_video;
using namespace hoa_gui;
using namespace hoa_global;

namespace hoa_shop
{

namespace private_shop
{

// *****************************************************************************
// ***** TradeInterface class methods
// *****************************************************************************

TradeInterface::TradeInterface() :
    _view_mode(SHOP_VIEW_MODE_INVALID),
    _selected_object(NULL),
    _trade_deal_types(0),
    _current_category(0)
{
    _category_header.SetStyle(TextStyle("title24"));
    _category_header.SetText(UTranslate("Category"));

    _name_header.SetStyle(TextStyle("title24"));
    _name_header.SetText(UTranslate("Name"));

    _properties_header.SetDimensions(300.0f, 30.0f, 3, 1, 3, 1);
    _properties_header.SetOptionAlignment(VIDEO_X_RIGHT, VIDEO_Y_CENTER);
    _properties_header.SetTextStyle(TextStyle("title24"));
    _properties_header.SetCursorState(VIDEO_CURSOR_STATE_HIDDEN);
    _properties_header.AddOption(UTranslate("Price"));
    _properties_header.AddOption(UTranslate("Stock"));
    _properties_header.AddOption(UTranslate("Own"));

    _selected_name.SetStyle(TextStyle("text22"));

    _selected_properties.SetOwner(ShopMode::CurrentInstance()->GetBottomWindow());
    _selected_properties.SetPosition(480.0f, 80.0f);
    _selected_properties.SetDimensions(300.0f, 30.0f, 3, 1, 3, 1);
    _selected_properties.SetOptionAlignment(VIDEO_X_RIGHT, VIDEO_Y_CENTER);
    _selected_properties.SetTextStyle(TextStyle("text22"));
    _selected_properties.SetCursorState(VIDEO_CURSOR_STATE_HIDDEN);
    _selected_properties.AddOption(ustring());
    _selected_properties.AddOption(ustring());
    _selected_properties.AddOption(ustring());

    _conditions.SetOwner(ShopMode::CurrentInstance()->GetMiddleWindow());
    _conditions.SetPosition(180.0f, 300.0f);
    _conditions.SetDimensions(600.0f, 30.0f, 2, 255, 2, 1);
    _conditions.SetOptionAlignment(VIDEO_X_LEFT, VIDEO_Y_CENTER);
    _conditions.SetTextStyle(TextStyle("text22"));
    _conditions.SetCursorState(VIDEO_CURSOR_STATE_HIDDEN);
    _conditions.SetHorizontalWrapMode(VIDEO_WRAP_MODE_NONE);
    _conditions.SetVerticalWrapMode(VIDEO_WRAP_MODE_STRAIGHT);
}


TradeInterface::~TradeInterface()
{
    for(uint32 i = 0; i < _list_displays.size(); ++i) {
        delete _list_displays[i];
    }
}

void TradeInterface::_UpdateAvailableTradeDealTypes()
{
    _trade_deal_types = 0;

    // Determine what types of objects the shop deals in based on the managed object list
    std::map<uint32, ShopObject *>* trade_objects = ShopMode::CurrentInstance()->GetAvailableTrade();
    for(std::map<uint32, ShopObject *>::iterator it = trade_objects->begin(); it != trade_objects->end(); ++it) {
        hoa_global::GLOBAL_OBJECT object_type = it->second->GetObject()->GetObjectType();
        switch(object_type) {
        case GLOBAL_OBJECT_ITEM:
            _trade_deal_types |= DEALS_ITEMS;
            break;
        case GLOBAL_OBJECT_WEAPON:
            _trade_deal_types |= DEALS_WEAPONS;
            break;
        case GLOBAL_OBJECT_HEAD_ARMOR:
            _trade_deal_types |= DEALS_HEAD_ARMOR;
            break;
        case GLOBAL_OBJECT_TORSO_ARMOR:
            _trade_deal_types |= DEALS_TORSO_ARMOR;
            break;
        case GLOBAL_OBJECT_ARM_ARMOR:
            _trade_deal_types |= DEALS_ARM_ARMOR;
            break;
        case GLOBAL_OBJECT_LEG_ARMOR:
            _trade_deal_types |= DEALS_LEG_ARMOR;
            break;
        case GLOBAL_OBJECT_SHARD:
            _trade_deal_types |= DEALS_SHARDS;
            break;
        case GLOBAL_OBJECT_KEY_ITEM:
            _trade_deal_types |= DEALS_KEY_ITEMS;
            break;
        default:
            IF_PRINT_WARNING(SHOP_DEBUG) << "unknown object type sold in shop: " << object_type << std::endl;
            break;
        }
    }
}


void TradeInterface::_RefreshItemCategories()
{
    // Clear the data
    _category_icons.clear();
    _category_names.clear();
    ShopMedia *shop_media = ShopMode::CurrentInstance()->Media();
    std::vector<ustring>* all_category_names = shop_media->GetAllCategoryNames();
    std::vector<StillImage>* all_category_icons = shop_media->GetAllCategoryIcons();

    // Determine which categories are used in this shop and populate the true containers with that data
    _UpdateAvailableTradeDealTypes();

    uint8 bit_x = 0x01; // Used to do a bit-by-bit analysis of the obj_types variable
    for(uint8 i = 0; i < GLOBAL_OBJECT_TOTAL; ++i, bit_x <<= 1) {
        // Check whether the type is available by doing a bit-wise comparison
        if(_trade_deal_types & bit_x) {
            _category_names.push_back(all_category_names->at(i));
            _category_icons.push_back(&all_category_icons->at(i));
        }
    }

    // If here is more than one category, add the text/icon for all wares
    if(_category_names.size() > 1) {
        _category_names.push_back(all_category_names->at(8));
        _category_icons.push_back(&all_category_icons->at(8));
    }

    _number_categories = _category_names.size();
}


void TradeInterface::Reinitialize()
{
    _RefreshItemCategories();

    // Set the initial category to the last category that was added (this is usually "All Wares")
    _current_category = _number_categories > 0 ? _number_categories - 1 : 0;
    // Initialize the category display with the initial category
    if(_number_categories > 0)
        _category_display.ChangeCategory(_category_names[_current_category], _category_icons[_current_category]);

    // Prepare object data containers and determine category index mappings
    // Containers of object data used to populate the display lists
    std::vector<std::vector<ShopObject *> > object_data;

    for(uint32 i = 0; i < _number_categories; ++i) {
        object_data.push_back(std::vector<ShopObject *>());
    }

    // Holds the index to the _object_data vector where the container for a specific object type is located
    std::vector<uint32> type_index(GLOBAL_OBJECT_TOTAL, 0);
    // Used to set the appropriate data in the type_index vector
    uint32 next_index = 0;
    // Used to do a bit-by-bit analysis of the deal_types variable
    uint8 bit_x = 0x01;

    // This loop determines where each type of object should be placed in the object_data container. For example,
    // if the available categories in the shop are items, weapons, shards, and all wares, the size of object_data
    // will be four. When we go to add an object of one of these types into the object_data container, we need
    // to know the correct index for each type of object. These indeces are stored in the type_index vector. The
    // size of this vector is the number of object types, so it becomes simple to map each object type to its correct
    // location in object_data.
    for(uint8 i = 0; i < GLOBAL_OBJECT_TOTAL; ++i, bit_x <<= 1) {
        // Check if the type is available by doing a bit-wise comparison
        if(_trade_deal_types & bit_x) {
            type_index[i] = next_index++;
        }
    }

    // Populate the object_data containers
    // Used to temporarily hold a pointer to a valid shop object
    ShopObject *obj = NULL;
    // Pointer to the container of all objects that are bought/sold/traded in the shop
    std::map<uint32, ShopObject *>* trade_objects = ShopMode::CurrentInstance()->GetAvailableTrade();

    for(std::map<uint32, ShopObject *>::iterator it = trade_objects->begin(); it != trade_objects->end(); ++it) {
        obj = it->second;
        switch(obj->GetObject()->GetObjectType()) {
        case GLOBAL_OBJECT_ITEM:
            object_data[type_index[0]].push_back(obj);
            break;
        case GLOBAL_OBJECT_WEAPON:
            object_data[type_index[1]].push_back(obj);
            break;
        case GLOBAL_OBJECT_HEAD_ARMOR:
            object_data[type_index[2]].push_back(obj);
            break;
        case GLOBAL_OBJECT_TORSO_ARMOR:
            object_data[type_index[3]].push_back(obj);
            break;
        case GLOBAL_OBJECT_ARM_ARMOR:
            object_data[type_index[4]].push_back(obj);
            break;
        case GLOBAL_OBJECT_LEG_ARMOR:
            object_data[type_index[5]].push_back(obj);
            break;
        case GLOBAL_OBJECT_SHARD:
            object_data[type_index[6]].push_back(obj);
            break;
        case GLOBAL_OBJECT_KEY_ITEM:
            object_data[type_index[7]].push_back(obj);
            break;
        default:
            IF_PRINT_WARNING(SHOP_DEBUG) << "added object of unknown type: " << obj->GetObject()->GetObjectType() << std::endl;
            break;
        }

        // If there is an "All Wares" category, make sure the object gets added there as well
        if(_number_categories > 1) {
            object_data.back().push_back(obj);
        }
    }

    // Create the buy displays using the object data that is now ready
    for(uint32 i = 0; i < _list_displays.size(); ++i) {
        delete _list_displays[i];
    }
    _list_displays.clear();

    for(uint32 i = 0; i < object_data.size(); ++i) {
        TradeListDisplay *new_list = new TradeListDisplay();
        new_list->PopulateList(object_data[i]);
        _list_displays.push_back(new_list);
    }

    if(_number_categories > 0)
        _selected_object = _list_displays[_current_category]->GetSelectedObject();
    _ChangeViewMode(SHOP_VIEW_MODE_LIST);
} // void TradeInterface::Initialize()



void TradeInterface::MakeActive()
{
    Reinitialize();

    _selected_object = _list_displays[_current_category]->GetSelectedObject();
    ShopMode::CurrentInstance()->ObjectViewer()->ChangeViewMode(_view_mode);
    ShopMode::CurrentInstance()->ObjectViewer()->SetSelectedObject(_selected_object);
    _category_display.ChangeViewMode(_view_mode);
    _category_display.SetSelectedObject(_selected_object);
}



void TradeInterface::TransactionNotification()
{
    for(uint32 i = 0; i < _list_displays.size(); ++i) {
        _list_displays[i]->ReconstructList();
        _list_displays[i]->ResetSelection();
    }

    _current_category = _number_categories > 0 ? _number_categories - 1 : 0;
    _view_mode = SHOP_VIEW_MODE_LIST;
}



void TradeInterface::Update()
{
    if(_view_mode == SHOP_VIEW_MODE_LIST) {
        if(InputManager->ConfirmPress()) {
            _ChangeViewMode(SHOP_VIEW_MODE_INFO);
        } else if(InputManager->CancelPress()) {
            ShopMode::CurrentInstance()->ChangeState(SHOP_STATE_ROOT);
            ShopMode::CurrentInstance()->Media()->GetSound("cancel")->Play();
        }

        // Swap cycles through the object categories
        else if(InputManager->MenuPress() && (_number_categories > 1)) {
            if(_ChangeCategory(true) == true)
                ShopMode::CurrentInstance()->ObjectViewer()->SetSelectedObject(_selected_object);
            ShopMode::CurrentInstance()->Media()->GetSound("confirm")->Play();
        }

        // Up/down changes the selected object in the current list
        else if(InputManager->UpPress()) {
            if(_ChangeSelection(false) == true) {
                ShopMode::CurrentInstance()->ObjectViewer()->SetSelectedObject(_selected_object);
                ShopMode::CurrentInstance()->Media()->GetSound("confirm")->Play();
            }
        } else if(InputManager->DownPress()) {
            if(_ChangeSelection(true) == true) {
                ShopMode::CurrentInstance()->ObjectViewer()->SetSelectedObject(_selected_object);
                ShopMode::CurrentInstance()->Media()->GetSound("confirm")->Play();
            }
        }
    } // if (_view_mode == SHOP_VIEW_MODE_LIST)

    else if(_view_mode == SHOP_VIEW_MODE_INFO) {
        if(InputManager->ConfirmPress()) {
            _ChangeViewMode(SHOP_VIEW_MODE_LIST); //Is this needed?
            ShopMode::CurrentInstance()->ChangeState(SHOP_STATE_ROOT);
            ShopMode::CurrentInstance()->CompleteTransaction();
            ShopMode::CurrentInstance()->Media()->GetSound("confirm")->Play();
            ShopMode::CurrentInstance()->ClearOrder();
            ShopMode::CurrentInstance()->ChangeState(SHOP_STATE_TRADE);

        }
        if(InputManager->CancelPress()) {
            _ChangeViewMode(SHOP_VIEW_MODE_LIST);
            while(_list_displays[_current_category]->ChangeTradeQuantity(false) == true) {} //Is this dangerous or inefficient?
            ShopMode::CurrentInstance()->Media()->GetSound("cancel")->Play();
            ShopMode::CurrentInstance()->ClearOrder();
        }

        // Left/right change the quantity of the object to trade
        else if(InputManager->LeftPress()) {
            if(_list_displays[_current_category]->ChangeTradeQuantity(false) == true) {
                ShopMode::CurrentInstance()->ObjectViewer()->UpdateCountText();
                ShopMode::CurrentInstance()->Media()->GetSound("confirm")->Play();
            } else
                ShopMode::CurrentInstance()->Media()->GetSound("bump")->Play();
        } else if(InputManager->RightPress()) {
            if(_list_displays[_current_category]->ChangeTradeQuantity(true) == true) {
                ShopMode::CurrentInstance()->ObjectViewer()->UpdateCountText();
                ShopMode::CurrentInstance()->Media()->GetSound("confirm")->Play();
            } else
                ShopMode::CurrentInstance()->Media()->GetSound("bump")->Play();
        }
    }

    _category_display.Update();
    _list_displays[_current_category]->Update();
    ShopMode::CurrentInstance()->ObjectViewer()->Update();
} // void BuyInterface::Update()



void TradeInterface::Draw()
{
    if(_view_mode == SHOP_VIEW_MODE_LIST) {
        VideoManager->SetDrawFlags(VIDEO_X_CENTER, VIDEO_Y_BOTTOM, 0);
        VideoManager->Move(200.0f, 558.0f);
        _category_header.Draw();

        VideoManager->SetDrawFlags(VIDEO_X_LEFT, 0);
        VideoManager->MoveRelative(95.0f, 0.0f);
        _name_header.Draw();

        _properties_header.Draw();

        _category_display.Draw();
        _list_displays[_current_category]->Draw();
    } else if(_view_mode == SHOP_VIEW_MODE_INFO) {
        VideoManager->SetDrawFlags(VIDEO_X_LEFT, VIDEO_Y_BOTTOM, 0);
        VideoManager->Move(295.0f, 175.0f);
        _name_header.Draw();
        _properties_header.Draw();

        VideoManager->MoveRelative(0.0f, -50.0f);
        _selected_icon.Draw();
        VideoManager->MoveRelative(30.0f, 0.0f);
        _selected_name.Draw();
        _selected_properties.Draw();
        //Update _conditions and return true
        _conditions.ClearOptions();
        for(uint32 i = 0; i < _selected_object->GetObject()->GetTradeConditions().size(); ++i) {
            GlobalObject* temp = GlobalCreateNewObject(_selected_object->GetObject()->GetTradeConditions()[i].first,1);
            _conditions.AddOption(MakeUnicodeString("<" + temp->GetIconImage().GetFilename() + "><30>")
                                     + temp->GetName());
            _conditions.GetEmbeddedImage(i)->SetDimensions(30.0f, 30.0f);
            _conditions.AddOption(MakeUnicodeString("×" + NumberToString(_selected_object->GetObject()->GetTradeConditions()[i].second)));
        }
        _conditions.Draw();

        _category_display.Draw();
    }

    ShopMode::CurrentInstance()->ObjectViewer()->Draw();
}



void TradeInterface::_ChangeViewMode(SHOP_VIEW_MODE new_mode)
{
    if(_view_mode == new_mode)
        return;

    if(new_mode == SHOP_VIEW_MODE_LIST) {
        _view_mode = new_mode;
        ShopMode::CurrentInstance()->ObjectViewer()->ChangeViewMode(_view_mode);
        _category_display.ChangeViewMode(_view_mode);

        _properties_header.SetOwner(ShopMode::CurrentInstance()->GetMiddleWindow());
        _properties_header.SetPosition(480.0f, 390.0f);
    } else if(new_mode == SHOP_VIEW_MODE_INFO) {
        _view_mode = new_mode;
        ShopMode::CurrentInstance()->ObjectViewer()->ChangeViewMode(_view_mode);
        _category_display.ChangeViewMode(_view_mode);
        _category_display.SetSelectedObject(_selected_object);

        _properties_header.SetOwner(ShopMode::CurrentInstance()->GetBottomWindow());
        _properties_header.SetPosition(480.0f, 130.0f);

        _selected_name.SetText(_selected_object->GetObject()->GetName());
        _selected_icon = _selected_object->GetObject()->GetIconImage();
        _selected_icon.SetDimensions(30.0f, 30.0f);
        _selected_properties.SetOptionText(0, MakeUnicodeString(NumberToString(_selected_object->GetTradePrice())));
        _selected_properties.SetOptionText(1, MakeUnicodeString("×" + NumberToString(_selected_object->GetStockCount())));
        _selected_properties.SetOptionText(2, MakeUnicodeString("×" + NumberToString(_selected_object->GetOwnCount())));
    } else {
        IF_PRINT_WARNING(SHOP_DEBUG) << "tried to change to an invalid/unsupported view mode: " << new_mode << std::endl;
    }
}



bool TradeInterface::_ChangeCategory(bool left_or_right)
{
    if(_number_categories <= 1)
        return false;

    if(left_or_right == false) {
        _current_category = (_current_category == 0) ? (_number_categories - 1) : (_current_category - 1);
    } else {
        _current_category = (_current_category >= (_number_categories - 1)) ? 0 : (_current_category + 1);
    }

    _category_display.ChangeCategory(_category_names[_current_category], _category_icons[_current_category]);

    ShopObject *last_obj = _selected_object;
    _selected_object = _list_displays[_current_category]->GetSelectedObject();
    if(last_obj == _selected_object)
        return false;
    else
        return true;
}



bool TradeInterface::_ChangeSelection(bool up_or_down)
{
    if(_current_category >= _list_displays.size())
        return false;

    TradeListDisplay *selected_list = _list_displays[_current_category];

    if(!selected_list)
        return false;

    if(up_or_down == false)
        selected_list->InputUp();
    else
        selected_list->InputDown();

    ShopObject *last_obj = _selected_object;
    _selected_object = _list_displays[_current_category]->GetSelectedObject();
    if(last_obj == _selected_object){
        return false;
    }
    else
        return true;
}

// *****************************************************************************
// ***** TradeListDisplay class methods
// *****************************************************************************

void TradeListDisplay::ReconstructList()
{
    _identify_list.ClearOptions();
    _property_list.ClearOptions();

    ShopObject *obj = NULL;
    for(uint32 i = 0; i < _objects.size(); ++i) {
        obj = _objects[i];
        // Add an entry with the icon image of the object (scaled down by 4x to 30x30 pixels) followed by the object name
        _identify_list.AddOption(MakeUnicodeString("<" + obj->GetObject()->GetIconImage().GetFilename() + "><30>")
                                 + obj->GetObject()->GetName());
        _identify_list.GetEmbeddedImage(i)->SetDimensions(30.0f, 30.0f);

        _property_list.AddOption(MakeUnicodeString(NumberToString(obj->GetTradePrice())));
        _property_list.AddOption(MakeUnicodeString("×" + NumberToString(obj->GetStockCount())));
        uint32 own_count = GlobalManager->HowManyObjectsInInventory(obj->GetObject()->GetID());
        _property_list.AddOption(MakeUnicodeString("×" + NumberToString(own_count)));
    }

    if(_objects.empty() == false) {
        _identify_list.SetSelection(0);
        _property_list.SetSelection(0);
    }
}


bool TradeListDisplay::ChangeTradeQuantity(bool less_or_more, uint32 amount)
{
    ShopObject *obj = GetSelectedObject();
    if(obj == NULL) {
        IF_PRINT_WARNING(SHOP_DEBUG) << "function could not perform operation because list was empty" << std::endl;
        return false;
    }

    // Holds the amount that the quantity will actually increase or decrease by. May be less than the
    // amount requested if there is an limitation such as shop stock or available funds
    uint32 change_amount = amount;

    if(less_or_more == false) {
        // Ensure that at least one count of this object is already marked for purchase
        if(obj->GetTradeCount() == 0) {
            return false;
        }

        // Determine if there's a sufficient count selected to decrement by the desire amount. If not, return as many as possible
        if(amount > obj->GetTradeCount()) {
            change_amount = obj->GetTradeCount();
        }

        obj->DecrementTradeCount(change_amount);
        ShopMode::CurrentInstance()->UpdateFinances(obj->GetTradePrice() * change_amount);
        return true;
    } else {
        // Make sure that there is at least one more object in stock and the player has enough funds to purchase it
        if((obj->GetTradeCount() >= obj->GetStockCount()))
            return false;

        if(obj->GetObject()->GetTradeConditions().size() < 1)
            return false;

        for(uint32 i = 0; i < obj->GetObject()->GetTradeConditions().size(); ++i) {
            if(!GlobalManager->IsObjectInInventory(obj->GetObject()->GetTradeConditions()[i].first))
                return false;

            if(obj->GetTradeCount() * obj->GetObject()->GetTradeConditions()[i].second >= GlobalManager->HowManyObjectsInInventory(obj->GetObject()->GetTradeConditions()[i].first))
                return false;
        }

        // Determine if there's enough of the object in stock to buy. If not, buy as many left as possible
        if((obj->GetStockCount() - obj->GetTradeCount()) < change_amount) {
            change_amount = obj->GetStockCount() - obj->GetTradeCount();
        }

        obj->IncrementTradeCount(change_amount);
        ShopMode::CurrentInstance()->UpdateFinances(-obj->GetTradePrice() * change_amount);
        return true;
    }
} // bool TradeListDisplay::ChangeTradeQuantity(bool less_or_more, uint32 amount)

} // namespace private_shop

} // namespace hoa_shop
