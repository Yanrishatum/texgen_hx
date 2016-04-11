package;
import com.texgen.Texture;
import flash.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Yanrishatum
 */
class ExamplePage extends Sprite
{

  public function new() 
  {
    super();
  }
  
  private var offX:Float = 0;
  private var offY:Float = 0;
  private var size:Float;
  
  private function newLine():Void
  {
    offY = size;
    offX = 0;
  }
  
  private function createSample(tex:Texture, ?description:String):Texture
  {
    var bitmapData:BitmapData = tex.toBitmapData();
    var bitmap:Bitmap = new Bitmap(bitmapData);
    bitmap.x = offX;
    bitmap.y = offY;
    addChild(bitmap);
    offX += bitmap.width;
    if (description == null)
    {
      size = bitmap.y + bitmap.height;
    }
    else
    {
      var text:TextField = new TextField();
      text.defaultTextFormat = new TextFormat("Arial", 16, 0, false, false, false, null, null, TextFormatAlign.CENTER);
      text.width = bitmap.width;
      text.multiline = true;
      text.wordWrap = true;
      text.x = bitmap.x;
      text.y = bitmap.y + bitmap.height + 2;
      text.text = description;
      text.height = text.textHeight;
      size = text.y + text.height + 5;
      addChild(text);
    }
    
    return tex;
  }
}