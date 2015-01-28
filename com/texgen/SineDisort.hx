package com.texgen;
import com.texgen.Texture.Float32Array;
import com.texgen.TG.XYPair;

class SineDisort extends Program
{

  private var _sines:XYPair;
  private var _offset:XYPair;
  private var _amplutude:XYPair;
  
  public function new() 
  {
    super();
    _sines = { x:0.04, y:0.04 };
    _offset = { x:4, y:4 };
    _amplutude = { x:16, y:16 };
  }
  
  public function sines(x:Float, y:Float):SineDisort
  {
    _sines.x = x / 100;
    _sines.y = y / 100;
    return this;
  }
  
  public function offset(x:Float, y:Float):SineDisort
  {
    _offset.x = x;
    _offset.y = y;
    return this;
  }
  
  public function amplitude(x:Float, y:Float):SineDisort
  {
    _amplutude.x = x;
    _amplutude.y = y;
    return this;
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    /*
				'var sx = Math.sin(' + sines[ 0 ] / 100 + ' * y + ' + offset[ 0 ] + ') * ' + amplitude[ 0 ] + ' + x;',
				'var sy = Math.sin(' + sines[ 1 ] / 100 + ' * x + ' + offset[ 1 ] + ') * ' + amplitude[ 1 ] + ' + y;',
				'var color = TG.Utils.getPixelBilinear(src, sx, sy, 0, width);'
			].join( '\n' );
    */
    var sx:Float = Math.sin(_sines.x * y + _offset.x) * _amplutude.x + x;
    var sy:Float = Math.sin(_sines.y * x + _offset.y) * _amplutude.y + y;
    return TGUtils.getPixelBilinear(input, sx, sy, 0, width);
  }
  
}