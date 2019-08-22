precision mediump float;
varying vec2 vTexCoords;
uniform sampler2D uTexture;

void main()
{
    vec4 textureColor = texture2D(uTexture, vTexCoords);
    gl_FragColor =  vec4(0.04, 0.28, 0.26, 1.0);;
}
