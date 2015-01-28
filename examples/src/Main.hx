package;

import com.texgen.Texture;
import com.texgen.TG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Lib;

class Main extends Sprite 
{

	public function new() 
	{
		super();
    
    createSample(TG.texture(256, 256)
    .add(TG.xor().color(1, 0.5, 0.7))
    .add(TG.sinX().frequency(0.004).color(0.5, 0, 0))
    .mul(TG.sinY().frequency(0.004).color(0.5, 0, 0))
    .add(TG.sinX().frequency(0.0065).color(0.1, 0.5, 0.2))
    .add(TG.sinY().frequency(0.0065).color(0.5, 0.5, 0.5))
    .add(TG.noise().color(0.1, 0.1, 0.2)));
    
    createSample(TG.texture(256, 256)
    .add(TG.sinX().offset( -16).frequency(0.03).color(0.1, 0.25, 0.5))
    .add(TG.sinY().offset( -16).frequency(0.03).color(0.1, 0.25, 0.5))
    .add(TG.number().color(0.75, 0.5, 0.5))
    .add(TG.sinX().frequency(0.03).color(0.2, 0.2, 0.2))
    .add(TG.sinY().frequency(0.03).color(0.2, 0.2, 0.2))
    .add(TG.noise().color(0.1, 0, 0))
    .add(TG.noise().color(0, 0.1, 0))
    .add(TG.noise().color(0, 0, 0.1)));
    
    createSample(TG.texture(256, 256)
    .add(TG.sinX().frequency(0.1))
    .mul(TG.sinX().frequency(0.05))
    .mul(TG.sinX().frequency(0.025))
    .mul(TG.sinY().frequency(0.1))
    .mul(TG.sinY().frequency(0.05))
    .mul(TG.sinY().frequency(0.025))
    .add(TG.sinX().frequency(0.004).color( -0.25, 0.1, 0.6)));
    
    createSample(TG.texture(256, 256)
    .add(TG.xor())
    .mul(TG.or().color(0.5, 0.8, 0.5))
    .mul(TG.sinX().frequency(0.0312))
    .div(TG.sinY().frequency(0.0312))
    .add(TG.sinX().frequency(0.004).color(0.5, 0, 0))
    .add(TG.noise().color(0.1, 0.1, 0.2)));
    
    createSample(TG.texture(256, 256)
    .add(TG.sinX().frequency(0.01))
    .mul(TG.sinY().frequency(0.0075))
    .add(TG.sinX().frequency(0.0225))
    .mul(TG.sinY().frequency(0.015))
    .add(TG.noise().color(0.1, 0.1, 0.3)));
    
    createSample(TG.texture(256, 256)
    .add(TG.sinX().frequency(0.05))
    .mul(TG.sinX().frequency(0.08))
    .add(TG.sinY().frequency(0.05))
    .mul(TG.sinY().frequency(0.08))
    .div(TG.number().color(1, 2, 1))
    .add(TG.sinX().frequency(0.003).color(0.5, 0, 0)));
    
    createSample(TG.texture(256, 256)
    .add(TG.sinX().frequency(0.066))
    .add(TG.sinY().frequency(0.066))
    .mul(TG.sinX().offset(32).frequency(0.044).color(2, 2, 2))
    .mul(TG.sinY().offset(16).frequency(0.044).color(2, 2, 2))
    .sub(TG.number().color(0.5, 2, 4)));
    
    createSample(TG.texture(256, 256)
    .add(TG.sinX().frequency(0.004))
    .mul(TG.sinY().frequency(0.004))
    .mul(TG.sinX().offset(32).frequency(0.02))
    .mul(TG.sinY().offset(32).frequency(0.02))
    .div(TG.sinX().frequency(0.02).color(5, 4, 3))
    .mul(TG.sinX().frequency(0.003).color(0.5, 0, 0))
    .add(TG.noise().color(0.1, 0, 0))
    .add(TG.noise().color(0, 0.1, 0))
    .add(TG.noise().color(0, 0, 0.1)));
    
    createSample(TG.texture(256, 256)
    .add(TG.checkerBoard())
    .add(TG.checkerBoard().size(2, 2).color(0.5, 0, 0))
    .add(TG.checkerBoard().size(8, 8).color(1, 0.5, 0.5))
    .sub(TG.checkerBoard().offset(16, 16).color(0.5, 0.5, 0)));
    
    createSample(TG.texture(256, 256)
    .add(TG.rect().position(50, 20).size(150, 130).color(1, 0.25, 0.25))
    .add(TG.rect().position(20, 65).size(210, 130).color(0.25, 1, 0.25))
    .add(TG.rect().position(50, 110).size(150, 130).color(0.25, 0.25, 1)));
    
    createSample(TG.texture(256, 256)
    .add(TG.checkerBoard().size(32, 32).color(0.5, 0, 0))
    .pass(TG.sineDisort()));
    
    createSample(TG.texture(256, 256)
    .add(TG.checkerBoard().size(32, 32).color(0.5, 0, 0))
    .pass(TG.twirl().radius(128).strength(75)));
    
    createSample(TG.texture(256, 256)
    .add(TG.circle().position(128, 128).radius(64)));
    
	}
  
  private function createSample(tex:Texture):Void
  {
    var bitmapData:BitmapData = tex.toBitmapData();
    var bitmap:Bitmap = new Bitmap(bitmapData);
    
    bitmap.x = (numChildren % 5) * 256;
    bitmap.y = Math.ffloor(numChildren / 5) * 256;
    addChild(bitmap);
  }
  
}
