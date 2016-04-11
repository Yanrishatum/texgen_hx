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
  
  public var buffer(default, null):Buffer;
  private var bufferCopy:Buffer;
  private var color:Color;
  private var tint:Color;
  
  public function new(width:Int, height:Int) 
  {
    this.width = width;
    this.height = height;
    
    this.buffer = new Buffer(width, height);
    this.bufferCopy = new Buffer(width, height);
    this.color = new Color();
  }
  
  public function pass(program:Program, ?operation:Operation):Texture
  {
    if (operation == null) operation = Operation.Set;
    
    var dst:Buffer = this.buffer;
    var src:Buffer = this.bufferCopy;
    src.copy(dst);
    
    var op:Float->Float->Float =
    switch (operation)
    {
      case Operation.Custom(fn): fn;
      case Operation.Add: opAdd;
      case Operation.And: opAnd;
      case Operation.Divide: opDiv;
      case Operation.Max: opMax;
      case Operation.Min: opMin;
      case Operation.Multiply: opMul;
      case Operation.Set: opSet;
      case Operation.Or: opOr;
      case Operation.Xor: opXor;
      case Operation.Substract: opSub;
    }
    
    var x:Int = 0;
    var y:Int = 0;
    var array = dst.array;
    var width:Int = dst.width;
    var height:Int = dst.height;
    var tint:Color = program.getTint();
    
    var i:Int = 0;
    var il:Int = array.length;
    while (i < il)
    {
      program.process(dst, src, color, x, y, width, height);
      array[i    ] = op(array[i    ], color.r * tint.r);
      array[i + 1] = op(array[i + 1], color.g * tint.g);
      array[i + 2] = op(array[i + 2], color.b * tint.b);
      if (++x == width) { x = 0; y++; }
      i += 4;
    }
    
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
    return pass(program, Operation.Set);
  }
  
  public function min(program:Program):Texture
  {
    return pass(program, Operation.Min);
  }
  
  public function max(program:Program):Texture
  {
    return pass(program, Operation.Max);
  }
  
  // Built-in operations
  private static function opAdd(a:Float, b:Float):Float { return a + b; }
  private static function opSub(a:Float, b:Float):Float { return a - b; }
  private static function opMul(a:Float, b:Float):Float { return a * b; }
  private static function opDiv(a:Float, b:Float):Float { return a / b; }
  private static function opAnd(a:Float, b:Float):Float { return Std.int(a) & Std.int(b); }
  private static function opXor(a:Float, b:Float):Float { return Std.int(a) ^ Std.int(b); }
  private static function opOr(a:Float, b:Float):Float { return Std.int(a) | Std.int(b); }
  private static function opMin(a:Float, b:Float):Float { return a < b ? a : b; }
  private static function opMax(a:Float, b:Float):Float { return a > b ? a : b; }
  private static function opSet(a:Float, b:Float):Float { return b; }
  
  #if js
  
  public function toImageData(context:CanvasRenderingContext2D):ImageData
  {
    var array:Float32Array = this.buffer.array;
    
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
    return TGUtils.clamp(buffer.array[index], 0, 1);
  }
  
  #if openfl
  
  public function toBitmapData(transparent:Bool = true):BitmapData
  {
    var data:BitmapData = new BitmapData(this.width, this.height, transparent, 0);
    var array:Float32Array = this.buffer.array;
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
    var array:Float32Array = this.buffer.array;
    
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
    var array:Float32Array = this.buffer.array;
    
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
    var array:Float32Array = this.buffer.array;
    
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
    var array:Float32Array = this.buffer.array;
    
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