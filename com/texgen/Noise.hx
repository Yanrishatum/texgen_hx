package com.texgen;
import com.texgen.Color;
import haxe.Timer;

class Noise extends Program
{

  private var _seed:Int;
  
  public function new() 
  {
    super();
    _seed = Std.int(Timer.stamp());
  }
  
  public function seed(seed:Int):Noise
  {
    this._seed = seed;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    color.setGray(TGUtils.hashRNG(_seed, x, y));
  }
  
}