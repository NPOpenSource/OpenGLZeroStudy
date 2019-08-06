precision lowp float;

varying lowp vec3 vary_vertexColor;

void main()
{
    gl_FragColor =vec4( vary_vertexColor,1.0);
}
