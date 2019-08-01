
uniform sampler2D       u_samplers2D[1];
void main()
{
    lowp vec4 textureColor = texture2D(u_samplers2D[0],gl_PointCoord);
    gl_FragColor = textureColor;
}
