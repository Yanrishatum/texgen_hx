package com.texgen;

class Program
{

  private var _color:Color;
  
  public function new() 
  {
    _color = new Color();
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
  
  public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void
  {
    color.setGray(1);
  }
  
}