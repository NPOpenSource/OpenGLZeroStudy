
precision mediump float;//mediump
varying  vec3 vertexColorVarying;

void main(){
    lowp vec4 rgba = vec4(vertexColorVarying.r,vertexColorVarying.g,vertexColorVarying.b,1);
    gl_FragColor = rgba;
    
}

