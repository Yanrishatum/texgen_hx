package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;

/**
 * ...
 * @author Yanrishatum
 */
class Normalize extends Program
{

  private var _multiplier:Float;
  private var _offset:Float;
  private var _init:Bool;
  
  public function new() 
  {
    super();
    _multiplier = 0;
    _offset = 0;
    _init = false;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    if (!_init)
    {
      var high:Float = Math.NEGATIVE_INFINITY;
      var low:Float = Math.POSITIVE_INFINITY;
      
      for (j in 0...input.array.length)
      {
        if ((j % 4) == 3) continue;
        high = (input.array[j] > high) ? input.array[j] : high;
        low = (input.array[j] < low) ? input.array[j] : low;
      }
      
      _offset = -low;
      _multiplier = 1 / (high - low);
      _init = true;
    }
    
    var v:Color = input.getPixelNearest(x, y);
    color.setRGB((v.r + _offset) * _multiplier,
                 (v.g + _offset) * _multiplier,
                 (v.b + _offset) * _multiplier);
  }
  
}