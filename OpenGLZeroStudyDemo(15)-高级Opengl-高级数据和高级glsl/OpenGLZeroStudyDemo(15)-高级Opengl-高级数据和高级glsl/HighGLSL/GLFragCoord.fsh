precision mediump float;
uniform float screenWidth;

void main()
{
    if(gl_FragCoord.x < screenWidth/2.0)
        gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
    else
        gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);
}

