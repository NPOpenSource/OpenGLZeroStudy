
precision mediump float;//mediump
varying  vec2 texCoordVarying;
uniform sampler2D sam2DR; //location = 0
uniform sampler2D sam2D; //location = 1
void main(){
    lowp vec4 rgba = vec4(0,0,0,1);
    rgba = mix(texture2D(sam2DR,texCoordVarying),texture2D(sam2D,texCoordVarying),0.8);
    gl_FragColor = rgba;
    
}

