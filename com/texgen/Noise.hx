package com.texgen;
import com.texgen.Texture.Float32Array;

class Noise extends Program
{

  public function new() 
  {
    super();
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    return Math.random();
  }
  
}