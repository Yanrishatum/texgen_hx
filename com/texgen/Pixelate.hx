package com.texgen;
import com.texgen.Texture.Float32Array;
import com.texgen.TG.XYPair;

/**
 * DOES NOT WORK
 */
class Pixelate extends Program
{

  private var _size:XYPair;
  
  public function new() 
  {
    super();
    _size = { x: 1, y: 1 };
  }
  
  public function size(x:Float, y:Float):Pixelate
  {
    _size.x = x;
    _size.y = y;
    return this;
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    var s:Float = _size.x * Math.ffloor(x / _size.x);
    var t:Float = _size.y * Math.ffloor(y / _size.y);
    
    return TGUtils.getPixelNearest(input, s, t, 0, width);
  }
}