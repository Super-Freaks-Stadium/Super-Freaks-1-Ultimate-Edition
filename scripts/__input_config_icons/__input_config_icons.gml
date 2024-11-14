// Feather disable all

/// This script contains mappings from binding labels - a combination of keyboard key names, mouse button
/// names, and abstract gamepad names - to more friendly terms that you can show a player. Typically you'd
/// set up this function to return sprites such that you can draw gamepad icons as visual icons.
/// 
/// Default values in this script reflect the particular, and sometimes unexpected, buttons that each gamepad
/// binding maps to on the actual physical hardware. There are a handful of special cases at the top of the
/// script that are used to handle errors or misconfigurations.



//Special case: When a non-binding value is being evaluated
//              This should only happen if Input is given an invalid input argument
input_icon_not_a_binding(spr_control_icon_not_binding); //"Not a binding"

//Special case: When an empty binding is being evaluated
input_icon_empty(spr_control_icon_empty); //"Empty"

//Special case: When a touch binding (virtual button) is being evaluated
input_icon_touch("VB"); //"Virtual button"



//Optional remapping for keyboard and mouse
//This is useful for turning keyboard keys into sprite icons to match other assets, or for returning formatted strings (e.g. for use with Scribble)
//Any keyboard key label not in this struct will simply fall through and return the key name
//Put extra .add() commands here to add icons to keyboard and mouse
#region Keyboard and Mouse
    input_icons_keyboard_and_mouse()
        //Mouse Buttons
        .add("mouse button left", spr_control_icon_mouse_left)
        .add("mouse button middle", spr_control_icon_mouse_middle)
        .add("mouse button right", spr_control_icon_mouse_right)
        .add("mouse button forward", spr_control_icon_mouse_forward)
        .add("mouse button back", spr_control_icon_mouse_back)
        .add("mouse button unknown", spr_control_icon_mouse_unknown)
        .add("mouse wheel up", spr_control_icon_mouse_wheel_up)
        .add("mouse wheel down", spr_control_icon_mouse_wheel_down)
        .add("touchscreen press", spr_control_icon_mouse_touchscreen)
        
        //Arrow Keys
        .add("arrow left", spr_control_icon_keyboard_arrow_left)
        .add("arrow up", spr_control_icon_keyboard_arrow_up)
        .add("arrow right", spr_control_icon_keyboard_arrow_right)
        .add("arrow down", spr_control_icon_keyboard_arrow_down)
        
        //Commands
        .add("alt", spr_control_icon_keyboard_alt)
        .add("backspace", spr_control_icon_keyboard_backspace)
        .add("ctrl", spr_control_icon_keyboard_ctrl)
        .add("delete", spr_control_icon_keyboard_del)
        .add("enter", spr_control_icon_keyboard_enter)
        .add("escape", spr_control_icon_keyboard_esc)
        .add("tab", spr_control_icon_keyboard_tab)
        .add("shift", spr_control_icon_keyboard_shift)
        .add("space", spr_control_icon_keyboard_space)
        
        //Symbols
        .add("'", spr_control_icon_keyboard_apostrophe)
        .add("*", spr_control_icon_keyboard_asterik)
        .add("\"", spr_control_icon_keyboard_back_slash)
        .add("`", spr_control_icon_keyboard_backtick)
        .add("[", spr_control_icon_keyboard_bracket_square_left)
        .add("]", spr_control_icon_keyboard_bracket_square_right)
        .add(",", spr_control_icon_keyboard_comma)
        .add("=", spr_control_icon_keyboard_equals)
        .add("/", spr_control_icon_keyboard_forward_slash)
        .add("#", spr_control_icon_keyboard_hashtag)
        .add("-", spr_control_icon_keyboard_minus)
        .add(".", spr_control_icon_keyboard_period)
        .add("+", spr_control_icon_keyboard_plus)
        .add(";", spr_control_icon_keyboard_semicolon)
        .add("|", spr_control_icon_keyboard_vertical_bar)
        
        //Numbers
        .add("0", spr_control_icon_keyboard_0)
        .add("1", spr_control_icon_keyboard_1)
        .add("2", spr_control_icon_keyboard_2)
        .add("3", spr_control_icon_keyboard_3)
        .add("4", spr_control_icon_keyboard_4)
        .add("5", spr_control_icon_keyboard_5)
        .add("6", spr_control_icon_keyboard_6)
        .add("7", spr_control_icon_keyboard_7)
        .add("8", spr_control_icon_keyboard_8)
        .add("9", spr_control_icon_keyboard_9)
        
        //Numpad
        .add("numpad 0", spr_control_icon_keyboard_0_numpad)
        .add("numpad 1", spr_control_icon_keyboard_1_numpad)
        .add("numpad 2", spr_control_icon_keyboard_2_numpad)
        .add("numpad 3", spr_control_icon_keyboard_3_numpad)
        .add("numpad 4", spr_control_icon_keyboard_4_numpad)
        .add("numpad 5", spr_control_icon_keyboard_5_numpad)
        .add("numpad 6", spr_control_icon_keyboard_6_numpad)
        .add("numpad 7", spr_control_icon_keyboard_7_numpad)
        .add("numpad 8", spr_control_icon_keyboard_8_numpad)
        .add("numpad 9", spr_control_icon_keyboard_9_numpad)
        .add("numpad .", spr_control_icon_keyboard_period_numpad)
        .add("numpad +", spr_control_icon_keyboard_plus_numpad)
        .add("numpad -", spr_control_icon_keyboard_minus_numpad)
        .add("numpad /", spr_control_icon_keyboard_divide_numpad)
        .add("numpad *", spr_control_icon_keyboard_multiply_numpad)
        
        //Function Keys
        .add("f1", spr_control_icon_keyboard_f1)
        .add("f2", spr_control_icon_keyboard_f2)
        .add("f3", spr_control_icon_keyboard_f3)
        .add("f4", spr_control_icon_keyboard_f4)
        .add("f5", spr_control_icon_keyboard_f5)
        .add("f6", spr_control_icon_keyboard_f6)
        .add("f7", spr_control_icon_keyboard_f7)
        .add("f8", spr_control_icon_keyboard_f8)
        .add("f9", spr_control_icon_keyboard_f9)
        .add("f10", spr_control_icon_keyboard_f10)
        .add("f11", spr_control_icon_keyboard_f11)
        .add("f12", spr_control_icon_keyboard_f12)
        .add("f13", spr_control_icon_keyboard_f13)
        .add("f14", spr_control_icon_keyboard_f14)
        .add("f15", spr_control_icon_keyboard_f15)
        .add("f16", spr_control_icon_keyboard_f16)
        .add("f17", spr_control_icon_keyboard_f17)
        .add("f18", spr_control_icon_keyboard_f18)
        .add("f19", spr_control_icon_keyboard_f19)
        .add("f20", spr_control_icon_keyboard_f20)
        .add("f21", spr_control_icon_keyboard_f21)
        .add("f22", spr_control_icon_keyboard_f22)
        .add("f23", spr_control_icon_keyboard_f23)
        .add("f24", spr_control_icon_keyboard_f24)
        .add("f25", spr_control_icon_keyboard_f25)
        .add("f26", spr_control_icon_keyboard_f26)
        .add("f27", spr_control_icon_keyboard_f27)
        .add("f28", spr_control_icon_keyboard_f28)
        .add("f29", spr_control_icon_keyboard_f29)
        .add("f30", spr_control_icon_keyboard_f30)
        .add("f31", spr_control_icon_keyboard_f31)
        .add("f32", spr_control_icon_keyboard_f32)
        
        //Letters
        .add("A", spr_control_icon_keyboard_a)
        .add("B", spr_control_icon_keyboard_b)
        .add("C", spr_control_icon_keyboard_c)
        .add("D", spr_control_icon_keyboard_d)
        .add("E", spr_control_icon_keyboard_e)
        .add("F", spr_control_icon_keyboard_f)
        .add("G", spr_control_icon_keyboard_g)
        .add("H", spr_control_icon_keyboard_h)
        .add("I", spr_control_icon_keyboard_i)
        .add("J", spr_control_icon_keyboard_j)
        .add("K", spr_control_icon_keyboard_k)
        .add("L", spr_control_icon_keyboard_l)
        .add("M", spr_control_icon_keyboard_m)
        .add("N", spr_control_icon_keyboard_n)
        .add("O", spr_control_icon_keyboard_o)
        .add("P", spr_control_icon_keyboard_p)
        .add("Q", spr_control_icon_keyboard_q)
        .add("R", spr_control_icon_keyboard_r)
        .add("S", spr_control_icon_keyboard_s)
        .add("T", spr_control_icon_keyboard_t)
        .add("U", spr_control_icon_keyboard_u)
        .add("V", spr_control_icon_keyboard_v)
        .add("W", spr_control_icon_keyboard_w)
        .add("X", spr_control_icon_keyboard_x)
        .add("Y", spr_control_icon_keyboard_y)
        .add("Z", spr_control_icon_keyboard_z)
