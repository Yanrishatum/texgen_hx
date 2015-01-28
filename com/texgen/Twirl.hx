package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TG.XYPair;

class Twirl extends Program
{
  
  private var _strength:Float;
  private var _radius:Float;
  private var _position:XYPair;
  
  public function new() 
  {
    super();
    _strength = 0;
    _radius = 120;
    _position = { x:128, y:128 };
  }
  
  public function strength(value:Float):Twirl
  {
    _strength = value / 100;
    return this;
  }
  
  public function radius(value:Float):Twirl
  {
    _radius = value;
    return this;
  }
  
  public function position(x:Float, y:Float):Twirl
  {
    _position.x = x;
    _position.y = y;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var dist:Float = TGUtils.distance(x, y, _position.x, _position.y);
    
    var s:Float;
    var t:Float;
    if (dist < _radius)
    {
      dist = Math.pow(_radius - dist, 2) / _radius;
      
      var angle:Float = 2 * Math.PI * (dist / (_radius / _strength));
      var cos:Float = Math.cos(angle);
      var sin:Float = Math.sin(angle);
      s = (((x - _position.x) * cos) - ((y - _position.x) * sin) + _position.x + 0.5);
      t = (((y - _position.y) * cos) + ((x - _position.y) * sin) + _position.y + 0.5);
    }
    else 
    {
      s = x;
      t = y;
    }
    
    color.set(input.getPixelBilinear(s, t));
  }
  
  
}