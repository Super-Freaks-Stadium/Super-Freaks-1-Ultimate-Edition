function ui_node () constructor
{
    children = [];
    
    anchor = {
        left: 0.0,
        right: 0.0,
        top: 0.0,
        bottom: 0.0
    }
    
    margin = {
        left: 0.0,
        right: 0.0,
        top: 0.0,
        bottom: 0.0
    }
    
    minimum_size = new vector2(0, 0);
    
    focus_mode = UI_FOCUS_MODE_NONE;
    focus_neighbor = {
        left: undefined,
        right: undefined,
        top: undefined,
        bottom: undefined,
        next: undefined,
        previous: undefined
    }
    
    grow_horizontal = UI_GROW_DIRECTION_END;
    grow_vertical = UI_GROW_DIRECTION_END;
    
    layout_direction = UI_LAYOUT_DIRECTION_INHERITED;
    layout_mode = UI_LAYOUT_MODE_UNCONTROLLED;
    
    default_cursor_shape = UI_CURSOR_ARROW;
    mouse_filter = UI_MOUSE_FILTER_STOP;
    mouse_force_pass_scroll_events = true;
    
    pivot_offset = new vector2(0, 0);
    position = new vector2(0, 0);
    rotation = 0.0;
    scale = new vector2(1, 1);
    
    size = new vector2(0, 0);
    size_flags_horizontal = UI_SIZE_FILL;
    size_flags_vertical = UI_SIZE_FILL;
    size_flags_stretch_ratio = 1.0;
    
    tooltip_text = "";
    
    step = function(){};
    notification = function(_notification){};
    
    #region Setup
        
        static anchors_set = function(_left, _right, _top, _bottom)
        {
            anchor = {
                left: (_left ? _left : anchor.left), 
                right: (_right ? _right : anchor.right), 
                top: (_top ? _top : anchor.top), 
                bottom: (_bottom ? _bottom : anchor.bottom)
            }
        }
        
        static anchors_preset_set = function(_anchors_preset)
        {
            switch (_anchors_preset)
            {
                case UI_PRESET_TOP_LEFT:
                    
                    anchor = {left: 0.0, right: 0.0, top: 0.0, bottom: 0.0}
                    
                    break;
                case UI_PRESET_TOP_RIGHT:
                    
                    anchor = {left: 1.0, right: 1.0, top: 0.0, bottom: 0.0}
                    
                    break;
                case UI_PRESET_BOTTOM_LEFT:
                    
                    anchor = {left: 0.0, right: 0.0, top: 1.0, bottom: 1.0}
                    
                    break;
                case UI_PRESET_BOTTOM_RIGHT:
                    
                    anchor = {left: 1.0, right: 1.0, top: 1.0, bottom: 1.0}
                    
                    break;
                case UI_PRESET_CENTER_LEFT:
                    
                    anchor = {left: 0.0, right: 0.0, top: 0.5, bottom: 0.5}
                    
                    break;
                case UI_PRESET_CENTER_TOP:
                    
                    anchor = {left: 0.5, right: 0.5, top: 0.0, bottom: 0.0}
                    
                    break;
                case UI_PRESET_CENTER_RIGHT:
                    
                    anchor = {left: 1.0, right: 1.0, top: 0.5, bottom: 0.5}
                    
                    break;
                case UI_PRESET_CENTER_BOTTOM:
                    
                    anchor = {left: 0.5, right: 0.5, top: 1.0, bottom: 1.0}
                    
                    break;
                case UI_PRESET_CENTER:
                    
                    anchor = {left: 0.5, right: 0.5, top: 0.5, bottom: 0.5}
                    
                    break;
                case UI_PRESET_LEFT_WIDE:
                    
                    anchor = {left: 0.0, right: 0.0, top: 0.0, bottom: 1.0}
                    
                    break;
                case UI_PRESET_TOP_WIDE:
                    
                    anchor = {left: 0.0, right: 1.0, top: 0.0, bottom: 0.0}
                    
                    break;
                case UI_PRESET_RIGHT_WIDE:
                    
                    anchor = {left: 1.0, right: 1.0, top: 0.0, bottom: 1.0}
                    
                    break;
                case UI_PRESET_BOTTOM_WIDE:
                    
                    anchor = {left: 0.0, right: 1.0, top: 1.0, bottom: 1.0}
                    
                    break;
                case UI_PRESET_VCENTER_WIDE:
                    
                    anchor = {left: 0.5, right: 0.5, top: 0.0, bottom: 1.0}
                    
                    break;
                case UI_PRESET_HCENTER_WIDE:
                    
                    anchor = {left: 0.0, right: 1.0, top: 0.5, bottom: 0.5}
                    
                    break;
                case UI_PRESET_FULL_RECT:
                    
                    anchor = {left: 0.0, right: 1.0, top: 0.0, bottom: 1.0}
                    
                    break;
            }
        }
        
    #endregion
    
    #region Util
        
        
        
    #endregion
    
    #region Internal
        
        static __internal_resize = function()
        {
            switch (layout_mode)
            {
                case UI_LAYOUT_MODE_POSITION:
                    
                    break;
                case UI_LAYOUT_MODE_ANCHORS:
                    
                    break;
                case UI_LAYOUT_MODE_CONTAINER:
                    
                    break;
                case UI_LAYOUT_MODE_UNCONTROLLED:
                    
                    break;
            }
        }
        
    #endregion
    
    #region Debug
        
        static debug_draw_anchors = function()
        {
            
        }
        
    #endregion 
}



