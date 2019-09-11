precision mediump float;
attribute vec3 aPos;
//attribute vec3 aNormal;
varying vec3 vTexCoords;

uniform mat4 view;
uniform mat4 projection;

void main()
{
    vTexCoords = aPos;
    mat4 tempview= mat4(mat3(view));
    vec4 pos = projection * tempview  * vec4(aPos, 1.0);
    gl_Position =  pos.xyww;
}
