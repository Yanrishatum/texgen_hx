package com.texgen;
import com.texgen.Color;

class OR extends Program
{

  public function new() 
  {
    super();
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    color.setGray((x | y) / width);
  }
  
}