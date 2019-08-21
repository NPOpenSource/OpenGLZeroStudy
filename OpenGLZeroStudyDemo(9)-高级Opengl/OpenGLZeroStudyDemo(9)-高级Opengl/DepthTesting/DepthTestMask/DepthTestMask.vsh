attribute vec3 aPos;
attribute vec2 aTexture;
varying  vec2  vTexture;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;


void main (){
    vTexture = aTexture;
    gl_Position = projection * view * model * vec4(aPos, 1.0);
}
