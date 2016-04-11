package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TG.XYPair;

/**
 * ...
 * @author Yanrishatum
 */
class RadialGradient extends Program
{

  private var _gradient:ColorInterpolator;
  private var _radius:Float;
  private var _center:XYPair;
  
  public function new() 
  {
    super();
    _gradient = new ColorInterpolator(ColorInterpolatorMethod.Linear);
    _radius = 255;
    _center = { x: 128, y: 128 };
  }
  
  public function repeat(value:RepeatMethod):RadialGradient
  {
    _gradient.setRepeat(value);
    return this;
  }
  
  public function radius(value:Float):RadialGradient
  {
    _radius = value;
    return this;
  }
  
  public function interpolation(value:ColorInterpolatorMethod):RadialGradient
  {
    _gradient.setInterpolation(value);
    return this;
  }
  
  public function center(x:Int, y:Int):RadialGradient
  {
    _center.x = x;
    _center.y = y;
    return this;
  }
  
  public function point(position:Float, color:Color):RadialGradient
  {
    _gradient.addPoint(position, color);
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var dist:Float = TGUtils.distance(x, y, _center.x, _center.y);
    color.set(_gradient.getColorAt(dist / _radius));
  }
  
}