#endregion




#region Gamepads

//Xbox One and Series S|X controllers
input_icons_gamepad(INPUT_GAMEPAD_TYPE_XBOX_ONE)
.add("gamepad face south",         spr_control_icon_xboxone_button_down)
.add("gamepad face east",          spr_control_icon_xboxone_button_right)
.add("gamepad face west",          spr_control_icon_xboxone_button_left)
.add("gamepad face north",         spr_control_icon_xboxone_button_up)
.add("gamepad shoulder l",         spr_control_icon_xboxone_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_xboxone_button_shoulder_r)
.add("gamepad trigger l",          spr_control_icon_xboxone_button_trigger_l)
.add("gamepad trigger r",          spr_control_icon_xboxone_button_trigger_r)
.add("gamepad select",             spr_control_icon_xboxone_button_select)
.add("gamepad start",              spr_control_icon_xboxone_button_start)
.add("gamepad dpad left",          spr_control_icon_xboxone_dpad_left)
.add("gamepad dpad right",         spr_control_icon_xboxone_dpad_right)
.add("gamepad dpad up",            spr_control_icon_xboxone_dpad_up)
.add("gamepad dpad down",          spr_control_icon_xboxone_dpad_down)

.add("gamepad thumbstick l left",  spr_control_icon_xboxone_stick_l_left)
.add("gamepad thumbstick l right", spr_control_icon_xboxone_stick_l_right)
.add("gamepad thumbstick l up",    spr_control_icon_xboxone_stick_l_up)
.add("gamepad thumbstick l down",  spr_control_icon_xboxone_stick_l_down)
.add("gamepad thumbstick l click", spr_control_icon_xboxone_stick_l_click)

