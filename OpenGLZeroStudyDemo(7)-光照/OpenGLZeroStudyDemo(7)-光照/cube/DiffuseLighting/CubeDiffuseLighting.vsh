attribute vec3 beginPostion; ///开始位置
attribute vec3 vertexColor;
attribute vec3 aNormal; //法向量

uniform mat4 u_mvpMatrix;
uniform mat4 u_model;
uniform mat4  u_inverModel;

varying lowp vec3 normal;
varying lowp vec3 FragPos;


varying lowp vec3 vary_vertexColor;

void main(){
    gl_Position =u_mvpMatrix *u_model* vec4(beginPostion, 1.0);
    vary_vertexColor  = vertexColor;
    FragPos = vec3(u_model * vec4(beginPostion, 1.0));
    normal =  mat3(u_inverModel) * aNormal;;
}
