precision mediump float;
varying  vec3 vary_color;

void main()
{
    gl_FragColor = vec4(vary_color,1.0);
}
