package com.texgen;
import haxe.ds.Vector;

#if js
typedef Float32Array = js.html.Float32Array;
#elseif flash
typedef Float32Array = flash.Vector<Float>;
#else
typedef Float32Array = haxe.ds.Vector<Float>;
#end

/**
 * ...
 * @author Yanrishatum
 */
class Buffer
{
  
  public var width:Int;
  public var height:Int;
  public var len:Int;
  
  public var array:Float32Array;
  public var color:Color;

  public function new(width:Int, height:Int) 
  {
    this.width = width;
    this.height = height;
    
    this.len = width * height * 4;
    
    #if flash
    this.array = new Float32Array(len, true);
    #else
    this.array = new Float32Array(len);
    #end
    #if !js
    for (i in 0...len) this.array[i] = 0;
    #end
    // Fill array, if we're not on JS target
    this.color = new Color();
  }
  
  public function copy(input:Buffer):Void
  {
    var inputBuffer:Float32Array = input.array;
    #if js
    this.array.set(inputBuffer);
    #elseif flash
    for (i in 0...len) this.array[i] = inputBuffer[i]; // Cheers.
    #else
    Vector.blit(inputBuffer, 0, array, 0, len);
    #end
  }
  
  public function getPixelNearest(x:Float, y:Float):Color
  {
    x = TGUtils.wrap(Math.round(x), 0, width);
    y = TGUtils.wrap(Math.round(y), 0, height);
    this.color.read(this.array, (Std.int(y) * this.width + Std.int(x)) * 4);
    return this.color;
  }
  
  // Safe pixel get
  private inline function safe(offset:Int):Float
  {
    return offset < 0 || offset >= len ? 0 : array[offset];
  }
  
  public function getPixelBilinear(x:Float, y:Float):Color
  {
    x = TGUtils.wrap(x, 0, width);
    y = TGUtils.wrap(y, 0, height);
    
    var px:Int = Math.floor(x);
    var py:Int = Math.floor(y);
    var p0:Int = px + py * width;
    
    var array:Float32Array = this.array;
    var color:Color = this.color;
    
    var fx:Float = x - px;
    var fy:Float = y - py;
    var fx1:Float = 1 - fx;
    var fy1:Float = 1 - fy;
    
    var w1:Float = fx1 * fy1;
    var w2:Float = fx * fy1;
    var w3:Float = fx1 * fy;
    var w4:Float = fx * fy;
    
    var p1:Int = p0 * 4;                    // 0 + 0 * w
    var p2:Int = (1 + p0) * 4;              // 1 + 0 * w
    var p3:Int = (this.width + p0) * 4;     // 0 + 1 * w
    var p4:Int = (1 + this.width + p0) * 4; // 1 + 1 * w
    
    // Calculate the weighted sum of pixels (for each color channel)
    color.r = safe(p1    ) * w1 + safe(p2    ) * w2 + safe(p3    ) * w3 + safe(p4    ) * w4;
    color.g = safe(p1 + 1) * w1 + safe(p2 + 1) * w2 + safe(p3 + 1) * w3 + safe(p4 + 1) * w4;
    color.b = safe(p1 + 2) * w1 + safe(p2 + 2) * w2 + safe(p3 + 2) * w3 + safe(p4 + 2) * w4;
    color.a = safe(p1 + 3) * w1 + safe(p2 + 3) * w2 + safe(p3 + 3) * w3 + safe(p4 + 3) * w4;
    
    return color;
  }
  
  public function getPixelOffset(offset:Float):Color
  {
    color.read(array, Std.int(offset) * 4);
    return color;
  }
}