.add("gamepad thumbstick r left",  spr_control_icon_xboxone_stick_r_left)
.add("gamepad thumbstick r right", spr_control_icon_xboxone_stick_r_right)
.add("gamepad thumbstick r up",    spr_control_icon_xboxone_stick_r_up)
.add("gamepad thumbstick r down",  spr_control_icon_xboxone_stick_r_down)
.add("gamepad thumbstick r click", spr_control_icon_xboxone_stick_r_click)

//Series S|X only
.add("gamepad misc 1", spr_control_icon_xboxone_button_share)

//These are used for Elite controllers only
.add("gamepad paddle 1",           "P1")
.add("gamepad paddle 2",           "P3")  //Thanks SDL
.add("gamepad paddle 3",           "P2")  //Many thanks
.add("gamepad paddle 4",           "P4")

//PlayStation 5
input_icons_gamepad(INPUT_GAMEPAD_TYPE_PS5)
.add("gamepad face south",         spr_control_icon_ps5_button_down)
.add("gamepad face east",          spr_control_icon_ps5_button_right)
.add("gamepad face west",          spr_control_icon_ps5_button_left)
.add("gamepad face north",         spr_control_icon_ps5_button_up)
.add("gamepad shoulder l",         spr_control_icon_ps5_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_ps5_button_shoulder_r)
.add("gamepad trigger l",          spr_control_icon_ps5_button_trigger_l)
.add("gamepad trigger r",          spr_control_icon_ps5_button_trigger_r)
.add("gamepad select",             spr_control_icon_ps5_button_select)
.add("gamepad start",              spr_control_icon_ps5_button_start)
.add("gamepad dpad left",          spr_control_icon_ps_dpad_left)
.add("gamepad dpad right",         spr_control_icon_ps_dpad_right)
.add("gamepad dpad up",            spr_control_icon_ps_dpad_up)
.add("gamepad dpad down",          spr_control_icon_ps_dpad_down)

