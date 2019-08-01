//
//  OneObjectViewController.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectViewController.h"
#import "OneObjectBindObject.h"

@interface OneObjectViewController ()

@end

@implementation OneObjectViewController
-(void)initSubObject{
    self.bindObject = [OneObjectBindObject new];
}
-(void)loadVertex{
    self.vertex = [Vertex new];
    int vertexWidth = sizeof(BaseBindAttribType)/sizeof(float);
    [self.vertex allocVertexNum:1 andEachVertexNum:vertexWidth];
    BaseBindAttribType oneVertex;
    oneVertex.beginPosition = GLKVector3Make(0, 0, 0);
    oneVertex.p_diameter = 140;
    for (int i=0; i<vertexWidth; i++) {
        [self.vertex setVertex:oneVertex.t index:0];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:sizeof(oneVertex.beginPosition)/sizeof(float) attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:p_diameter numberOfCoordinates:1 attribOffset:sizeof(oneVertex.beginPosition)];
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    [self.vertex drawVertexWithMode:GL_POINTS startVertexIndex:0 numberOfVertices:1];
}

@end
