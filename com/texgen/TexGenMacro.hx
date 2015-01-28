package com.texgen;
import haxe.macro.Context;
import haxe.macro.Expr;

class TexGenMacro
{

  // Every operation need it's own while
  public static macro function createOptimizedFunction():Expr
  {
    var pos:Position = Context.currentPos();
    return macro
      switch(operation)
      {
        case Operation.Add: ${getColorCheck("+=")}
        case Operation.Substract: ${getColorCheck("-=")}
        case Operation.Divide: ${getColorCheck("/=")}
        case Operation.Multiply: ${getColorCheck("*=")}
        case Operation.And: ${getColorCheck("&=")}
        case Operation.Or: ${getColorCheck("|=")}
        case Operation.Xor: ${getColorCheck("^=")}
        default: ${getColorCheck("=")}
      }
  }
  
  #if macro
  
  // To avoid unnecessary checks
  private static function getColorCheck(op:String):Expr
  {
    var pos:Position = Context.currentPos();
    #if texgen_noModulateOptimization
    return macro $b{getWhile(true, true, true, op)};
    #else
    return (macro 
    {
      if (modulate.r != 0)
      {
        if (modulate.g != 0)
        {
          if (modulate.b != 0) ${getWhile(true, true, true, op)}
          else ${getWhile(true, true, false, op)}
        }
        else if (modulate.b != 0) ${getWhile(true, false, true, op)}
        else ${getWhile(true, false, false, op)}
      }
      else
      {
        if (modulate.g != 0)
        {
          if (modulate.b != 0) ${getWhile(false, true, true, op)}
          else ${getWhile(false, true, false, op)}
        }
        else
        {
          if (modulate.b != 0) ${getWhile(false, false, true, op)}
        }
      }
    }
    );
    #end
  }
  
  private static function getWhile(r:Bool, g:Bool, b:Bool, op:String):Expr
  {
    var pos:Position = Context.currentPos();
    return macro while (i < il) $b{getAssign(r, g, b, op)};
    /*
    while (i < il)
    {
      value = program.process(array, width, height, x, y);
      array[i    ] += value * color.r; <--- If r == true
      array[i + 1] += value * color.g; <--- If g == true
      array[i + 2] += value * color.b; <--- If b == true
      if (++x == width) { x = 0; y++; }
      i += 4;
    }
    */
  }
  
  private static function getAssign(r:Bool, g:Bool, b:Bool, op:String):Array<Expr>
  {
    var result:Array<Expr> = new Array();
    result.push(macro program.process(this.array, arrayCopy, color, x, y, width, height) );
    if (op == "&=" || op == "|=" || op == "^=")
    {
      // For binary operation we must convert values to Int.
      if (r) result.push(Context.parse("array[i    ] = Std.int(array[i    ]) " + op.charAt(0) + " Std.int(color.r * modulate.r)", Context.currentPos()));
      if (g) result.push(Context.parse("array[i + 1] = Std.int(array[i + 1]) " + op.charAt(0) + " Std.int(color.g * modulate.g)", Context.currentPos()));
      if (b) result.push(Context.parse("array[i + 2] = Std.int(array[i + 2]) " + op.charAt(0) + " Std.int(color.b * modulate.b)", Context.currentPos()));
    }
    else
    {
      if (r) result.push(Context.parse("array[i    ] " + op + "color.r * modulate.r", Context.currentPos()));
      if (g) result.push(Context.parse("array[i + 1] " + op + "color.g * modulate.g", Context.currentPos()));
      if (b) result.push(Context.parse("array[i + 2] " + op + "color.b * modulate.b", Context.currentPos()));
    }
    result.push(macro if (++x == width) { x = 0; y++; } );
    result.push(macro i += 4 );
    return result;
  }
  
  #end
  
}