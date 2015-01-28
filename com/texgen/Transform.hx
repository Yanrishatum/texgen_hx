package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TG.XYPair;

class Transform extends Program
{

  private var _offset:XYPair;
  private var _scale:XYPair;
  private var _angle:Float;
  
  private var _sinScaleX:Float;
  private var _sinScaleY:Float;
  private var _cosScaleX:Float;
  private var _cosScaleY:Float;
  
  public function new() 
  {
    super();
    _offset = { x: 0, y: 0 };
    _scale = { x: 1, y: 1 };
    angle(0);
  }
  
  public function offset(x:Float, y:Float):Transform
  {
    _offset.x = x;
    _offset.y = y;
    return this;
  }
  
  public function angleRad(value:Float):Transform
  {
    _angle = value;
    update();
    return this;
  }
  
  public function angle(value:Float):Transform
  {
    if (value == 0) _angle = 0;
    else _angle = TGUtils.deg2rad(value);
    update();
    return this;
  }
  
  public function scale(x:Float, y:Float):Transform
  {
    if (x == 0 || y == 0) return this;
    _scale.x = x;
    _scale.y = y;
    update();
    return this;
  }
  
  private function update():Void
  {
    _cosScaleX = Math.cos(_angle) / _scale.x;
    _cosScaleY = Math.cos(_angle) / _scale.y;
    _sinScaleX = Math.sin(_angle) / _scale.x;
    _sinScaleY = Math.sin(_angle) / _scale.y;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var x2:Float = x - width / 2;
    var y2:Float = y - height / 2;
    
    var s:Float = x2 * (_cosScaleX) + y2 * -(_sinScaleX);
    var t:Float = x2 * (_sinScaleY) + y2 *  (_cosScaleY);
    
    s += _offset.x + width / 2;
    t += _offset.y + height / 2;
    
    color.set(input.getPixelBilinear(s, t));
  }
  
}