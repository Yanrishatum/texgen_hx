package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.ColorInterpolator.InterpolatorPoint;
import haxe.Timer;

/**
 * ...
 * @author Yanrishatum
 */
class FractalNoise extends Program
{

  private var _interpolator:ColorInterpolator;
  private var _seed:Int;
  private var _baseFrequency:Float;
  private var _amplitude:Float;
  private var _persistence:Float;
  private var _octaves:Int;
  private var _step:Float;
  
  public function new():Void
  {
    super();
    _interpolator = new ColorInterpolator(ColorInterpolatorMethod.Step);
    _seed = Std.int(Timer.stamp());
    _baseFrequency = 0.03125;
    _amplitude = 0.4;
    _persistence = 0.72;
    _octaves = 4;
    _step = 4;
  }
  
  public function seed(value:Int):FractalNoise
  {
    _seed = value;
    return this;
  }
  
  public function baseFrequency(value:Float):FractalNoise
  {
    _baseFrequency = 1 / value;
    return this;
  }
  
  public function amplitude(value:Float):FractalNoise
  {
    _amplitude = value;
    return this;
  }
  
  public function persistence(value:Float):FractalNoise
  {
    _persistence = value;
    return this;
  }
  
  public function octaves(value:Int):FractalNoise
  {
    _octaves = value < 1 ? 1 : value;
    return this;
  }
  
  public function step(value:Float):FractalNoise
  {
    _step = value < 1 ? 1 : value;
    return this;
  }
  
  public function interpolation(value:ColorInterpolatorMethod):FractalNoise
  {
    _interpolator.setInterpolation(value);
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var value:Float = 0;
    var amp:Float = this._amplitude;
    var freq:Float = this._baseFrequency;
    var x1:Int, y1:Int, dx:Float, dy:Float;
    var v1:Float, v2:Float, v3:Float, v4:Float;
    var i1:Color, i2:Color;
    
    var points:Array<InterpolatorPoint> = [
      { pos: 0, color: new Color() },
      { pos: 1, color: new Color() }
    ];
    _interpolator.set(points);
    
    var j:Int = 0;
    while (j < this._octaves)
    {
      j++;
      
      x1 = Math.floor(x * freq);
      y1 = Math.floor(y * freq);
      
      if (_interpolator.interpolation == ColorInterpolatorMethod.Step)
      {
        value += TGUtils.hashRNG(_seed * j, x1, y1) * amp;
      }
      else
      {
        dx = (x * freq) - x1;
        dy = (y * freq) - y1;
        
        v1 = TGUtils.hashRNG(_seed * j, x1    , y1    );
        v2 = TGUtils.hashRNG(_seed * j, x1 + 1, y1    );
        v3 = TGUtils.hashRNG(_seed * j, x1    , y1 + 1);
        v4 = TGUtils.hashRNG(_seed * j, x1 + 1, y1 + 1);
        
        points[0].color.setGray(v1);
        points[1].color.setGray(v2);
        
        i1 = _interpolator.getColorAt(dx);
        
        points[0].color.setGray(v3);
        points[1].color.setGray(v4);
        
        i2 = _interpolator.getColorAt(dx);
        
        points[0].color.setGray(i1.r);
        points[1].color.setGray(i2.r);
        
        value += _interpolator.getColorAt(dy).r * amp;
      }
      
      freq *= _step;
      amp *= _persistence;
    }
    
    color.setGray(value);
  }
  
}