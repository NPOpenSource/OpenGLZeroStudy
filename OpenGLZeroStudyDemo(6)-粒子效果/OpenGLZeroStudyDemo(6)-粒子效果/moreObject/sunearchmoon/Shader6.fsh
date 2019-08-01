
uniform sampler2D       u_samplers2D[1];
varying lowp vec2      vary_texture;

void main()
{
    lowp vec4 textureColor = texture2D(u_samplers2D[0],vary_texture);
    gl_FragColor = textureColor;
}
