package com.texgen;
import com.texgen.Color;
import com.texgen.Buffer;
import com.texgen.TG.XYPair;

/**
 * ...
 * @author Yanrishatum
 */
class PutTexture extends Program
{

  private var _offset:XYPair;
  private var _repeat:RepeatMethod;
  private var _srcTex:Texture;
  
  public function new(texture:Texture) 
  {
    super();
    _offset = { x:0, y:0 };
    _repeat = RepeatMethod.Clamp;
    _srcTex = texture;
  }
  
  public function offset(x:Int, y:Int):PutTexture
  {
    _offset.x = x;
    _offset.y = y;
    return this;
  }
  
  public function repeat(value:RepeatMethod):PutTexture
  {
    _repeat = value;
    return this;
  }
  
  override public function process(output:Buffer, input:Buffer, color:Color, x:Int, y:Int, width:Int, height:Int):Void 
  {
    var texWidth:Int = _srcTex.width;
    var texHeight:Int = _srcTex.height;
    
    var texX:Int = Math.floor(x - _offset.x);
    var texY:Int = Math.floor(y - _offset.y);
    
    if (texX >= texWidth || texY >= texHeight || texX < 0 || texY < 0)
    {
      if (_repeat != RepeatMethod.None)
      {
        var nx:Float, ny:Float;
        var rangeX:Int = texWidth - 1;
        var rangeY:Int = texHeight - 1;
        
        switch (_repeat)
        {
          case RepeatMethod.Repeat:
            nx = TGUtils.wrap(texX, 0, texWidth);
            ny = TGUtils.wrap(texY, 0, texHeight);
          case RepeatMethod.Mirror:
            nx = TGUtils.mirroredWrap(texX, 0, rangeX);
            ny = TGUtils.mirroredWrap(texY, 0, rangeY);
          default: // Clamp
            nx = TGUtils.clamp(texX, 0, rangeX);
            ny = TGUtils.clamp(texY, 0, rangeY);
        }
          
        color.set(_srcTex.buffer.getPixelNearest(nx, ny));
      }
      else color.setGray(0);
    }
    else color.set(_srcTex.buffer.getPixelNearest(texX, texY));
  }
  
}