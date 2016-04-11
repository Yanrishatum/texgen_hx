package;
import com.texgen.Color;
import com.texgen.ColorInterpolatorMethod;
import com.texgen.RepeatMethod;
import com.texgen.TG;
import com.texgen.Texture;

/**
 * ...
 * @author Yanrishatum
 */
class MainExamples extends ExamplePage
{

  public function new() 
  {
    super();
    var size:Int = 128;
    
    createSample(TG.texture( size, size )
      .add( TG.xor().tint( 1, 0.5, 0.7 ) )
      .add( TG.sinX().frequency( 0.004 ).tint( 0.25, 0, 0 ) )
      .sub( TG.sinY().frequency( 0.004 ).tint( 0.25, 0, 0 ) )
      .add( TG.sinX().frequency( 0.0065 ).tint( 0.1, 0.5, 0.2 ) )
      .add( TG.sinY().frequency( 0.0065 ).tint( 0, 0.4, 0.5 ) )
      .add( TG.noise().tint( 0.1, 0.1, 0.2 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.sinX().offset( - 16 ).frequency( 0.03 ).tint( 0.1, 0.25, 0.5 ) )
      .add( TG.sinY().offset( - 16 ).frequency( 0.03 ).tint( 0.1, 0.25, 0.5 ) )
      .add( TG.number().tint( 0.75, 0.5, 0.5 ) )
      .add( TG.sinX().frequency( 0.03 ).tint( 0.2, 0.2, 0.2 ) )
      .add( TG.sinY().frequency( 0.03 ).tint( 0.2, 0.2, 0.2 ) )
      .add( TG.noise().tint( 0.1, 0, 0 ) )
      .add( TG.noise().tint( 0, 0.1, 0 ) )
      .add( TG.noise().tint( 0, 0, 0.1 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.sinX().frequency( 0.1 ) )
      .mul( TG.sinX().frequency( 0.05 ) )
      .mul( TG.sinX().frequency( 0.025 ) )
      .mul( TG.sinY().frequency( 0.1 ) )
      .mul( TG.sinY().frequency( 0.05 ) )
      .mul( TG.sinY().frequency( 0.025 ) )
      .add( TG.sinX().frequency( 0.004 ).tint( -0.25, 0.1, 0.6 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.xor() )
      .mul( TG.or().tint( 0.5, 0.8, 0.5 ) )
      .mul( TG.sinX().frequency( 0.0312 ) )
      .div( TG.sinY().frequency( 0.0312 ) )
      .add( TG.sinX().frequency( 0.004 ).tint( 0.5, 0, 0 ) )
      .add( TG.noise().tint( 0.1, 0.1, 0.2 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.sinX().frequency( 0.01 ) )
      .mul( TG.sinY().frequency( 0.0075 ) )
      .add( TG.sinX().frequency( 0.0225 ) )
      .mul( TG.sinY().frequency( 0.015 ) )
      .add( TG.noise().tint( 0.1, 0.1, 0.3 ) ));

    newLine();
    //
    createSample(TG.texture( size, size )
      .add( TG.sinX().frequency( 0.05 ) )
      .mul( TG.sinX().frequency( 0.08 ) )
      .add( TG.sinY().frequency( 0.05 ) )
      .mul( TG.sinY().frequency( 0.08 ) )
      .div( TG.number().tint( 1, 2, 1 ) )
      .add( TG.sinX().frequency( 0.003 ).tint( 0.5, 0, 0 ) ));
    
    
    //
    createSample(TG.texture( size, size )
      .add( TG.sinX().frequency( 0.066 ) )
      .add( TG.sinY().frequency( 0.066 ) )
      .mul( TG.sinX().offset( 32 ).frequency( 0.044 ).tint( 2, 2, 2 ) )
      .mul( TG.sinY().offset( 16 ).frequency( 0.044 ).tint( 2, 2, 2 ) )
      .sub( TG.number().tint( 0.5, 2, 4 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.sinX().frequency( 0.004 ) )
      .mul( TG.sinY().frequency( 0.004 ) )
      .mul( TG.sinY().offset( 32 ).frequency( 0.02 ) )
      .div( TG.sinX().frequency( 0.02 ).tint( 8, 5, 4 ) )
      .add( TG.noise().tint( 0.1, 0, 0 ) )
      .add( TG.noise().tint( 0, 0.1, 0 ) )
      .add( TG.noise().tint( 0, 0, 0.1 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.checkerBoard() )
      .add( TG.checkerBoard().size( 2, 2 ).tint( 0.5, 0, 0 ) )
      .add( TG.checkerBoard().size( 8, 8 ).tint( 1, 0.5, 0.5 ) )
      .sub( TG.checkerBoard().offset( 16, 16 ).tint( 0.5, 0.5, 0 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.rect().position( size / 4.8, size / 12  ).size( size / 1.7 , size / 2 ).tint( 1, 0.25, 0.25 ) )
      .add( TG.rect().position( size / 12,  size / 4   ).size( size / 1.21, size / 2 ).tint( 0.25, 1, 0.25 ) )
      .add( TG.rect().position( size / 4.8, size / 2.5 ).size( size / 1.7 , size / 2 ).tint( 0.25, 0.25, 1 ) ));

    newLine();
    //
    createSample(TG.texture( size, size )
      .add( TG.checkerBoard().size( 32, 32 ).tint( 0.5, 0, 0 ) )
      .set( TG.sineDistort() ));

    //
    createSample(TG.texture( size, size )
    .add( TG.checkerBoard().size( 32, 32 ).tint( 0.5, 0, 0 ) )
    .set( TG.twirl().radius( size/2 ).position(size / 2, size / 2).strength ( 75 ) ));

    //
    createSample(TG.texture( size, size )
    .add( TG.circle().position( size/2, size/2 ).radius( size/4 ) ));

    //
    createSample(TG.texture( size, size )
    .add( TG.circle().position( size/2, size/2).radius( size/4 ).delta( size / 4 ).tint( 1, 0.25, 0.25 ) )
    .set( TG.pixelate().size( size / 32, size / 32 ) ));

    //
    createSample(TG.texture( size, size )
      .add( TG.checkerBoard().tint( 1, 1, 0 ) )
      .set( TG.transform().offset( 10, 20 ).angle( 23 ).scale( 2, 0.5 ) ));

    newLine();
    //
    createSample(TG.texture( size, size )
      .add( TG.checkerBoard() )
      .and( TG.circle().position( size / 2, size / 2 ).radius( size / 3 ) )
      .xor( TG.circle().position( size / 2, size / 2 ).radius( size / 4 ) ));
    
    //
    var vignette:Texture = TG.texture( size, size )        // predefine a vignette-effect so it can be used later
      .set( TG.circle().radius( size ).position( size / 2, size / 2 ).delta( size * 0.7 ) );
    
    var numSamples = 6+1;        // more samples = heavier effect

    var base = TG.texture( size, size )        // generating an image to be blurred
      .set( TG.fractalNoise().amplitude( 0.46 ).persistence( 0.78 ).interpolation( ColorInterpolatorMethod.Step ) )
      .set( TG.normalize() );

    var blur = TG.texture( size, size );        // the texture the samples are put onto

    for (i in 0...numSamples)
    {
      var sample = TG.texture( size, size )
        .set( TG.putTexture( base ) )         // copy the base texture, so that it doesn't get modified
        .set( TG.transform().scale( 1 + 0.01 * i, 1 + 0.01 * i ).angle( 0.5 * i ) );        // modify the texture a bit more with each sample

      blur.add( TG.putTexture( sample ) );        // adding the transformed sample to the result
    }

    blur.set( TG.normalize() )        // since the samples are not weighted, put everything in the visible range
      .mul( TG.putTexture( vignette ) );        // adding the predefined vignette-effect
    
    //createSample(base);
    createSample(blur);
    
    //
    
    var subDim = Math.floor( size / 4 );        // generate a smaller image so it can be mirrored later

    var pixel = TG.texture( subDim, subDim )
      .set( TG.fractalNoise().baseFrequency( subDim / 15 ).octaves( 1 ).amplitude( 1 ) )        // generating a noise pattern with 15 pixels per length
      .set( TG.gradientMap().interpolation( ColorInterpolatorMethod.Step )        // divide the generated values into defined colors
        .point( 0, new Color(250, 230, 210) )        //[ 251, 255, 228 ] (alternative colors)
        .point( 0.2, new Color(255, 92, 103) )        //[ 130, 198, 184 ]
        .point( 0.4, new Color(200, 15, 17) )        //[ 42, 166, 137 ]
        .point( 0.6, new Color(140, 49, 59) )        //[ 58, 131, 114 ]
        .point( 0.8, new Color(35, 10, 12) )        //[ 4, 46, 27 ]
        .point( 1, new Color(0, 0, 0) ) )
      .div( TG.number().tint( 255, 255, 255 ) );        // converting the 0-255 defined colors to the 0-1 space

    var mirrored = TG.texture( size, size )
      .add( TG.putTexture( pixel ).repeat( RepeatMethod.Mirror ) )        // repeat the texture to get a cool mirrored pattern effect
      .mul( TG.putTexture( vignette ).tint( 1.2, 1.2, 1.2 ) );        // adding the vignette from the example above
    
    createSample(mirrored);
  }
  
}