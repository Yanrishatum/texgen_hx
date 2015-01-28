package com.texgen;
import haxe.macro.Context;
import haxe.macro.Expr;

class TexGenMacro
{

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
  
  private static function getColorCheck(op:String):Expr
  {
    var pos:Position = Context.currentPos();
    return (macro 
    {
      if (color.r != 0)
      {
        if (color.g != 0)
        {
          if (color.b != 0) ${getWhile(true, true, true, op)}
          else ${getWhile(true, true, false, op)}
        }
        else if (color.b != 0) ${getWhile(true, false, true, op)}
        else ${getWhile(true, false, false, op)}
      }
      else
      {
        if (color.g != 0)
        {
          if (color.b != 0) ${getWhile(false, true, true, op)}
          else ${getWhile(false, true, false, op)}
        }
        else
        {
          if (color.b != 0) ${getWhile(false, false, true, op)}
        }
      }
    }
    );
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
    result.push(macro value = program.process(array, arrayCopy, width, height, x, y) );
    if (r) result.push(Context.parse(getAssignString(0, "r", op), Context.currentPos()));
    if (g) result.push(Context.parse(getAssignString(1, "g", op), Context.currentPos()));
    if (b) result.push(Context.parse(getAssignString(2, "b", op), Context.currentPos()));
    result.push(macro if (++x == width) { x = 0; y++; } );
    result.push(macro i += 4 );
    return result;
  }
  
  private static function getAssignString(offset:Int, colorValue:String, op:String):String
  {
    var buf:StringBuf = new StringBuf();
    buf.add("array[i");
    if (offset != 0) { buf.add("+"); buf.add(Std.string(offset)); }
    buf.add("]");
    if (op == "&=" || op == "|=" || op == "^=")
    {
      buf.add("= Std.int(array[i");
      if (offset != 0) { buf.add("+"); buf.add(Std.string(offset)); }
      buf.add("])");
      buf.addChar(op.charCodeAt(0));
      buf.add("Std.int(value*color.");
      buf.add(colorValue);
      buf.add(")");
    }
    else
    {
      buf.add(op);
      buf.add("value*color.");
      buf.add(colorValue);
    }
    return buf.toString();
  }
  
  #end
  
}