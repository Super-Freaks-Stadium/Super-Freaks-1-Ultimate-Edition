/// @function vector2
/// @param {Real} _x
/// @param {Real} _y
function vector2(_x = 0, _y = 0) constructor
{
	x = _x;
	y = _y;
    
    #region Operators
	
		/// @function add
		/// @param {Struct} _vec2
        /// @return {Struct} vector2
	    static add = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = x + _vec2.x;
	        var _y = y + _vec2.y;
            
	        return new vector2(_x, _y);
	    }
		
		/// @function subtract
		/// @param {Struct} _vec2
        /// @return {Struct} vector2
	    static subtract = function(_vec2)
	    {
	        gml_pragma("forceinline");
            
	        var _x = x - _vec2.x;
	        var _y = y - _vec2.y;
            
	        return new vector2(_x, _y);
	    }
		
		/// @function multiply_vec2
		/// @param {Struct} _vec2
        /// @return {Struct} vector2
	    static multiply_vec2 = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = x * _vec2.x;
	        var _y = y * _vec2.y;
            
            return new vector2(_x, _y);
	    }
		
		/// @function multiply
		/// @param {Real} _amount
        /// @return {Struct} vector2
	    static multiply = function(_amount) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = x * _amount;
	        var _y = y * _amount;
            
            return new vector2(_x, _y);
	    }
		
		/// @function divide_vec2
		/// @param {Struct} _vec2
        /// @return {Struct} vector2
	    static divide_vec2 = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = x / _vec2.x; 
            var _y = y / _vec2.y;
            
            return new vector2(_x, _y);
	    }
		
		/// @function divide
		/// @param {Real} _amount
        /// @return {Struct} vector2
	    static divide = function(_amount) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = x / _amount;
	        var _y = y / _amount;
            
            return new vector2(_x, _y);
	    }
		
		/// @function less_than
		/// @param {Struct} _vec2
        /// @return {Bool}
	    static less_than = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        if (x == _vec2.x)
	        {
	            return (y < _vec2.y);
	        }
	        return (x < _vec2.x);
	    }
		
		/// @function less_than_or_equal
		/// @param {Struct} _vec2
        /// @return {Bool}
	    static less_than_or_equal = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        if (x == _vec2.x)
	        {
	            return (y <= _vec2.y);
	        }
	        return (x <= _vec2.x);
	    }
		
		/// @function is_equal
		/// @param {Struct} _vec2
        /// @return {Bool}
	    static is_equal = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        return (x == _vec2.x and y == _vec2.y);
	    }
		
		/// @function greater_than
		/// @param {Struct} _vec2
        /// @return {Bool}
	    static greater_than = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        if (x == _vec2.x)
	        {
	            return (y > _vec2.y);
	        }
	        return (x > _vec2.x);
	    }
		
		/// @function greater_than_or_equal
		/// @param {Struct} _vec2
        /// @return {Bool}
	    static greater_than_or_equal = function(_vec2) 
	    {
	        gml_pragma("forceinline");
            
	        if (x == _vec2.x)
	        {
	            return (y >= _vec2.y);
	        }
	        return (x >= _vec2.x);
	    }
    
    #endregion
    
    #region Methods
	
		/// @function abs
        /// @return {Struct} vector2
	    static abs = function() 
	    { 
	        gml_pragma("forceinline");
            
	        var _x = abs(x);
	        var _y = abs(y);
            
	        return new vector2(_x, _y);
	    }
        
		/// @function angle
        /// @return {Real}
	    static angle = function()
	    { 
	        gml_pragma("forceinline");
            
	        return point_direction(0, 0, x, y);
	    }
        
		/// @function angle_to
		/// @param {Struct} _vec2_to
        /// @return {Real}
	    static angle_to = function(_vec2_to) 
	    { 
	        gml_pragma("forceinline");
            
	        return arctan2(self.cross(_vec2_to), self.dot(_vec2_to));
	    }
        
		/// @function angle_to_point
		/// @param {Struct} _vec2_to
        /// @return {Real}
	    static angle_to_point = function(_vec2_to) 
	    { 
	        gml_pragma("forceinline");
            
	        return (_vec2_to.subtract(self)).angle();
	    }
        
		/// @function aspect
        /// @return {Real}
	    static aspect = function()
	    {
	        gml_pragma("forceinline");
            
	        return (x / y);
	    }
        
		/// @function bounce
		/// @param {Struct} _vec2_normal
        /// @return {Struct} vector2
	    static bounce = function(_vec2_normal)
	    {
	        gml_pragma("forceinline");
            
	        return new Vector2(0, 0).subtract(self.reflect(_vec2_normal));
	    }
        
		/// @function ceil
        /// @return {Struct} vector2
	    static ceil = function() 
	    {
	        gml_pragma("forceinline");
            
	        var _x = ceil(x);
	        var _y = ceil(y);
            
	        return new vector2(_x, _y);
	    }
        
		/// @function clamp
		/// @param {Struct} _vec2_min
		/// @param {Struct} _vec2_max
        /// @return {Struct} vector2
	    static clamp = function(_vec2_min, _vec2_max) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = clamp(x, _vec2_min.x, _vec2_max.x);
	        var _y = clamp(y, _vec2_min.y, _vec2_max.y);
            
	        return new vector2(_x, _y);
	    }
        
		/// @function clampf
		/// @param {Real} _min
		/// @param {Real} _max
        /// @return {Struct} vector2
	    static clampf = function(_min, _max)
	    {
	        gml_pragma("forceinline");
            
	        var _x = clamp(x, _min, _max);
	        var _y = clamp(y, _min, _max);
            
	        return new vector2(_x, _y);
	    }
        
		/// @function cross
		/// @param {Struct} _vec2_with
        /// @return {Real}
	    static cross = function(_vec2_with)
	    {
	        gml_pragma("forceinline");
            
	        return (x * _vec2_with.y - y * _vec2_with.x);
	    }
        
		/// @function direction_to
		/// @param {Struct} _vec2_to
        /// @return {Struct} vector2
	    static direction_to = function(_vec2_to)
	    {
	        gml_pragma("forceinline");
            
	        var _x = _vec2_to.x - x;
	        var _y = _vec2_to.y - y;
            
	        return new vector2(_x, _y).normalized();
	    }
        
		/// @function distance_squared_to
		/// @param {Struct} _vec2_to
        /// @return {Real}
	    static distance_squared_to = function(_vec2_to)
	    {
	        gml_pragma("forceinline");
            
	        return ((x - _vec2_to.x) * (x - _vec2_to.x) + (y - _vec2_to.y) * (y - _vec2_to.y));
	    }
        
		/// @function distance_to
		/// @param {Struct} _vec2_to
        /// @return {Real}
	    static distance_to = function(_vec2_to)
	    {
	        gml_pragma("forceinline");
            
	        return sqrt((x - _vec2_to.x) * (x - _vec2_to.x) + (y - _vec2_to.y) * (y - _vec2_to.y));
	    }
        
		/// @function dot
		/// @param {Struct} _vec2_width
        /// @return {Real}
	    static dot = function(_vec2_with)
	    {
	        gml_pragma("forceinline");
            
	        return (x * _vec2_with.x + y * _vec2_with.y);
	    }
        
		/// @function floor
        /// @return {Struct} vector2
	    static floor = function()
	    {
	        gml_pragma("forceinline");
            
	        var _x = floor(x);
	        var _y = floor(y);
            
	        return new vector2(_x, _y);
	    }
        
		/// @function is_normalized
        /// @return {Bool}
	    static is_normalized = function()
	    {
	        gml_pragma("forceinline");
            
	        return (self.length() == 1.0);
	    }
        
		/// @function length
        /// @return {Real}
	    static length = function() 
	    {
	        gml_pragma("forceinline");
            
	        return sqrt(x * x + y * y);
	    }
        
		/// @function length_squared
        /// @return {Real}
	    static length_squared = function()
	    {
	        gml_pragma("forceinline");
            
	        return (x * x + y * y);
	    }
        
        /// @function lengthdir
        /// @param {Real} _len
        /// @param {Real} _dir
        /// @return {Struct} vector2
        static lengthdir = function(_len, _dir)         
        {
            gml_pragma("forceinline");
            
            var _x = lengthdir_x(_len, _dir);
            var _y = lengthdir_y(_len, _dir);
            
            return new vector2(_x, _y);
        }
        
		/// @function lerp
		/// @param {Struct} _vec2_to
		/// @param {Real} _weight
        /// @return {Struct} vector2
	    static lerp = function(_vec2_to, _weight)
	    {
	        gml_pragma("forceinline");
            
	        var _x = lerp(x, _vec_to.x, _weight);
	        var _y = lerp(y, _vec_to.y, _weight);
            
	        return new vector2(_x, _y);
	    }
        
		/// @function limit_length
		/// @param {Real} _length
        /// @return {Struct} vector2
	    static limit_length = function(_length)
	    {
	        gml_pragma("forceinline");
            
	        var _l = self.length();
	        var _v = new vector2(x, y);
	        if (_l > 0 and _length < _l)
	        {
	            _v = _v.divide(_l);
	            _v = _v.multiply(_length);
	        }
            
	        return _v;
	    }
        
		/// @function max
        /// @param {Struct} _vec2_max
        /// @return {Struct} vector2
	    static max = function(_vec2_max)
	    {
	        gml_pragma("forceinline");
            
	        var _x = max(x, _vec2_max.x);
	        var _y = max(y, _vec2_max.y);
            
	        return new vector2(_x, _y);
	    }
        
        /// @function maxf
        /// @param {Real} _max
        /// @return {Struct} vector2
	    static maxf = function(_max) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = max(x, _max);
	        var _y = max(y, _max);
            
	        return new vector2(_x, _y);
	    }
        
        /// @function min
        /// @param {Struct} _vec2_min
        /// @return {Struct} vector2
	    static min = function(_vec2_min) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = min(x, _vec2_min.x);
	        var _y = min(y, _vec2_min.y);
            
	        return new vector2(_x, _y);
	    }
        
        /// @function minf
        /// @param {Real} _min
        /// @return {Struct} vector2
	    static minf = function(_min) 
	    {
	        gml_pragma("forceinline");
            
	        var _x = min(x, _min);
	        var _y = min(y, _min);
            
	        return new vector2(_x, _y);
	    }
        
        /// @function move_toward
        /// @param {Struct} _vec2_to
        /// @param {Real} _delta
        /// @return {Struct} vector2
	    static move_toward = function(_vec2_to, _delta)
	    {
	        gml_pragma("forceinline");
            
	        var _v = new vector2(x, y);
	        var _vd = new vector2(_vec2_to.x - x, _vec2_to.y - y);
	        var _l = _vd.length();
	        return (_l <= _delta) || (_l == 0) ? _vec2_to : new vector2(_v.x + _vd.x / _l * _delta, _v.y + _vd.y / _l * _delta);
	    }
        
        /// @function normalized
        /// @return {Struct} vector2
	    static normalized = function()
	    {
	        gml_pragma("forceinline");
            
	        var _l = self.length();
	        var _x = x / _l;
	        var _y = x / _l;
            
	        return new vector2(_x, _y);
	    }
        
        /// @function orthogonal
        /// @return {Struct} vector2
	    static orthogonal = function()
	    {
	        gml_pragma("forceinline");
            
	        return new vector2(y, -x);
	    }
        
        /// @function project
        /// @param {Struct} _vec2_b
        /// @return {Struct} vector2
	    static project = function(_vec2_b)
	    {
	        gml_pragma("forceinline");
            
	        return _vec2_b.multiply(self.dot(_vec2_b) / _vec2_b.length_squared());
	    }
        
        /// @function reflect
        /// @param {Struct} _vec2_normal
        /// @return {Struct} vector2
        static reflect = function(_vec2_normal)
        {
            gml_pragma("forceinline");
            
            return (_vec2_normal.multiply(2).multiply(self.dot(_vec2_normal)).subtract(self));
        }
        
        /// @function rotated
        /// @param {Real} _angle
        /// @return {Struct} vector2
	    static rotated = function(_angle)
	    {
	        gml_pragma("forceinline");
            
	        var _sin = dsin(-_angle);
	        var _cos = dcos(-_angle);
            
	        return new vector2(x * _cos - y * _sin, x * _sin + y * _cos);
	    }
        
        /// @function round
        /// @return {Struct} vector2
	    static round = function()
	    {
	        gml_pragma("forceinline");
            
	        return new vector2(round(x), round(y));
	    }
        
        /// @function sign
        /// @return {Struct} vector2
	    static sign = function()
	    {
	        gml_pragma("forceinline");
            
	        return new vector2(sign(x), sign(y));
	    }
    
    #endregion
}

