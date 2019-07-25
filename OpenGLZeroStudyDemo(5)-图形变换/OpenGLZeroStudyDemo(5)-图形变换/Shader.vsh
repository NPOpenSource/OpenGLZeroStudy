attribute vec4 position;
attribute vec3 vertexColor;
varying  vec3  vertexColorVarying;
uniform mat4 modelMat4;
uniform mat4 eyeMat4;
uniform mat4 projectMat4;

void main (){
    vertexColorVarying = vertexColor;
    gl_Position =projectMat4 *eyeMat4 * modelMat4  *  position;
}
