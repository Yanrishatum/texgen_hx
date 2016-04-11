package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TGUtils.CellNoiseValue;
import haxe.Timer;

/**
 * ...
 * @author Yanrishatum
 */
class VoronoiNoise extends Program
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
  
  public function seed(value:Int):VoronoiNoise
  {
    _seed = value;
    return this;
  }
  
  public function density(value:Float):VoronoiNoise
  {
    _density = value;
    return this;
  }
  
  public function weightRange(value:Float):VoronoiNoise
  {
    _weightRange = value < 0 ? 0 : value;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var p:CellNoiseValue = TGUtils.cellNoiseBase(x, y, _seed, _density, _weightRange);
    color.setGray(p.value);
  }
  
}