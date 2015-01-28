package com.texgen;

class SinY extends Program
{

  private var _frequency:Float = 1;
  private var _offset:Float = 0;
  
  public function new() 
  {
    super();
  }
  
  public function frequency(value:Float):SinY
  {
    _frequency = value * Math.PI;
    return this;
  }
  
  public function offset(value:Float):SinY
  {
    _offset = value;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    color.setGray(Math.sin((y + _offset) * _frequency));
  }
  
}