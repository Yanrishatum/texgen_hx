package com.texgen;
import com.texgen.Texture.Float32Array;

class SinX extends Program
{

  private var _frequency:Float = 1;
  private var _offset:Float = 0;
  
  public function new() 
  {
    super();
  }
  
  public function frequency(value:Float):SinX
  {
    _frequency = value * Math.PI;
    return this;
  }
  
  public function offset(value:Float):SinX
  {
    _offset = value;
    return this;
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    return Math.sin((x + _offset) * _frequency);
  }
}