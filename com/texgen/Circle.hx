package com.texgen;
import com.texgen.Texture.Float32Array;
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
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    var dist:Float = TGUtils.distance(x, y, _position.x, _position.y);
    return TGUtils.smoothStep(_radius - _delta, _radius, dist);
  }
}