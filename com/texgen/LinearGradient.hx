package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;

/**
 * ...
 * @author Yanrishatum
 */
class LinearGradient extends Program
{
  
  private var _gradient:ColorInterpolator;

  public function new() 
  {
    super();
    _gradient = new ColorInterpolator(ColorInterpolatorMethod.Linear);
  }
  
  public function repeat(value:RepeatMethod):LinearGradient
  {
    _gradient.setRepeat(value);
    return this;
  }
  
  public function interpolation(value:ColorInterpolatorMethod):LinearGradient
  {
    _gradient.setInterpolation(value);
    return this;
  }
  
  public function point(position:Float, color:Color):LinearGradient
  {
    _gradient.addPoint(position, color);
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    color.set(_gradient.getColorAt(x / width));
  }
  
}