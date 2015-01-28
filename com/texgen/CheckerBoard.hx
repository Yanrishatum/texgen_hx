package com.texgen;
import com.texgen.Texture.Float32Array;
import com.texgen.TG.XYPair;

class CheckerBoard extends Program
{

  private var _size:XYPair;
  private var _offset:XYPair;
  private var _rowShift:Int;
  
  public function new() 
  {
    super();
    _size = { x: 32, y: 32 };
    _offset = { x: 0, y: 0 };
    _rowShift = 0;
  }
  
  public function size(x:Float, y:Float):CheckerBoard
  {
    _size.x = x;
    _size.y = y;
    return this;
  }
  
  public function offset(x:Float, y:Float):CheckerBoard
  {
    _offset.x = x;
    _offset.y = y;
    return this;
  }
  
  public function rowShift(value:Int):CheckerBoard
  {
    _rowShift = value;
    return this;
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    return (( Std.int((y + _offset.y) / _size.y) & 1 ) ^ ( Std.int((x + _offset.x + Std.int(y / _size.y) * _rowShift) / _size.x) & 1)) != 0 ? 0 : 1;
  }
}