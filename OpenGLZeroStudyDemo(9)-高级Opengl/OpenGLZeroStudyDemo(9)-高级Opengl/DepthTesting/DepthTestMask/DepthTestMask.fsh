
precision mediump float;//mediump
uniform sampler2D sam2D;
varying  vec2 vTexture;

void main(){
    lowp vec4 rgba = texture2D(sam2D,vTexture);
    gl_FragColor = rgba;
    
}

