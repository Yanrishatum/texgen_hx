package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
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
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var s:Float = _size.x * Math.ffloor(x / _size.x);
    var t:Float = _size.y * Math.ffloor(y / _size.y);
    color.set(input.getPixelNearest(s, t));
  }
  
}