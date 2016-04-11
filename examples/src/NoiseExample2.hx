package;
import com.texgen.ColorInterpolatorMethod;
import com.texgen.TG;
import haxe.Timer;

/**
 * ...
 * @author Yanrishatum
 */
class NoiseExample2 extends ExamplePage
{

  public function new() 
  {
    super();
    var seed:Int = Std.int(Timer.stamp());
    
    createSample(TG.texture(25, 25)
      .set(TG.fractalNoise().seed(seed).baseFrequency(200).octaves(8).step(2)),
      "25px ->");
    
    createSample(TG.texture(50, 50)
      .set(TG.fractalNoise().seed(seed).baseFrequency(200).octaves(8).step(2))
      .add(TG.rect().size(0, 25).position(25, 0).tint(10, -10, -10))
      .add(TG.rect().size(25, 0).position(0, 25).tint(10, -10, -10)),
      "50px ->");
    
    createSample(TG.texture(100, 100)
      .set(TG.fractalNoise().seed(seed).baseFrequency(200).octaves(8).step(2))
      .add(TG.rect().size(0, 50).position(50, 0).tint(10, -10, -10))
      .add(TG.rect().size(50, 0).position(0, 50).tint(10, -10, -10)),
      "100px ->");
      
    createSample(TG.texture(200, 200)
      .set(TG.fractalNoise().seed(seed).baseFrequency(200).octaves(8).step(2))
      .add(TG.rect().size(0, 100).position(100, 0).tint(10, -10, -10))
      .add(TG.rect().size(100, 0).position(0, 100).tint(10, -10, -10)),
      "200px\n(width and height independent)");
    
    var size:Int = 256;
    
    createSample(TG.texture(size, size)
      .set(TG.fractalNoise().baseFrequency(20).persistence(0.75).amplitude(0.4).interpolation(ColorInterpolatorMethod.Spline).tint(0.75, 0.95, 1))
      .add(TG.fractalNoise().baseFrequency(4).octaves(3).interpolation(ColorInterpolatorMethod.Linear).tint(0.25, 0.35, 0.85))
      .sub(TG.twirl().radius(size * 3).strength(1.5).position(size / 2, size / 2))
      .mul(TG.circle().radius(size * 1.1).position(size / 2, size / 2).delta(size)),
      "Example 1");
    createSample(TG.texture(size, size)
      .set(TG.fractalNoise().baseFrequency(20).persistence(0.75).amplitude(0.4).interpolation(ColorInterpolatorMethod.Step).tint(0.75, 0.95, 1))
      .add(TG.fractalNoise().baseFrequency(4).octaves(3).interpolation(ColorInterpolatorMethod.Step).tint(0.25, 0.35, 0.85))
      .sub(TG.twirl().radius(size * 3).strength(1.5).position(size / 2, size / 2))
      .mul(TG.circle().radius(size * 1.1).position(size / 2, size / 2).delta(size)),
      "Example 1 (no interpolation)");
    
    newLine();
    
    createSample(TG.texture(100, 100).set(TG.noise().seed(seed)), "100px ->");
    createSample(TG.texture(200, 200).set(TG.noise().seed(seed))
      .add(TG.rect().size(0, 100).position(100, 0).tint(10, -10, -10))
      .add(TG.rect().size(100, 0).position(0, 100).tint(10, -10, -10)),
      "200px\n(also works with regular noise)");
    
    //newLine();
    
		///---------------------------------------------------------
    
    createSample(TG.texture(size, size)
      .set(TG.fractalNoise().baseFrequency(64).octaves(6).step(2).interpolation(ColorInterpolatorMethod.Spline))
      .sub(TG.noise().tint(0, 0.1, 0))
      .min(TG.number().tint(0, 0.6, 0))
      .sub(TG.number().tint(0, 0.5, 0))
      .mul(TG.number().tint(0, 5, 0))
      .sub(TG.sineDistort().sines(2, 2).amplitude(8, 8).tint(0, 0.75, 0))
      .add(TG.number().tint(0.06, 0, 0.085)),
      "Example 2");
    
    createSample(TG.texture(size, size)
      .set(TG.fractalNoise().baseFrequency(128).octaves(6).step(2).interpolation(ColorInterpolatorMethod.Spline))
      .sub(TG.noise().tint(0, 0.1, 0))
      .min(TG.number().tint(0, 0.63, 0))
      .sub(TG.number().tint(0, 0.53, 0))
      .mul(TG.number().tint(0, 6, 0))
      .sub(TG.sineDistort().sines(2, 2).amplitude(4, 4).tint(0, 0.75, 0))
      .add(TG.number().tint(0.065, 0, 0.095)),
      "Example 2 (less distortion)");
    
    newLine();
    
    createSample(TG.texture(size, size)
      .set(TG.fractalNoise().baseFrequency(64).octaves(6).step(2).interpolation(ColorInterpolatorMethod.Spline).tint(1, 0.17, 0.32))
      .sub(TG.noise().tint(0.2, 0.08, 0.03))
      .mul(TG.xor().tint(1.5, 1.62, 1.69)),
      "Example 3 (xor)");
    createSample(TG.texture(size, size)
      .set(TG.fractalNoise().baseFrequency(64).octaves(6).step(2).interpolation(ColorInterpolatorMethod.Spline).tint(1, 0.17, 0.32))
      .sub(TG.noise().tint(0.2, 0.08, 0.03))
      .mul(TG.fractalNoise().octaves(2).baseFrequency(size / 4).step(1.7).interpolation(ColorInterpolatorMethod.Step).amplitude(0.6).persistence(0.6).tint(1.5, 1.62, 1.69)),
      "Example 3 (noise)");
				//new TG.Texture(size, size)
					//.set(new TG.FractalNoise().baseFrequency(64).octaves(6).step(2).interpolation(2).tint(1, 0.17, 0.32) )
					//.sub(new TG.Noise().tint(0.2, 0.08, 0.03) )
					//.mul(new TG.XOR().tint(1.5, 1.62, 1.69) )
					//.addToPage("Example 3 (xor)");
				//new TG.Texture(size, size)
					//.set(new TG.FractalNoise().baseFrequency(64).octaves(6).step(2).interpolation(2).tint(1, 0.17, 0.32) )
					//.sub(new TG.Noise().tint(0.2, 0.08, 0.03) )
					//.mul(new TG.FractalNoise().octaves(2).baseFrequency(size/4).step(1.7).interpolation(0).amplitude(0.6).persistence(0.6).tint(1.5, 1.62, 1.69) )
					//.addToPage("Example 3 (noise)");
				//pageStatus.innerHTML = "Seed: " + seed;
  }
  
}