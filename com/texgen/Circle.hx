package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TG.XYPair;

class Circle extends Program
{

  private var _position:XYPair;
  private var _radius:Float;
  private var _delta:Float;
  
  public function new() 
  {
    super();
    _position = { x:0, y:0 };
    _radius = 50;
    _delta = 1;
  }
  
  public function delta(value:Float):Circle
  {
    this._delta = value;
    return this;
  }
  
  public function position(x:Float, y:Float):Circle
  {
    _position.x = x;
    _position.y = y;
    return this;
  }
  
  public function radius(value:Float):Circle
  {
    _radius = value;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    color.setGray(1 - TGUtils.smoothStep(_radius - _delta, _radius, TGUtils.distance(x, y, _position.x, _position.y)));
  }
}