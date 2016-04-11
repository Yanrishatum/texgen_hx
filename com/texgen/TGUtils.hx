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
  
  public static function mixColors(c1:Color, c2:Color, delta:Float):Color
  {
    var mdelta:Float = 1 - delta;
    return new Color(c1.r * mdelta + c2.r * delta,
                     c1.g * mdelta + c2.g * delta,
                     c1.b * mdelta + c2.b * delta,
                     c1.a * mdelta + c2.a * delta);
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
  
  public static function wrap(value:Float, min:Float, max:Float):Float
  {
    var v:Float = value - min;
    var r:Float = max - min;
    return ( (r + v % r) % r ) + min;
  }
  
  public static function mirroredWrap(value:Float, min:Float, max:Float):Float
  {
    var v:Float = value - min;
    var r:Float = (max - min) * 2;
    
    v = (r + v % r) % r;
    
    if (v > max - min) return (r - v) + min;
    else return v + min;
  }
  
  public static function deg2rad(deg:Float):Float
  {
    return deg * Math.PI / 180;
  }
  
  public static function hashRNG(seed:Int, x:Int, y:Int):Float
  {
    seed = (Math.abs(seed % 2147483648) == 0) ? 1 : seed;
    
    var a:Int = ( ( seed * (x + 1) * 777 ) ^ ( seed * ( y + 1) * 123 ) ) % 2147483647;
    a = (a ^ 61) ^ (a >> 16);
    a = a + (a << 3);
    a = a ^ (a >> 4);
    a = a * 0x27d4eb2d;
    a = a ^ (a >> 15);
    return a / 2147483647;
    //a = a / 2147483647;
    //return a;
  }
  
  public static function cellNoiseBase(x:Int, y:Int, seed:Int, density:Float, weightRange:Float):CellNoiseValue
  {
    var qx:Int, qy:Int, rx:Float, ry:Float, w:Float, px:Float, py:Float, dx:Float, dy:Float;
    var dist:Float, value:Float = 0;
    var shortest:Float = Math.POSITIVE_INFINITY;
    density = Math.abs(density);
    
    for (sx in -2...3)
    {
      for (sy in -2...3)
      {
        qx = Math.ceil(x / density) + sx;
        qy = Math.ceil(y / density) + sy;
        
        rx = TGUtils.hashRNG(seed, qx, qy);
        ry = TGUtils.hashRNG(seed * 2, qx, qy);
        w = (weightRange > 0) ? 1 + TGUtils.hashRNG(seed * 3, qx, qy) * weightRange : 1;
        
        px = (rx + qx) * density;
        py = (ry + qy) * density;
        
        dx = Math.abs(px - x);
        dy = Math.abs(py - y);
        
        dist = (dx * dx + dy * dy) * w;
        
        if (dist < shortest)
        {
          shortest = dist;
          value = rx;
        }
      }
    }
    
    return { dist: Math.sqrt(shortest), value: value };
  }
  
}

typedef CellNoiseValue =
{
  var dist:Float;
  var value:Float;
}