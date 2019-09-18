precision mediump float;

attribute vec3 aPos;
attribute vec3 aNormal;
attribute vec2 aTexCoords;

uniform mat4 uProjection;
uniform mat4 uView;

varying  vec3 vFragPos;
varying  vec3 vNormal;
varying  vec2 vTexCoords;

void main(){
    vFragPos=aPos;
    vNormal=aNormal;
    vTexCoords=aTexCoords;
    gl_Position = uProjection * uView * vec4(aPos, 1.0);

}