#region Enums

enum UI_ANCHOR {
    UI_ANCHOR_BEGIN = 0,
    UI_ANCHOR_END = 1
}

enum UI_GROW_DIRECTION {
    UI_GROW_DIRECTION_BEGIN,
    UI_GROW_DIRECTION_END,
    UI_GROW_DIRECTION_BOTH
}

enum UI_FOCUS_MODE {
    UI_FOCUS_NONE,
    UI_FOCUS_CLICK,
    UI_FOCUS_ALL
}

enum UI_SIZE_FLAGS {
    UI_SIZE_SHRINK_BEGIN = 0,
    UI_SIZE_FILL = 1,
    UI_SIZE_EXPAND = 2,
    UI_SIZE_SHRINK_CENTER = 4,
    UI_SIZE_SHRINK_END = 8,
    UI_SIZE_EXPAND_FILL = 3 //UI_SIZE_EXPAND | UI_SIZE_FILL
}

enum UI_MOUSE_FILTER {
    UI_MOUSE_FILTER_STOP,
    UI_MOUSE_FILTER_PASS,
    UI_MOUSE_FILTER_IGNORE
}

enum UI_CURSOR_SHAPE {
    UI_CURSOR_ARROW,
    UI_CURSOR_IBEAM,
    UI_CURSOR_POINTING_HAND,
    UI_CURSOR_CROSS,
    UI_CURSOR_WAIT,
    UI_CURSOR_BUSY,
    UI_CURSOR_DRAG,
    UI_CURSOR_CAN_DROP,
    UI_CURSOR_FORBIDDEN,
    UI_CURSOR_VSIZE,
    UI_CURSOR_HSIZE,
    UI_CURSOR_BDIAGSIZE,
    UI_CURSOR_FDIAGSIZE,
    UI_CURSOR_MOVE,
    UI_CURSOR_VSPLIT,
    UI_CURSOR_HSPLIT,
    UI_CURSOR_HELP,
    UI_CURSOR_MAX
}

enum UI_LAYOUT_PRESET {
    UI_PRESET_TOP_LEFT,
    UI_PRESET_TOP_RIGHT,
    UI_PRESET_BOTTOM_LEFT,
    UI_PRESET_BOTTOM_RIGHT,
    UI_PRESET_CENTER_LEFT,
    UI_PRESET_CENTER_TOP,
    UI_PRESET_CENTER_RIGHT,
    UI_PRESET_CENTER_BOTTOM,
    UI_PRESET_CENTER,
    UI_PRESET_LEFT_WIDE,
    UI_PRESET_TOP_WIDE,
    UI_PRESET_RIGHT_WIDE,
    UI_PRESET_BOTTOM_WIDE,
    UI_PRESET_VCENTER_WIDE,
    UI_PRESET_HCENTER_WIDE,
    UI_PRESET_FULL_RECT
}

enum UI_LAYOUT_PRESET_MODE {
    UI_PRESET_MODE_MINSIZE,
    UI_PRESET_MODE_KEEP_WIDTH,
    UI_PRESET_MODE_KEEP_HEIGHT,
    UI_PRESET_MODE_KEEP_SIZE
}

enum UI_LAYOUT_MODE {
    UI_LAYOUT_MODE_POSITION,
    UI_LAYOUT_MODE_ANCHORS,
    UI_LAYOUT_MODE_CONTAINER,
    UI_LAYOUT_MODE_UNCONTROLLED
}

//enum UI_LAYOUT_DIRECTION {
//    UI_LAYOUT_DIRECTION_INHERITED,
//    UI_LAYOUT_DIRECTION_LOCALE,
//    UI_LAYOUT_DIRECTION_LTR,
//    UI_LAYOUT_DIRECTION_RTL
//}

//enum UI_TEXT_DIRECTION {
//    UI_TEXT_DIRECTION_AUTO,
//    UI_TEXT_DIRECTION_LTR,
//    UI_TEXT_DIRECTION_RTL,
//    UI_TEXT_DIRECTION_INHERITED
//}

enum UI_NOTIFICATION {
    UI_NOTIFICATION_RESIZED,
    UI_NOTIFICATION_MOUSE_ENTER,
    UI_NOTIFICATION_MOUSE_EXIT,
    UI_NOTIFICATION_FOCUS_ENTER,
    UI_NOTIFICATION_FOCUS_EXIT,
    UI_NOTIFICATION_SCROLL_BEGIN,
    UI_NOTIFICATION_SCROLL_END,
    UI_NOTIFICATION_LAYOUT_DIRECTION_CHANGED,
    UI_NOTIFICATION_MOUSE_ENTER_SELF,
    UI_NOTIFICATION_MOUSE_EXIT_SELF
}

#endregion