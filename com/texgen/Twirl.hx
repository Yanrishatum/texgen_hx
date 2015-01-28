package com.texgen;
import com.texgen.Texture.Float32Array;
import com.texgen.TG.XYPair;

class Twirl extends Program
{
  
  private var _strength:Float;
  private var _radius:Float;
  private var _position:XYPair;
  
  public function new() 
  {
    super();
    _strength = 0;
    _radius = 120;
    _position = { x:128, y:128 };
  }
  
  public function strength(value:Float):Twirl
  {
    _strength = value / 100;
    return this;
  }
  
  public function radius(value:Float):Twirl
  {
    _radius = value;
    return this;
  }
  
  public function position(x:Float, y:Float):Twirl
  {
    _position.x = x;
    _position.y = y;
    return this;
  }
  
  override public function process(output:Float32Array, input:Float32Array, width:Int, height:Int, x:Int, y:Int):Float 
  {
    /*
     * 
				'var dist = TG.Utils.distance( x, y, ' + position[ 0 ] + ',' + position[ 1 ] + ');',

				// no distortion if outside of whirl radius.

				'dist = dist > '+ radius +' ? 0 : Math.pow('+ radius +' - dist, 2) / ' + radius + ';',

				'var angle = 2.0 * Math.PI * (dist / (' + radius + ' / ' + strength + '));',
				'var xpos = (((x - ' + position[ 0 ] + ') * Math.cos(angle)) - ((y - ' + position[ 0 ] + ') * Math.sin(angle)) + ' + position[ 0 ] + ' + 0.5);',
				'var ypos = (((y - ' + position[ 1 ] + ') * Math.cos(angle)) + ((x - ' + position[ 1 ] + ') * Math.sin(angle)) + ' + position[ 1 ] + ' + 0.5);',

				'var color = TG.Utils.getPixelBilinear(src, xpos, ypos, 0, width);'
     * */
    
    var dist:Float = TGUtils.distance(x, y, _position.x, _position.y);
    
    // no distortion if outside of whirl radius.
    dist = dist > _radius ? 0 : Math.pow(_radius - dist, 2) / _radius;
    
    var angle:Float = 2 * Math.PI * (dist / (_radius / _strength));
    var xpos:Float = (((x - _position.x) * Math.cos(angle)) - ((y - _position.x) * Math.sin(angle)) + _position.x + 0.5);
    var ypos:Float = (((y - _position.y) * Math.cos(angle)) + ((x - _position.y) * Math.sin(angle)) + _position.y + 0.5);
    
    return TGUtils.getPixelBilinear(input, xpos, ypos, 0, width);
  }
  
}