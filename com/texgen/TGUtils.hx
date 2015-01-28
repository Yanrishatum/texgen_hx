package com.texgen;
import com.texgen.Texture.Float32Array;

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
  
  public static function clamp(value:Float, min:Float, max:Float):Float
  {
    return Math.min(Math.max(value, min), max);
  }
  
  public static function getPixelSafe(pixels:Float32Array, index:Int):Float
  {
    return index < 0 || index >= pixels.length ? 0 : pixels[index];
  }
  
  public static function getPixelNearest(pixels:Float32Array, x:Float, y:Float, offset:Int, width:Int):Float
  {
    return getPixelSafe(pixels, offset + Math.round(y) * width * 4 + Math.round(x) * 4);
  }
  
  public static function deg2rad(deg:Float):Float
  {
    return deg * Math.PI / 180;
  }
  
  public static function getPixelBilinear(pixels:Float32Array, x:Float, y:Float, offset:Int, width:Int):Float
  {
    var percentX:Float = x - Math.ffloor(x);
    var percentX1:Float = 1.0 - percentX;
    var percentY:Float = y - Math.ffloor(y);
    var fx4:Int = Math.floor(x) * 4;
    var cx4:Int = fx4 + 4;
    var fy4:Int = Math.floor(y) * 4;
    var cy4:Int = Math.floor(y) * 4;
    var cy4wo:Int = (fy4 + 4) * width + offset;
    var fy4wo:Int= fy4 * width + offset;
    
    var top:Float    = getPixelSafe(pixels, cy4wo + fx4) * percentX1 + getPixelSafe(pixels, cy4wo + cx4) * percentX;
    var bottom:Float = getPixelSafe(pixels, fy4wo + fx4) * percentX1 + getPixelSafe(pixels, fy4wo + cx4) * percentX;
    
    return top * percentY + bottom * (1 - percentY);
  }
}