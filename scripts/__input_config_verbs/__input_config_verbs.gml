// Feather disable all

//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

function __input_config_verbs()
{
    return {
        keyboard_and_mouse:
        {
            up:    [input_binding_key(vk_up),    input_binding_key("W")],
            down:  [input_binding_key(vk_down),  input_binding_key("S")],
            left:  [input_binding_key(vk_left),  input_binding_key("A")],
            right: [input_binding_key(vk_right), input_binding_key("D")],
            
            jump: [input_binding_key("Z"), input_binding_key(vk_space), input_binding_mouse_button(mb_left)],
            
            bubble: [input_binding_key("X"), input_binding_mouse_button(mb_right)],
            rubberband: [input_binding_key("C"), input_binding_key("Q")],
            rubberband_color: [input_binding_key("V"), input_binding_key("E")],
            drop_out: input_binding_key(vk_shift),
            
            start: [input_binding_key(vk_enter), input_binding_key(vk_escape)],
            confirm:  [input_binding_key("Z"), input_binding_mouse_button(mb_left)],
            deny:  [input_binding_key("X"), input_binding_mouse_button(mb_right)],
        },
        
        gamepad:
        {
            up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],
            down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
            left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
            right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
            
            jump:  input_binding_gamepad_button(gp_face1),
            
            bubble:  input_binding_gamepad_button(gp_face2),
            rubberband: input_binding_gamepad_button(gp_shoulderlb), 
            rubberband_color: input_binding_gamepad_button(gp_shoulderrb), 
            drop_out: input_binding_gamepad_button(gp_select),
            
            start: input_binding_gamepad_button(gp_start),
            confirm:  input_binding_gamepad_button(gp_face1),
            deny:  input_binding_gamepad_button(gp_face2),
        }//,
        
        //touch:
        //{
        //    up:    input_binding_virtual_button(),
        //    down:  input_binding_virtual_button(),
        //    left:  input_binding_virtual_button(),
        //    right: input_binding_virtual_button(),
        //    
        //    jump:  input_binding_virtual_button(),
        //    
        //    bubble:  input_binding_virtual_button(),
        //    rubberband:  input_binding_virtual_button(),
        //    rubberband_color: input_binding_virtual_button(),
        //    drop_out: input_binding_virtual_button(),
        //    
        //    start: input_binding_virtual_button(),
        //    confirm: input_binding_virtual_button(),
        //    deny: input_binding_virtual_button(),
        //}
    };
}