.add("gamepad thumbstick l left",  spr_control_icon_ps_stick_l_left)
.add("gamepad thumbstick l right", spr_control_icon_ps_stick_l_right)
.add("gamepad thumbstick l up",    spr_control_icon_ps_stick_l_up)
.add("gamepad thumbstick l down",  spr_control_icon_ps_stick_l_down)
.add("gamepad thumbstick l click", spr_control_icon_ps_stick_l_click)

.add("gamepad thumbstick r left",  spr_control_icon_ps_stick_r_left)
.add("gamepad thumbstick r right", spr_control_icon_ps_stick_r_right)
.add("gamepad thumbstick r up",    spr_control_icon_ps_stick_r_up)
.add("gamepad thumbstick r down",  spr_control_icon_ps_stick_r_down)
.add("gamepad thumbstick r click", spr_control_icon_ps_stick_r_click)

.add("gamepad touchpad click", spr_control_icon_ps5_button_touchpad)

//Not available on the PlayStation 5 console itself but available on other platforms
.add("gamepad misc 1",         spr_control_icon_ps5_button_mic)

//Switch handheld/dual JoyCon/Pro Controller
input_icons_gamepad(INPUT_GAMEPAD_TYPE_SWITCH)
.add("gamepad face south",         spr_control_icon_switch_button_down)
.add("gamepad face east",          spr_control_icon_switch_button_right)
.add("gamepad face west",          spr_control_icon_switch_button_left)
.add("gamepad face north",         spr_control_icon_switch_button_up)
.add("gamepad shoulder l",         spr_control_icon_switch_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_switch_button_shoulder_r)
.add("gamepad trigger l",          spr_control_icon_switch_button_trigger_l)
.add("gamepad trigger r",          spr_control_icon_switch_button_trigger_r)
.add("gamepad select",             spr_control_icon_switch_button_select)
.add("gamepad start",              spr_control_icon_switch_button_start)
.add("gamepad dpad left",          spr_control_icon_switch_dpad_left)
.add("gamepad dpad right",         spr_control_icon_switch_dpad_right)
.add("gamepad dpad up",            spr_control_icon_switch_dpad_up)
.add("gamepad dpad down",          spr_control_icon_switch_dpad_down)

.add("gamepad thumbstick l left",  spr_control_icon_xboxone_stick_l_left)
.add("gamepad thumbstick l right", spr_control_icon_xboxone_stick_l_right)
.add("gamepad thumbstick l up",    spr_control_icon_xboxone_stick_l_up)
.add("gamepad thumbstick l down",  spr_control_icon_xboxone_stick_l_down)
.add("gamepad thumbstick l click", spr_control_icon_xboxone_stick_l_click)

.add("gamepad thumbstick r left",  spr_control_icon_xboxone_stick_r_left)
.add("gamepad thumbstick r right", spr_control_icon_xboxone_stick_r_right)
.add("gamepad thumbstick r up",    spr_control_icon_xboxone_stick_r_up)
.add("gamepad thumbstick r down",  spr_control_icon_xboxone_stick_r_down)
.add("gamepad thumbstick r click", spr_control_icon_xboxone_stick_r_click)

//Not available on the Switch console itself but available on other platforms
.add("gamepad guide",              spr_control_icon_switch_button_home)
.add("gamepad misc 1",             spr_control_icon_switch_button_capture)

