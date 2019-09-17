//
//  InstanceIDViewController.m
//  OpenGLZeroStudyDemo(16)-实例化
//
//  Created by glodon on 2019/9/16.
//  Copyright © 2019 persion. All rights reserved.
//

#import "InstanceIDViewController.h"
#import "InstanceIDBindObject.h"
static float IST_quadVertices[] = {
    // 位置          // 颜色
    -0.05f,  0.05f,  1.0f, 0.0f, 0.0f,
    0.05f, -0.05f,  0.0f, 1.0f, 0.0f,
    -0.05f, -0.05f,  0.0f, 0.0f, 1.0f,
    
    -0.05f,  0.05f,  1.0f, 0.0f, 0.0f,
    0.05f, -0.05f,  0.0f, 1.0f, 0.0f,
    0.05f,  0.05f,  0.0f, 1.0f, 1.0f
};

@interface InstanceIDViewController ()
@property (nonatomic ,strong) Vertex * vertex ;
@end

@implementation InstanceIDViewController
static GLKVector2 IST_offsets[25];

-(void)initSubObject{
    [self _setUniformOffsets];
    self.bindObject = [InstanceIDBindObject new];
}


-(void)loadVertex{
    self.vertex= [Vertex new];
    int vertexNum =6;
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:5];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[5];
        for (int j=0; j<5; j++) {
            onevertex[j]=IST_quadVertices[i*5+j];
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:IST_aPos numberOfCoordinates:2 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:IST_aColor numberOfCoordinates:3 attribOffset:sizeof(float)*2];

}



-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(1, 1, 1, 1);
    for (int i=0; i<25; i++) {
        GLKVector2 translation=IST_offsets[i];
        glUniform2fv(self.bindObject->uniforms[IST_uniform_Offset+i], 1, translation.v);

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
            IST_offsets[index++] = translation;
        }
    }
}


@end
