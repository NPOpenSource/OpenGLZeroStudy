#extension GL_EXT_draw_instanced : enable
precision mediump float;

attribute vec2 a_beginPostion; ///开始位置
attribute vec3 a_color;

uniform vec2 u_offsets[25];
varying  vec3 v_color;

void main(){
    int id = gl_InstanceIDEXT;
    vec2 offset=u_offsets[id];
    vec2 temp =offset + a_beginPostion;
    gl_Position =vec4(temp,0.0,1.0);
    v_color  = a_color;

}
