package com.texgen;
import com.texgen.Buffer.Float32Array;

class Color
{

  public var r:Float;
  public var g:Float;
  public var b:Float;
  public var a:Float;
  
  public function new() 
  {
    this.r = 1;
    this.g = 1;
    this.b = 1;
    this.a = 1;
  }
  
  public inline function read(input:Float32Array, offset:Int):Void
  {
    this.r = input[offset];
    this.g = input[offset + 1];
    this.b = input[offset + 2];
  }
  
  public function setGray(v:Float):Color
  {
    this.r = v;
    this.g = v;
    this.b = v;
    return this;
  }
  
  public function set(color:Color):Color
  {
    this.r = color.r;
    this.g = color.g;
    this.b = color.b;
    return this;
  }
  
  public function setRGB(r:Float, g:Float, b:Float):Color
  {
    this.r = r;
    this.g = g;
    this.b = b;
    return this;
  }
  
  public function add(color:Color):Color
  {
    this.r += color.r;
    this.g += color.g;
    this.b += color.b;
    return this;
  }
  
  public function sub(color:Color):Color
  {
    this.r -= color.r;
    this.g -= color.g;
    this.b -= color.b;
    return this;
  }
  
  public function mul(color:Color):Color
  {
    this.r *= color.r;
    this.g *= color.g;
    this.b *= color.b;
    return this;
  }
  
  public function div(color:Color):Color
  {
    this.r /= color.r;
    this.g /= color.g;
    this.b /= color.b;
    return this;
  }
  
}