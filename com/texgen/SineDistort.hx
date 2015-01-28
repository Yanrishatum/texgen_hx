package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TG.XYPair;

class SineDistort extends Program
{

  private var _sines:XYPair;
  private var _offset:XYPair;
  private var _amplutude:XYPair;
  
  public function new() 
  {
    super();
    _sines = { x:4 / 100, y:4 / 100 };
    _offset = { x:0, y:0 };
    _amplutude = { x:16, y:16 };
  }
  
  public function sines(x:Float, y:Float):SineDistort
  {
    _sines.x = x / 100;
    _sines.y = y / 100;
    return this;
  }
  
  public function offset(x:Float, y:Float):SineDistort
  {
    _offset.x = x;
    _offset.y = y;
    return this;
  }
  
  public function amplitude(x:Float, y:Float):SineDistort
  {
    _amplutude.x = x;
    _amplutude.y = y;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var s:Float = Math.sin(_sines.x * y + _offset.x) * _amplutude.x + x;
    var t:Float = Math.sin(_sines.y * x + _offset.y) * _amplutude.y + y;
    color.set(input.getPixelBilinear(s, t));
  }
  
}