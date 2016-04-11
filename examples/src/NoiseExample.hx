package;
import com.texgen.ColorInterpolatorMethod;
import com.texgen.TG;
import com.texgen.Texture;
import haxe.Timer;

/**
 * ...
 * @author Yanrishatum
 */
class NoiseExample extends ExamplePage
{

  public function new() 
  {
    super();
    
    var seed:Int = Std.int(Timer.stamp());
    
    //---------------------------------------------------------
    createSample(TG.texture(200, 200)
      .set(TG.fractalNoise().seed(seed).baseFrequency(20).octaves(1).amplitude(0.5)),
      "Base Frequency");
    
    createSample(TG.texture(200, 200)
      .set(TG.fractalNoise().seed(seed * 2).baseFrequency(10).octaves(1).amplitude(0.25)),
      "+ Octave");
    
    createSample(TG.texture(200, 200)
      .set(TG.fractalNoise().seed(seed * 3).baseFrequency(5).octaves(1).amplitude(0.125)),
      "+ Octave");
    
    createSample(TG.texture(200, 200)
      .set(TG.fractalNoise().seed(seed).baseFrequency(20).octaves(3).step(2).amplitude(0.5).persistence(0.5)),
      "= Fractal Noise");
    
    newLine();
    
    var amp:Array<Float> = [0.32, 0.42, 0.32, 0.42];
    var prs:Array<Float> = [0.78, 0.78, 0.68, 0.68];
    
    for (i in 0...4)
    {
      createSample(TG.texture(200, 200)
        .set(TG.fractalNoise().seed(seed).baseFrequency(200).octaves(8).step(2).amplitude(amp[i]).persistence(prs[i])),
        "No interpolation\nAmplitude: " + amp[i] + "\nPersistence: " + prs[i]);
    }
    
    newLine();
    
    for (i in 0...4)
    {
      createSample(TG.texture(200, 200)
        .set(TG.fractalNoise().seed(seed).baseFrequency(200).octaves(8).step(2).amplitude(amp[i]).persistence(prs[i]).interpolation(ColorInterpolatorMethod.Linear)),
        "Linear Interpolation\nAmplitude: " + amp[i] + "\nPersistence: " + prs[i]);
    }
    
    newLine();
    
    for (i in 0...4)
    {
      createSample(TG.texture(200, 200)
        .set(TG.fractalNoise().seed(seed).baseFrequency(200).octaves(8).step(2).amplitude(amp[i]).persistence(prs[i]).interpolation(ColorInterpolatorMethod.Spline)),
        "Spline Interpolation\nAmplitude: " + amp[i] + "\nPersistence: " + prs[i]);
    }
    
  }
  
}