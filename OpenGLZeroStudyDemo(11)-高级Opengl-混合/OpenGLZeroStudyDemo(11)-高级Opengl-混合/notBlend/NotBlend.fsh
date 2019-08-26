precision mediump float;
varying vec2 vTexCoords;
uniform sampler2D uTexture;

void main()
{
    vec4 textureColor = texture2D(uTexture, vTexCoords);
    if(textureColor.a < 0.1)
        discard;
    gl_FragColor = textureColor;
}

