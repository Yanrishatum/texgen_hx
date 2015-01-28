package com.texgen;
import com.texgen.Buffer.Float32Array;
import haxe.io.Bytes;
import haxe.io.BytesData;

#if openfl
import openfl.display.BitmapData;
#end

#if js

import js.Browser;
import js.html.CanvasRenderingContext2D;
import js.html.ImageData;
import js.html.Uint8ClampedArray;
import js.html.CanvasElement;
#end
// Support Float32Array forplatforms, that allows use of Float32Array.

class Texture
{

  public var width(default, null):Int;
  public var height(default, null):Int;
  
  private var array(default, null):Buffer;
  private var arrayCopy:Buffer;
  private var color:Color;
  
  
  public function new(width:Int, height:Int) 
  {
    this.width = width;
    this.height = height;
    
    this.array = new Buffer(width, height);
    this.arrayCopy = new Buffer(width, height);
    this.color = new Color();
  }
  
  public function pass(program:Program, ?operation:Operation):Texture
  {
    if (operation == null) operation = Operation.None;
    
    var modulate:Color = program.getColor();
    var array:Float32Array = this.array.array;
    
    var x:Int = 0, y:Int = 0, i:Int = 0, il:Int = array.length, color:Color = this.color;
    
    this.arrayCopy.copy(this.array);
    
    // Large code insertion here, because JS version uses dynamic function generation
    TexGenMacro.createOptimizedFunction();
    /*
    
    while (i < il)
    {
      program.process(this.array, arrayCopy, color, x, y, width, height);
      array[i] ${operation}= color.r * modulate.r;
      array[i] ${operation}= color.g * modulate.g;
      array[i] ${operation}= color.b * modulate.b;
      if (++x == width) { x = 0; y++; }
      i += 4;
    }
    
    */
    
    return this;
  }
  
  public function add(program:Program):Texture
  {
    return this.pass(program, Operation.Add);
  }
  
  public function sub(program:Program):Texture
  {
    return this.pass(program, Operation.Substract);
  }
  
  public function mul(program:Program):Texture
  {
    return this.pass(program, Operation.Multiply);
  }
  
  public function div(progarm:Program):Texture
  {
    return this.pass(progarm, Operation.Divide);
  }
  
  public function and(program:Program):Texture
  {
    return pass(program, Operation.And);
  }
  
  public function xor(program:Program):Texture
  {
    return pass(program, Operation.Xor);
  }
  
  public function or(program:Program):Texture
  {
    return pass(program, Operation.Or);
  }
  
  public function set(program:Program):Texture
  {
    return pass(program, Operation.None);
  }
  
  #if js
  
  public function toImageData(context:CanvasRenderingContext2D):ImageData
  {
    var array:Float32Array = this.array.array;
    
    var imageData:ImageData = context.createImageData(this.width, this.height);
    var data:Uint8ClampedArray = imageData.data;
    
    var i:Int = 0;
    var il:Int = array.length;
    while (i < il)
    {
      data[i    ] = Std.int(array[i    ] * 255);
      data[i + 1] = Std.int(array[i + 1] * 255);
      data[i + 2] = Std.int(array[i + 2] * 255);
      data[i + 3] = 255;
      i += 4;
    }
    
    return imageData;
  }
  
  public function toCanvas():CanvasElement
  {
    var canvas:CanvasElement = cast Browser.document.createElement("canvas");
    canvas.width = this.width;
    canvas.height = this.height;
    
    var context:CanvasRenderingContext2D = canvas.getContext("2d");
    var imageData:ImageData = this.toImageData(context);
    
    context.putImageData(imageData, 0, 0);
    
    return canvas;
  }
  
  #end
  
  private inline function safeValue(index:Int):Float
  {
    return TGUtils.clamp(array.array[index], 0, 1);
  }
  
  #if openfl
  
  public function toBitmapData(transparent:Bool = true):BitmapData
  {
    var data:BitmapData = new BitmapData(this.width, this.height, transparent, 0);
    var array:Float32Array = this.array.array;
    data.lock();
    var x:Int = 0, y:Int = 0, i:Int = 0, il:Int = array.length;
    if (transparent)
    {
      while (i < il)
      {
        data.setPixel32(x, y, (Std.int(safeValue(i) * 255) << 16) | (Std.int(safeValue(i + 1) * 255) << 8) | Std.int(safeValue(i + 2) * 255) | 0xFF000000);
        if (++x == width) { x = 0; y++; }
        i += 4;
      }
    }
    else
    {
      while (i < il)
      {
        data.setPixel(x, y, (Std.int(safeValue(i) * 255) << 16) | (Std.int(safeValue(i + 1) * 255) << 8) | Std.int(safeValue(i + 2) * 255));
        if (++x == width) { x = 0; y++; }
        i += 4;
      }
    }
    return data;
  }
  
  #end
  
  public function toBytesRGBA():Bytes
  {
    var bytes:Bytes = Bytes.alloc(this.width * this.height * 4);
    var array:Float32Array = this.array.array;
    
    var i:Int = 0, il:Int = array.length;
    while (i < il)
    {
      bytes.set(i    , Std.int(safeValue(i    ) * 255));
      bytes.set(i + 1, Std.int(safeValue(i + 1) * 255));
      bytes.set(i + 2, Std.int(safeValue(i + 2) * 255));
      bytes.set(i + 3, 255);
      i += 4;
    }
    return bytes;
  }
  
  public function toBytesBGRA():Bytes
  {
    var bytes:Bytes = Bytes.alloc(this.width * this.height * 4);
    var array:Float32Array = this.array.array;
    
    var i:Int = 0, il:Int = array.length;
    while (i < il)
    {
      bytes.set(i    , Std.int(safeValue(i    ) * 255));
      bytes.set(i + 3, Std.int(safeValue(i + 1) * 255));
      bytes.set(i + 2, Std.int(safeValue(i + 2) * 255));
      bytes.set(i + 1, 255);
      i += 4;
    }
    return bytes;
  }
  
  public function toBytesARGB():Bytes
  {
    var bytes:Bytes = Bytes.alloc(this.width * this.height * 4);
    var array:Float32Array = this.array.array;
    
    var i:Int = 0, il:Int = array.length;
    while (i < il)
    {
      bytes.set(i + 1, Std.int(safeValue(i    ) * 255));
      bytes.set(i + 2, Std.int(safeValue(i + 1) * 255));
      bytes.set(i + 3, Std.int(safeValue(i + 2) * 255));
      bytes.set(i    , 255);
      i += 4;
    }
    return bytes;
  }
  
  public function toBytesABGR():Bytes
  {
    var bytes:Bytes = Bytes.alloc(this.width * this.height * 4);
    var array:Float32Array = this.array.array;
    
    var i:Int = 0, il:Int = array.length;
    while (i < il)
    {
      bytes.set(i + 3, Std.int(safeValue(i    ) * 255));
      bytes.set(i + 2, Std.int(safeValue(i + 1) * 255));
      bytes.set(i + 1, Std.int(safeValue(i + 2) * 255));
      bytes.set(i    , 255);
      i += 4;
    }
    return bytes;
  }
  
}