//.................................,,,............................................
//................,;;:............;??%*:,.........................................
//...............:%?%S+:,,,,.....:%%%%%%%?*+;,....................................
//...............,*?%?;:;:::::,;***S%%%%**SSS%*;,.................................
//..................,...,:::.,;?**SS%?%?,,*###S?*,,+**;...........................
//........................;,...+?%S;:+%S:,;#SS#S??+%?%S*..,,......................
//.......................:;:;:.,?%#?*++%%;*#####S?*?%%%S*%%%?+,...................
//.......................,;+:+::?%S?***++;;;;;;;++*,+S%SS%?%%S?,..................
//........................;;;;;*++;:,,,,,,,,::,..,+..*SSS???%%S*..................
//........................,:+++:.:;+,,,;;,,,*;,.,+;..*SS#S%%%SS*..................
//..........................,;,...,;::,;:,,:;,,:++,.:**?S#SSSS%,..................
//...........................,;;:,,,,,,::::::+*?#%%*;?S?;%+++;,...................
//.............................,:+?*+*+++*??%S##@##@##?::,........................
//..............................*%#S*%%%#S%%SS?%*?*;:,............................
//.............................,*SS*??::S?*S?S;+..................................
//..........................:+*????%SS,,?%?%%S?*..................................
//.........................:S???%SSSS#S%%SSSSSS:..................................
//.........................,?%%SSSSS##SSSSSS#%:...................................
//...........................,::;;SS#;,:;?##S,....................................
//............................:+*?%%?...,*?%?*+,..................................
//..........................,+**+;;:,....,::;+**:.................................
//..........................,:,,,............,,,,.................................