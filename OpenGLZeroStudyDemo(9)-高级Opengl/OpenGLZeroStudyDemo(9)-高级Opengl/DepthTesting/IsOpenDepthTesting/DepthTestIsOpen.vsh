attribute vec3 aPos;
attribute vec3 aColor;
varying  vec3  vColor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;


void main (){
    vColor = aColor;
    gl_Position = projection * view * model * vec4(aPos, 1.0);
}
