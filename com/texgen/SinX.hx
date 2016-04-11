package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;

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
  
	var params = {
		frequency: 1,
		offset: 0
	};
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    color.setGray(Math.sin((x + _offset) * _frequency));
  }
  
}