precision mediump float;

attribute vec3 aPos;
attribute vec2 aTexCoords;


varying  vec2 vTexCoords;


void main(){
    vTexCoords = aTexCoords;
    gl_Position = vec4(aPos, 1.0);
}
