attribute vec4 position; // 属性，如果绑定了这个属性，
uniform  vec4 color; // 需要从程序中传入的值，一会我们会不断改变这个值
varying lowp vec4 colorVarying; // 这个值需要和片段着色器的声明相同

void main()
{
    gl_Position = position; // 设置顶点位置
    colorVarying = color;  // 设置顶点颜色
}

