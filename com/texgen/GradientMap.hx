package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;

/**
 * ...
 * @author Yanrishatum
 */
class GradientMap extends Program
{

  private var _gradient:ColorInterpolator;
  
  public function new() 
  {
    super();
    _gradient = new ColorInterpolator(ColorInterpolatorMethod.Linear);
  }
  
  public function repeat(value:RepeatMethod):GradientMap
  {
    _gradient.setRepeat(value);
    return this;
  }
  
  public function interpolation(value:ColorInterpolatorMethod):GradientMap
  {
    _gradient.setInterpolation(value);
    return this;
  }
  
  public function point(position:Float, color:Color):GradientMap
  {
    _gradient.addPoint(position, color);
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var v:Color = input.getPixelNearest(x, y);
    
    color.setRGB(_gradient.getColorAt(v.r).r,
                 _gradient.getColorAt(v.g).g,
                 _gradient.getColorAt(v.b).b);
  }
  
}