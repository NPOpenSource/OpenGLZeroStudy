//
//  VertexOneDimViewController.m
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/11.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "VertexOneDimViewController.h"

@interface VertexOneDimViewController ()

@end

@implementation VertexOneDimViewController

#define VertexNum 3
-(void)loadVertex{
    self.vertex = [Vertex new];
    [self.vertex allocVertexNum:VertexNum andEachVertexNum:1];
    GLfloat vertex[1];
    vertex[0]=1.0;
    [self.vertex setVertex:vertex index:0];
    vertex[0]=0;
    [self.vertex setVertex:vertex index:1];
    vertex[0]=-1.0;
    [self.vertex setVertex:vertex index:2];
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:GLKVertexAttribPosition numberOfCoordinates:1 attribOffset:0];
    
}
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    static NSInteger count = 0;
    // 清除颜色缓冲区
    glClearColor(1,1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    count ++;
    if (count > 50 ) {
        count = 0;
        // 根据颜色索引值,设置颜色数据，就是刚才我们从着色器程序中获取的颜色索引值
        glUniform4f(self.vertexcolor,   arc4random_uniform(255)/225.0, arc4random_uniform(255)/225.0, arc4random_uniform(255)/225.0, 1);
    }
    // 使用着色器程序
    glUseProgram(self.shader.program);
    // 绘制
    [self.vertex drawVertexWithMode:GL_LINE_LOOP startVertexIndex:0 numberOfVertices:VertexNum];
}


@end
