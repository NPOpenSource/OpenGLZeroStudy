precision mediump float;

attribute vec2 beginPostion; ///开始位置
attribute vec3 color;

uniform vec2 u_offset;

varying  vec3 vary_color;

void main(){
//    int id = gl_InstanceIDEXT;
//    vec2 offset=offsets[id];
    vec2 temp =u_offset + beginPostion;
    gl_Position =vec4(temp,0.0,1.0);
    vary_color  = color;

}
//#extension GL_EXT_draw_instanced : enable
