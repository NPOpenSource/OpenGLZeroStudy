precision mediump float;

attribute vec2 a_beginPostion; ///开始位置
attribute vec3 a_color;
attribute vec2 a_offset;

varying  vec3 v_color;

void main(){
    
    gl_Position =vec4(a_beginPostion+a_offset,0.0,1.0);
    v_color  = a_color;

}
