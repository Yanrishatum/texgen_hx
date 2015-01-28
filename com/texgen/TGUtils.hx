package com.texgen;

class TGUtils
{
  
  public static function smoothStep(edge0:Float, edge1:Float, x:Float):Float
  {
    // Scale, bias and saturate x to 0..1 range
    x = clamp( (x - edge0) / (edge1 - edge0), 0, 1);

		// Evaluate polynomial
    return x * x * (3 - 2 * x);
  }
  
  public static function distance(x0:Float, y0:Float, x1:Float, y1:Float):Float
  {
    var dx:Float = x1 - x0;
    var dy:Float = y1 - y0;
    return Math.sqrt(dx * dx + dy * dy);
  }
  
  public static inline function clamp(value:Float, min:Float, max:Float):Float
  {
    return Math.min(Math.max(value, min), max);
  }
  
  public static inline function wrap(value:Float, size:Float):Float
  {
    if (value >= size) value -= size;
    else if (value < 0) value += size;
    return value;
  }
  
  public static function deg2rad(deg:Float):Float
  {
    return deg * Math.PI / 180;
  }
  
}