//
//  OneObjectMoveViewController.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectMoveViewController.h"
#import "OneObjectMoveBindObject.h"

@interface OneObjectMoveViewController ()
@property (nonatomic ,assign) float timeInterval ;
@end

@implementation OneObjectMoveViewController
-(void)initSubObject{
    __weakSelf
    self.bindObject = [OneObjectMoveBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
         weakSelf.bindObject->uniforms[OneObjectMoveUniformLocationTimeInterval] =  glGetUniformLocation(program, "timeInterval");
    };
    
}

-(void)loadVertex{
    self.vertex = [Vertex new];
    int vertexWidth = sizeof(OneObjectMoveBindAttrib)/sizeof(float);
    [self.vertex allocVertexNum:1 andEachVertexNum:vertexWidth];
    OneObjectMoveBindAttrib oneVertex;
    oneVertex.baseBindAttrib.beginPosition = GLKVector3Make(0, 0, 0);
    oneVertex.baseBindAttrib.p_diameter = 140;
    oneVertex.beginVelocity = GLKVector3Make(0, 1, 0);
    [self.vertex setVertex:oneVertex.t index:0];
    
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:sizeof(oneVertex.baseBindAttrib.beginPosition)/sizeof(float) attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:p_diameter numberOfCoordinates:sizeof(oneVertex.baseBindAttrib.p_diameter)/sizeof(float) attribOffset:sizeof(oneVertex.baseBindAttrib.beginPosition)];
     [self.vertex enableVertexInVertexAttrib:OneObjectMoveBindAttribLocationBeginVelocity numberOfCoordinates:sizeof(oneVertex.beginVelocity)/sizeof(float) attribOffset:sizeof(oneVertex.baseBindAttrib)];
}



-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    self.timeInterval +=0.01;
    glUniform1f(self.bindObject->uniforms[OneObjectMoveUniformLocationTimeInterval] ,_timeInterval);
    [self.vertex drawVertexWithMode:GL_POINTS startVertexIndex:0 numberOfVertices:1];
}

@end
