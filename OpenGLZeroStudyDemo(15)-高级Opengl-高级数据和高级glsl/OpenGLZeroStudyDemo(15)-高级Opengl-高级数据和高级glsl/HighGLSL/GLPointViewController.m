//
//  GLPointViewController.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLPointViewController.h"
#import "GLPointBindObject.h"
@interface GLPointViewController ()
@property (nonatomic ,strong) Vertex * vertex ;

@end

@implementation GLPointViewController

-(void)initSubObject{
    self.bindObject = [GLPointBindObject new];
}


-(void)loadVertex{
    self.vertex= [Vertex new];
    int vertexNum =1;
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:3];
    float onevertex[3];
    for (int i=0; i<3; i++) {
        onevertex[i]=0;
    }
    [self.vertex setVertex:onevertex index:0];
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:PT_aPos numberOfCoordinates:3 attribOffset:0];
}

-(GLKMatrix4)getMVP{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              20.0f);
    GLKMatrix4 modelviewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    return GLKMatrix4Multiply(projectionMatrix,modelviewMatrix);
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(1, 1, 1, 1);
    GLKMatrix4  mvp= [self getMVP];
    static GLfloat width = 2;
    static GLfloat angle=0;
    angle+=0.1;
    GLfloat z = width* sin(angle);
    GLKMatrix4 mode =GLKMatrix4Translate(mvp, 0, 0, z);
    GLKMatrix4 result=  GLKMatrix4Multiply(mvp,mode);
    glUniformMatrix4fv(self.bindObject->uniforms[PT_uniform_MVPMatrix], 1, 0,result.m);
    [self.vertex drawVertexWithMode:GL_POINTS startVertexIndex:0 numberOfVertices:1];
    
}


@end
