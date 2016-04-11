package com.texgen;

class Program
{

  private var _tint:Color;
  
  public function new() 
  {
    _tint = new Color();
  }
  
  public function tint(r:Float, g:Float, b:Float):Program
  {
    _tint.setRGB(r, g, b);
    return this;
  }
  
  public function getTint():Color
  {
    return _tint;
  }
  
  public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void
  {
    color.setGray(1);
  }
  
}