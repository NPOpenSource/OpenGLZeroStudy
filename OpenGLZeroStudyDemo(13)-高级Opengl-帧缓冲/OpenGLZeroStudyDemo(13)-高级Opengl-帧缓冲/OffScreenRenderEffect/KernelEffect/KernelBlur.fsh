precision mediump float;
varying vec2 vTexCoords;
uniform sampler2D uTexture;

const float offset = 1.0 / 300.0;

void main()
{
    vec3  textureColor = texture2D(uTexture, vTexCoords).rgb;
    vec2 offsets[9];
    offsets[0] = vec2(-offset,  offset); // 左上
    offsets[1] = vec2( 0.0,    offset); // 正上
    offsets[2] = vec2( offset,  offset); // 右上
    offsets[3] = vec2(-offset,  0.0);   // 左
    offsets[4] = vec2( 0.0,    0.0);  // 中
    offsets[5] = vec2( offset,  0.0);   // 右
    offsets[6] = vec2(-offset, -offset);// 左下
    offsets[7] = vec2( 0.0,   -offset); // 正下
    offsets[8] = vec2( offset, -offset) ; // 右下
    
    
    float kernel[9];
    kernel[0]=1.0;
    kernel[1]=2.0;
    kernel[2]=1.0;
    kernel[3]=2.0;
    kernel[4]=4.0;
    kernel[5]=2.0;
    kernel[6]=1.0;
    kernel[7]=2.0;
    kernel[8]=1.0;
    for(int i = 0; i < 9; i++)
    {
        kernel[i]=kernel[i]/16.0;
    }
    vec3 sampleTex[9];
    for(int i = 0; i < 9; i++)
    {
        sampleTex[i] = vec3(texture2D(uTexture, vTexCoords.st + offsets[i]));
    }
    vec3 col = vec3(0.0);
    for(int i = 0; i < 9; i++)
        col += sampleTex[i] * kernel[i];
    
    gl_FragColor = vec4(col, 1.0);
      
}