//Left-hand Switch JoyCon
//This setup assums horizontal hold type
input_icons_gamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT)
.add("gamepad face south",         spr_control_icon_switch_joyconl_button_down)
.add("gamepad face east",          spr_control_icon_switch_joyconl_button_right)
.add("gamepad face west",          spr_control_icon_switch_joyconl_button_left) 
.add("gamepad face north",         spr_control_icon_switch_joyconl_button_up)
.add("gamepad shoulder l",         spr_control_icon_switch_joyconl_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_switch_joyconl_button_shoulder_r)
.add("gamepad start",              spr_control_icon_switch_joyconl_button_start)

.add("gamepad thumbstick l left",  spr_control_icon_switch_joycon_stick_left)
.add("gamepad thumbstick l right", spr_control_icon_switch_joycon_stick_right)
.add("gamepad thumbstick l up",    spr_control_icon_switch_joycon_stick_up)
.add("gamepad thumbstick l down",  spr_control_icon_switch_joycon_stick_down)
.add("gamepad thumbstick l click", spr_control_icon_switch_joycon_stick_click)

//Not available on the Switch console itself but available on other platforms
.add("gamepad select",             spr_control_icon_switch_button_capture)

//Right-hand Switch JoyCon
//This setup assums horizontal hold type
input_icons_gamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT)
.add("gamepad face south",         spr_control_icon_switch_joyconr_button_down)
.add("gamepad face east",          spr_control_icon_switch_joyconr_button_right)
.add("gamepad face west",          spr_control_icon_switch_joyconr_button_left) 
.add("gamepad face north",         spr_control_icon_switch_joyconr_button_up)
.add("gamepad shoulder l",         spr_control_icon_switch_joyconr_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_switch_joyconr_button_shoulder_r)
.add("gamepad start",              spr_control_icon_switch_joyconr_button_start)

.add("gamepad thumbstick l left",  spr_control_icon_switch_joycon_stick_left)
.add("gamepad thumbstick l right", spr_control_icon_switch_joycon_stick_right)
.add("gamepad thumbstick l up",    spr_control_icon_switch_joycon_stick_up)
.add("gamepad thumbstick l down",  spr_control_icon_switch_joycon_stick_down)
.add("gamepad thumbstick l click", spr_control_icon_switch_joycon_stick_click)

//Not available on the Switch console itself but available on other platforms
.add("gamepad select",             spr_control_icon_switch_button_home)

//Xbox 360
input_icons_gamepad(INPUT_GAMEPAD_TYPE_XBOX_360)
.add("gamepad face south",         spr_control_icon_xbox360_button_down)
.add("gamepad face east",          spr_control_icon_xbox360_button_right)
.add("gamepad face west",          spr_control_icon_xbox360_button_left)
.add("gamepad face north",         spr_control_icon_xbox360_button_up)
.add("gamepad shoulder l",         spr_control_icon_xbox360_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_xbox360_button_shoulder_r)
.add("gamepad trigger l",          spr_control_icon_xbox360_button_trigger_l)
.add("gamepad trigger r",          spr_control_icon_xbox360_button_trigger_r)
.add("gamepad select",             spr_control_icon_xbox360_button_select)
.add("gamepad start",              spr_control_icon_xbox360_button_start)
.add("gamepad dpad left",          spr_control_icon_xbox360_dpad_left)
.add("gamepad dpad right",         spr_control_icon_xbox360_dpad_right)
.add("gamepad dpad up",            spr_control_icon_xbox360_dpad_up)
.add("gamepad dpad down",          spr_control_icon_xbox360_dpad_down)

.add("gamepad thumbstick l left",  spr_control_icon_xboxone_stick_l_left)
.add("gamepad thumbstick l right", spr_control_icon_xboxone_stick_l_right)
.add("gamepad thumbstick l up",    spr_control_icon_xboxone_stick_l_up)
.add("gamepad thumbstick l down",  spr_control_icon_xboxone_stick_l_down)
.add("gamepad thumbstick l click", spr_control_icon_xboxone_stick_l_click)

.add("gamepad thumbstick r left",  spr_control_icon_xboxone_stick_r_left)
.add("gamepad thumbstick r right", spr_control_icon_xboxone_stick_r_right)
.add("gamepad thumbstick r up",    spr_control_icon_xboxone_stick_r_up)
.add("gamepad thumbstick r down",  spr_control_icon_xboxone_stick_r_down)
.add("gamepad thumbstick r click", spr_control_icon_xboxone_stick_r_click)

