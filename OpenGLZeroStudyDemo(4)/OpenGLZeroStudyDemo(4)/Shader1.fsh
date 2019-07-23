
precision mediump float;//mediump
varying  vec2 texCoordVarying;
uniform sampler2D sam2DR; //location = 0
void main(){
    lowp vec4 rgba = vec4(0,0,0,1);
    rgba = texture2D(sam2DR,texCoordVarying);
    gl_FragColor = rgba;
    
}

