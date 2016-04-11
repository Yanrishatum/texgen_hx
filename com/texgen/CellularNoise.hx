package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TGUtils.CellNoiseValue;
import haxe.Timer;

/**
 * ...
 * @author Yanrishatum
 */
class CellularNoise extends Program
{

  private var _seed:Int;
  private var _density:Float;
  private var _weightRange:Float;
  
  public function new() 
  {
    super();
    _seed = Std.int(Timer.stamp());
    _density = 32;
    _weightRange = 0;
  }
  
  public function seed(value:Int):CellularNoise
  {
    _seed = value;
    return this;
  }
  
  public function density(value:Float):CellularNoise
  {
    _density = value;
    return this;
  }
  
  public function weightRange(value:Float):CellularNoise
  {
    _weightRange = value < 0 ? 0 : value;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var p:CellNoiseValue = TGUtils.cellNoiseBase(x, y, _seed, _density, _weightRange);
    
    var value:Float = 1 - (p.dist/ _density);
    if (_density < 0) value -= 1;
    
    color.setGray(value);
  }
  
}