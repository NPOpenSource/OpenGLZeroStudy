precision mediump float;
varying vec2 vTexCoords;
uniform sampler2D uTexture;

const float offset = 1.0 / 300.0;

void main()
{
    vec3  textureColor = texture2D(uTexture, vTexCoords).rgb;
    //      float average = (textureColor.r + textureColor.g + textureColor.b) / 3.0;
    //    gl_FragColor = vec4(average,average,average,1.0);
    
    float average = 0.2126 * textureColor.r + 0.7152 * textureColor.g + 0.0722 * textureColor.b;
}

