//
//  Divisor2ViewController.m
//  OpenGLZeroStudyDemo(16)-实例化
//
//  Created by glodon on 2019/9/16.
//  Copyright © 2019 persion. All rights reserved.
//

#import "Divisor2ViewController.h"
#import "Divisor2BindObject.h"
static float DV2_quadVertices[] = {
    // 位置          // 颜色
    -0.05f,  0.05f,  1.0f, 0.0f, 0.0f,
    0.05f, -0.05f,  0.0f, 1.0f, 0.0f,
    -0.05f, -0.05f,  0.0f, 0.0f, 1.0f,
    
    -0.05f,  0.05f,  1.0f, 0.0f, 0.0f,
    0.05f, -0.05f,  0.0f, 1.0f, 0.0f,
    0.05f,  0.05f,  0.0f, 1.0f, 1.0f
};

@interface Divisor2ViewController ()
@property (nonatomic ,strong) Vertex * vertex ;

@property (nonatomic ,strong) Vertex * Divisor2 ;
@end

@implementation Divisor2ViewController
static GLKVector2 DV2_offsets[25];

-(void)initSubObject{
    [self _setUniformOffsets];
    self.bindObject = [Divisor2BindObject new];
}


-(void)loadVertex{
    self.vertex= [Vertex new];
    int vertexNum =6;
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:5];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[5];
        for (int j=0; j<5; j++) {
            onevertex[j]=DV2_quadVertices[i*5+j];
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:DV2_aPos numberOfCoordinates:2 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:DV2_aColor numberOfCoordinates:3 attribOffset:sizeof(float)*2];

    self.Divisor2 = [Vertex new];
    vertexNum=25;
    [self.Divisor2 allocVertexNum:vertexNum andEachVertexNum:2];
    for (int i=0; i<25; i++) {
        [self.Divisor2 setVertex:DV2_offsets[i].v index:i];
    }
    [self.Divisor2 bindBufferWithUsage:GL_STATIC_DRAW];
    [self.Divisor2 enableVertexInVertexAttrib:DV2_aOffset numberOfCoordinates:2 attribOffset:0];
    [self.Divisor2 setVertexDivisor:2 divisor:1];
}



-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(1, 1, 1, 1);
    for (int i=0; i<25; i++) {
        GLKVector2 translation=DV2_offsets[i];
        glUniform2fv(self.bindObject->uniforms[DV2_uniform_Offset+i], 1, translation.v);

    }
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6 RepeatCount:25];
}

-(void)_setUniformOffsets{
    int index = 0;
    float offset = 0.2f;
    for(int y = -5; y < 5; y += 2)
    {
        for(int x = -5; x < 5; x += 2)
        {
            GLKVector2 translation;
            translation.x = (float)x / 5.0 + offset;
            translation.y = (float)y / 5.0 + offset;
            DV2_offsets[index++] = translation;
        }
    }
}


@end