//PlayStation 4
input_icons_gamepad(INPUT_GAMEPAD_TYPE_PS4)
.add("gamepad face south",         spr_control_icon_ps_button_down)
.add("gamepad face east",          spr_control_icon_ps_button_right)
.add("gamepad face west",          spr_control_icon_ps_button_left)
.add("gamepad face north",         spr_control_icon_ps_button_up)
.add("gamepad shoulder l",         spr_control_icon_ps4_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_ps4_button_shoulder_r)
.add("gamepad trigger l",          spr_control_icon_ps4_button_trigger_l)
.add("gamepad trigger r",          spr_control_icon_ps4_button_trigger_r)
.add("gamepad select",             spr_control_icon_ps4_button_select)
.add("gamepad start",              spr_control_icon_ps4_button_start)
.add("gamepad dpad left",          spr_control_icon_ps_dpad_left)
.add("gamepad dpad right",         spr_control_icon_ps_dpad_right)
.add("gamepad dpad up",            spr_control_icon_ps_dpad_up)
.add("gamepad dpad down",          spr_control_icon_ps_dpad_down)

.add("gamepad thumbstick l left",  spr_control_icon_ps_stick_l_left)
.add("gamepad thumbstick l right", spr_control_icon_ps_stick_l_right)
.add("gamepad thumbstick l up",    spr_control_icon_ps_stick_l_up)
.add("gamepad thumbstick l down",  spr_control_icon_ps_stick_l_down)
.add("gamepad thumbstick l click", spr_control_icon_ps_stick_l_click)

.add("gamepad thumbstick r left",  spr_control_icon_ps_stick_r_left)
.add("gamepad thumbstick r right", spr_control_icon_ps_stick_r_right)
.add("gamepad thumbstick r up",    spr_control_icon_ps_stick_r_up)
.add("gamepad thumbstick r down",  spr_control_icon_ps_stick_r_down)
.add("gamepad thumbstick r click", spr_control_icon_ps_stick_r_click)

.add("gamepad touchpad click", spr_control_icon_ps4_button_touchpad)

//PlayStation 1-3
input_icons_gamepad(INPUT_GAMEPAD_TYPE_PSX)
.add("gamepad face south",         spr_control_icon_ps_button_down)
.add("gamepad face east",          spr_control_icon_ps_button_right)
.add("gamepad face west",          spr_control_icon_ps_button_left)
.add("gamepad face north",         spr_control_icon_ps_button_up)
.add("gamepad shoulder l",         spr_control_icon_psx_button_shoulder_l)
.add("gamepad shoulder r",         spr_control_icon_psx_button_shoulder_r)
.add("gamepad trigger l",          spr_control_icon_psx_button_trigger_l)
.add("gamepad trigger r",          spr_control_icon_psx_button_trigger_r)
.add("gamepad select",             spr_control_icon_psx_button_select)
.add("gamepad start",              spr_control_icon_psx_button_start)
.add("gamepad dpad left",          spr_control_icon_ps_dpad_left)
.add("gamepad dpad right",         spr_control_icon_ps_dpad_right)
.add("gamepad dpad up",            spr_control_icon_ps_dpad_up)
.add("gamepad dpad down",          spr_control_icon_ps_dpad_down)

.add("gamepad thumbstick l left",  spr_control_icon_ps_stick_l_left)
.add("gamepad thumbstick l right", spr_control_icon_ps_stick_l_right)
.add("gamepad thumbstick l up",    spr_control_icon_ps_stick_l_up)
.add("gamepad thumbstick l down",  spr_control_icon_ps_stick_l_down)
.add("gamepad thumbstick l click", spr_control_icon_ps_stick_l_click)

.add("gamepad thumbstick r left",  spr_control_icon_ps_stick_r_left)
.add("gamepad thumbstick r right", spr_control_icon_ps_stick_r_right)
.add("gamepad thumbstick r up",    spr_control_icon_ps_stick_r_up)
.add("gamepad thumbstick r down",  spr_control_icon_ps_stick_r_down)
.add("gamepad thumbstick r click", spr_control_icon_ps_stick_r_click)

