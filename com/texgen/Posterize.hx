package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;

/**
 * ...
 * @author Yanrishatum
 */
class Posterize extends Program
{

  private var _step:Int;
  
  public function new() 
  {
    super();
    _step = 2;
  }
  
  public function step(value:Int):Posterize
  {
    _step = value < 2 ? 2 : value;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var v:Color = input.getPixelNearest(x, y);
    color.setRGB(Math.ffloor(Math.ffloor(v.r * 255 / (255 / _step) ) * 255 / (_step - 1) ) / 255,
                 Math.ffloor(Math.ffloor(v.g * 255 / (255 / _step) ) * 255 / (_step - 1) ) / 255,
                 Math.ffloor(Math.ffloor(v.b * 255 / (255 / _step) ) * 255 / (_step - 1) ) / 255);
  }
  
}