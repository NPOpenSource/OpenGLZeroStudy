//
//  HeightDataViewController.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "HeightDataViewController.h"
#import "SphereManager.h"
#import "DefaultBindObject.h"

@interface HeightDataViewController ()

@end

@implementation HeightDataViewController

-(void)loadVertex{

    self.vertexPostion= [Vertex new];
    int vertexNum =[SphereManager getVertexNum];
    [self.vertexPostion allocVertexNum:vertexNum andEachVertexNum:3];
    [self.vertexPostion bindBufferWithUsage:GL_STATIC_DRAW];

    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[SphereManager getSphereVerts][i*3+j];
        }
        [self.vertexPostion setVertex:onevertex index:i];
    }
    [self.vertexPostion writeBufferData];
    [self.vertexPostion enableVertexInVertexAttrib:DF_aPos numberOfCoordinates:3 attribOffset:0];
    
    self.vertexTexture = [Vertex new];
    [self.vertexTexture allocVertexNum:vertexNum andEachVertexNum:2];
    [self.vertexTexture bindBufferWithUsage:GL_STATIC_DRAW];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[2];
        for (int j=0; j<2; j++) {
            onevertex[j]=[SphereManager getSphereTexCoords][i*2+j];
        }
        [self.vertexTexture setVertex:onevertex index:i];
    }
    [self.vertexTexture writeBufferData];
    [self.vertexTexture enableVertexInVertexAttrib:DF_aTexCoords numberOfCoordinates:2 attribOffset:0];
}

@end
