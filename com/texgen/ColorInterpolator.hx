package com.texgen;
import com.texgen.ColorInterpolator.InterpolatorPoint;

typedef InterpolatorPoint =
{
  var pos:Float;
  var color:Color;
}

/**
 * ...
 * @author Yanrishatum
 */
class ColorInterpolator
{

  public var points:Array<InterpolatorPoint>;
  public var low:Float;
  public var high:Float;
  public var interpolation:ColorInterpolatorMethod;
  public var repeat:RepeatMethod;
  
  public function new(?method:ColorInterpolatorMethod) 
  {
    this.points = new Array();
    this.low = 0;
    this.high = 0;
    this.interpolation = method == null ? ColorInterpolatorMethod.Linear : method;
    this.repeat = RepeatMethod.Clamp;
  }
  
  public function set(points:Array<InterpolatorPoint>):ColorInterpolator
  {
    this.points = points;
    this.points.sort(sortPoints);
		/*this.points.sort( function( a, b ) {
			return a.pos - b.pos;
		});*/
    
    this.low = points[0].pos;
    this.high = points[points.length - 1].pos;
    
    return this;
  }
  
  private function sortPoints(a:InterpolatorPoint, b:InterpolatorPoint):Int
  {
    return Std.int(a.pos - b.pos);
  }
  
  public function addPoint(position:Float, color:Color):ColorInterpolator
  {
    this.points.push( { pos: position, color: color } );
    this.points.sort(sortPoints);
    
    this.low = this.points[0].pos;
    this.high = this.points[this.points.length - 1].pos;
    
    return this;
  }
  
  public function setRepeat(value:RepeatMethod):ColorInterpolator
  {
    this.repeat = value;
    return this;
  }
  
  public function setInterpolation(value:ColorInterpolatorMethod):ColorInterpolator
  {
    this.interpolation = value;
    return this;
  }
  
  public function getColorAt(pos:Float):Color
  {
    switch (this.repeat)
    {
      case RepeatMethod.Mirror: pos = TGUtils.mirroredWrap(pos, this.low, this.high);
      case RepeatMethod.Repeat: pos = TGUtils.wrap(pos, this.low, this.high);
      default: pos = TGUtils.clamp(pos, this.low, this.high);
    }
    
    var i:Int = 0;
    var points:Array<InterpolatorPoint> = this.points;
    
    while (points[i + 1].pos < pos) i++;
    
    var p1:InterpolatorPoint = points[i];
    var p2:InterpolatorPoint = points[i + 1];
    
    var delta:Float = (pos - p1.pos) / (p2.pos - p1.pos);
    
    switch (this.interpolation)
    {
      case ColorInterpolatorMethod.Step:
        return p1.color;
      case ColorInterpolatorMethod.Linear:
        return TGUtils.mixColors(p1.color, p2.color, delta);
      case ColorInterpolatorMethod.Spline:
        var ar:Float =  2 * p1.color.r - 2 * p2.color.r;
        var br:Float = -3 * p1.color.r + 3 * p2.color.r;
        var dr:Float = p1.color.r;
        
        var ag:Float =  2 * p1.color.g - 2 * p2.color.g;
        var bg:Float = -3 * p1.color.g + 3 * p2.color.g;
        var dg:Float = p1.color.g;
        
        var ab:Float =  2 * p1.color.b - 2 * p2.color.b;
        var bb:Float = -3 * p1.color.b + 3 * p2.color.b;
        var db:Float = p1.color.b;
        
        var delta2:Float = delta * delta;
        var delta3:Float = delta2 * delta;
        
        return new Color(ar * delta3 + br * delta2 + dr,
                         ag * delta3 + bg * delta2 + dg,
                         ab * delta3 + bb * delta2 + db);
    }
  }
}