//Nintendo Gamecube
//input_icons_gamepad(INPUT_GAMEPAD_TYPE_GAMECUBE)
//.add("gamepad face south",         "A")
//.add("gamepad face east",          "X")
//.add("gamepad face west",          "B")
//.add("gamepad face north",         "Y")
//.add("gamepad shoulder r",         "Z")
//.add("gamepad trigger l",          "L")
//.add("gamepad trigger r",          "R")
//.add("gamepad start",              "start")
//.add("gamepad dpad left",          "dpad left")
//.add("gamepad dpad right",         "dpad right")
//.add("gamepad dpad up",            "dpad up")
//.add("gamepad dpad down",          "dpad down")
//
//.add("gamepad thumbstick l left",  "thumbstick l left")
//.add("gamepad thumbstick l right", "thumbstick l right")
//.add("gamepad thumbstick l up",    "thumbstick l up")
//.add("gamepad thumbstick l down",  "thumbstick l down")
//
//.add("gamepad thumbstick r left",  "thumbstick r left")
//.add("gamepad thumbstick r right", "thumbstick r right")
//.add("gamepad thumbstick r up",    "thumbstick r up")
//.add("gamepad thumbstick r down",  "thumbstick r down")
//
//The following icons are for Switch GameCube controllers and adapters only
//.add("gamepad thumbstick l click", "thumbstick l click")
//.add("gamepad thumbstick r click", "thumbstick r click")
//.add("gamepad guide",              "home")
//.add("gamepad misc 1",             "capture")

////A couple additional examples for optional gamepad types (see __input_define_gamepad_types)
//
////Nintendo 64
//input_icons(INPUT_GAMEPAD_TYPE_N64)
//.add("gamepad face south",         "A")
//.add("gamepad face east",          "B")
//.add("gamepad shoulder l",         "L")
//.add("gamepad shoulder r",         "R")
//.add("gamepad trigger l",          "Z")
//.add("gamepad start",              "start")
//.add("gamepad dpad up",            "dpad up")
//.add("gamepad dpad down",          "dpad down")
//.add("gamepad dpad left",          "dpad left")
//.add("gamepad dpad right",         "dpad right")
//.add("gamepad thumbstick l left",  "thumbstick left")
//.add("gamepad thumbstick l right", "thumbstick right")
//.add("gamepad thumbstick l up",    "thumbstick up")
//.add("gamepad thumbstick l down",  "thumbstick down")
//.add("gamepad thumbstick r left",  "C left")
//.add("gamepad thumbstick r right", "C right")
//.add("gamepad thumbstick r up",    "C up")
//.add("gamepad thumbstick r down",  "C down")
//
////Sega Saturn
//input_icons(INPUT_GAMEPAD_TYPE_SATURN)
//.add("gamepad face south", spr_control_icon_saturn_button_down)
//.add("gamepad face east",  spr_control_icon_saturn_button_right)
//.add("gamepad face west",  spr_control_icon_saturn_button_left)
//.add("gamepad face north", spr_control_icon_saturn_button_up)
//.add("gamepad shoulder l", spr_control_icon_saturn_button_shoulder_l)
//.add("gamepad shoulder r", spr_control_icon_saturn_button_shoulder_r)
//.add("gamepad trigger l",  spr_control_icon_saturn_button_trigger_l)
//.add("gamepad trigger r",  spr_control_icon_saturn_button_trigger_r)
//.add("gamepad select",     spr_control_icon_saturn_button_select)
//.add("gamepad start",      spr_control_icon_saturn_button_start)
//.add("gamepad dpad up",    spr_control_icon_saturn_dpad_up)
//.add("gamepad dpad down",  spr_control_icon_saturn_dpad_down)
//.add("gamepad dpad left",  spr_control_icon_saturn_dpad_left)
//.add("gamepad dpad right", spr_control_icon_saturn_dpad_right)

#endregion
