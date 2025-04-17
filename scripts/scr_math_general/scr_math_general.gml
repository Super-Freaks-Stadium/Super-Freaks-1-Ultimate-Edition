/// @function lerp_360
/// @param {Real} _angle_1
/// @param {Real} _angle_2
/// @param {Real} _amount = 0
function lerp_360(_angle_1, _angle_2, _amount = 0)
{
	return _angle_1 - (angle_difference(_angle_1, _angle_2) * _amount);
	
	gml_pragma("forceinline");
}

/// @function lerp_animcurve
/// @param {Any} _animcurve
/// @param {Real} _channel = 0
/// @param {Real} _value_a
/// @param {Real} _value_b
/// @param {Real} _amount
function lerp_animcurve(_animcurve, _channel = 0, _value_a, _value_b, _amount)
{
    var _curve_channel = animcurve_get_channel(_animcurve, _channel);
    var _amt = animcurve_channel_evaluate(_curve_channel, _amount);
    return lerp(_value_a, _value_b, _amt);
}

/// @function approach
/// @param {Real} _start
/// @param {Real} _target
/// @param {Real} _shift
function approach(_start, _target, _shift) 
{
    if (_start < _target)
        return min(_start + _shift, _target);
    else
        return max(_start - _shift, _target);
}

/// @function bezier_interpolate
/// @param {Real} _start
/// @param {Real} _control_1
/// @param {Real} _control_2
/// @param {Real} _end
/// @param {Real} _t
/// @return {Real}
function bezier_interpolate(_start, _control_1, _control_2, _end, _t)
{
    var _omt = (1.0 - _t);
    var _omt2 = _omt * _omt;
    var _omt3 = _omt2 * _omt;
    var _t2 = _t * _t;
    var _t3 = _t2;
    
    return _start * _omt3 + _control_1 * _omt2 * _t * 3.0 + _control_2 * _omt * _t2 * 3.0 + _end * _t3;
}

/// @function move_toward
/// @param {Real} _from
/// @param {Real} _to
/// @param {Real} _delta
/// @return {Real}
/// @description Thanks Jordan
// You're welcome lmao
function move_toward(_from, _to, _delta) 
{
    return abs(_to - _from) <= _delta ? _to : _from + sign(_to - _from) * _delta;
}

/// @function inverse_lerp
/// @param {Real} _from
/// @param {Real} _to
/// @param {Real} _value
/// @return {Real}
function inverse_lerp(_from, _to, _value)
{
    return (_value - _from) / (_to - _from);
}

/// @function remap
/// @param {Real} _value
/// @param {Real} _istart
/// @param {Real} _istop
/// @param {Real} _ostart
/// @param {Real} _ostop
/// @return {Real}
function remap(_value, _istart, _istop, _ostart, _ostop)
{
    return lerp(_ostart, _ostop, inverse_lerp(_istart, _istop, _value));
}

enum SIDE 
{
    LEFT = 0,
    TOP,
    RIGHT,
    BOTTOM 
}
