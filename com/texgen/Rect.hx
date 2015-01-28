package com.texgen;
import com.texgen.Texture.Float32Array;
import com.texgen.TG.XYPair;

class Rect extends Program
{

  private var _position:XYPair;
  private var _size:XYPair;
  
  public function new() 
  {
    super();
    _position = { x: 0, y: 0 };
    _size = { x: 32, y: 32 };
  }
  
  public function position(x:Float, y:Float):Rect
  {
    _position.x = x;
    _position.y = y;
    return this;
  }
  
  public function size(x:Float, y:Float):Rect
  {
    _size.x = x;
    _size.y = y;
    return this;
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    return ( x >= _position.x && x <= (_position.x + _size.x) && y <= (_position.y + _size.y) && y >= _position.y) ? 1 : 0;
  }
  
}