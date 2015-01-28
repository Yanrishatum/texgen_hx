package com.texgen;
import com.texgen.Texture.Float32Array;

class Program
{

  private var _color:Color;
  
  public function new() 
  {
    _color = new Color(1, 1, 1);
  }
  
  public function color(r:Float, g:Float, b:Float):Program
  {
    _color.r = r;
    _color.g = g;
    _color.b = b;
    return this;
  }
  
  public function getColor():Color
  {
    return _color;
  }
  
  public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float
  {
    return 1;
  }
  
}