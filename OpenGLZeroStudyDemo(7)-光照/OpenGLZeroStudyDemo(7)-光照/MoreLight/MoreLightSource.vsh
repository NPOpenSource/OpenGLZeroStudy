precision lowp float;

attribute vec3 beginPostion; ///开始位置
attribute vec2 a_texture;  //纹理贴图
attribute vec3 a_normal; //法向量

uniform mat4 u_mvpMatrix;
uniform mat4 u_model;
uniform mat4  u_inverModel;

varying lowp vec3 normal;
varying lowp vec3 FragPos;
varying lowp vec2 v_texture;

void main(){
    gl_Position =u_mvpMatrix *u_model* vec4(beginPostion, 1.0);
    FragPos = vec3(u_model * vec4(beginPostion, 1.0));
    normal =  mat3(u_inverModel) * a_normal;;
    v_texture = a_texture;
}
