package com.texgen;

class TG
{

  public static function texture(width:Int, height:Int):Texture
  {
    return new Texture(width, height);
  }
  
  public static function number():Program
  {
    return new Program();
  }
  
  public static function sinX():SinX
  {
    return new SinX();
  }
  
  public static function sinY():SinY
  {
    return new SinY();
  }
  
  public static function or():OR
  {
    return new OR();
  }
  
  public static function xor():XOR
  {
    return new XOR();
  }
  
  public static function noise():Noise
  {
    return new Noise();
  }
  
  public static function fractalNoise():FractalNoise
  {
    return new FractalNoise();
  }
  
  public static function cellularNoise():CellularNoise
  {
    return new CellularNoise();
  }
  
  public static function voronoiNoise():VoronoiNoise
  {
    return new VoronoiNoise();
  }
  
  public static function cellularFractal():CellularFractal
  {
    return new CellularFractal();
  }
  
  public static function voronoiFractal():VoronoiFractal
  {
    return new VoronoiFractal();
  }
  
  public static function checkerBoard():CheckerBoard
  {
    return new CheckerBoard();
  }
  
  public static function rect():Rect
  {
    return new Rect();
  }
  
  public static function circle():Circle
  {
    return new Circle();
  }
  
  public static function putTexture(texture:Texture):PutTexture
  {
    return new PutTexture(texture);
  }
  
  // Filters
  
  public static function sineDistort():SineDistort
  {
    return new SineDistort();
  }
  
  public static function twirl():Twirl
  {
    return new Twirl();
  }
  
  public static function transform():Transform
  {
    return new Transform();
  }
  
  public static function pixelate():Pixelate
  {
    return new Pixelate();
  }
  
  public static function gradientMap():GradientMap
  {
    return new GradientMap();
  }
  
  public static function normalize():Normalize
  {
    return new Normalize();
  }
  
  public static function radialGradient():RadialGradient
  {
    return new RadialGradient();
  }
  
  public static function linearGradient():LinearGradient
  {
    return new LinearGradient();
  }
  
}

typedef XYPair =
{
  var x:Float;
  var y:Float;
}