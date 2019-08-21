
precision mediump float;//mediump
varying  vec3 vColor;

void main(){
    lowp vec4 rgba = vec4(vColor,1);
    gl_FragColor = rgba;
    
}

