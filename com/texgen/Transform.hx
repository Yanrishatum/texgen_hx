package com.texgen;
import com.texgen.Texture.Float32Array;
import com.texgen.TG.XYPair;

class Transform extends Program
{

  private var _offset:XYPair;
  private var _angle:Float;
  private var _scale:XYPair;
  private var _sinScaleX:Float;
  private var _sinScaleY:Float;
  private var _cosScaleX:Float;
  private var _cosScaleY:Float;
  
  public function new() 
  {
    super();
    _offset = { x: 0, y: 0 };
    angle(0);
    _scale = { x: 1, y: 1 };
  }
  
  public function offset(x:Float , y:Float):Transform
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
    return angleRad(TGUtils.deg2rad(value));
  }
  
  public function scale(x:Float, y:Float):Transform
  {
    if (x == 0 || y == 0) return this;
    _scale.x = x;
    _scale.y = y;
    update();
    return this;
  }
  
  private inline function update():Void
  {
    _cosScaleX = Math.cos(_angle) / _scale.x;
    _cosScaleY = Math.cos(_angle) / _scale.y;
    _sinScaleX = Math.cos(_angle) / _scale.x;
    _sinScaleY = Math.cos(_angle) / _scale.y;
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    var x2:Float = x - width / 2;
    var y2:Float = y - height / 2;
    
    var s:Float = (x2 * _cosScaleX + y2 * -_sinScaleX) + (_offset.x + width / 2);
    var t:Float = ( x2 * _sinScaleY + y2 *  _cosScaleY) + (_offset.y + height / 2);
    return TGUtils.getPixelBilinear(input, s, y, 0, width);
  }
  
}