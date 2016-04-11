package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TGUtils.CellNoiseValue;
import haxe.Timer;

/**
 * ...
 * @author Yanrishatum
 */
class VoronoiFractal extends Program
{

  private var _seed:Int;
  private var _weightRange:Float;
  private var _baseDensity:Float;
  private var _amplitude:Float;
  private var _persistence:Float;
  private var _octaves:Int;
  private var _step:Int;

  public function new() 
  {
    super();
    _seed = Std.int(Timer.stamp());
    _weightRange = 0;
    _baseDensity = 64;
    _amplitude = 0.6;
    _persistence = 0.6;
    _octaves = 4;
    _step = 2;
  }
  
  public function seed(value:Int):VoronoiFractal
  {
    _seed = value;
    return this;
  }
  
  public function baseDensity(value:Float):VoronoiFractal
  {
    _baseDensity = value;
    return this;
  }
  
  public function weightRange(value:Float):VoronoiFractal
  {
    _weightRange = value < 0 ? 0 : value;
    return this;
  }
  
  public function amplitude(value:Float):VoronoiFractal
  {
    _amplitude = value;
    return this;
  }
  
  public function persistence(value:Float):VoronoiFractal
  {
    _persistence = value;
    return this;
  }
  
  public function octaves(value:Int):VoronoiFractal
  {
    _octaves = value < 1 ? 1 : value;
    return this;
  }
  
  public function step(value:Int):VoronoiFractal
  {
    _step = value < 1 ? 1 : value;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var p:CellNoiseValue;
    var value:Float = 0;
    var amp:Float = _amplitude;
    var dens:Float = _baseDensity;
    
    var j:Int = 0;
    while (j < _octaves)
    {
      j++;
      
      p = TGUtils.cellNoiseBase(x, y, _seed * j, dens, _weightRange);
      
      value += p.value * amp;
      dens /= _step;
      amp *= _persistence;
    }
    
    color.setGray(value);
  }
  
}