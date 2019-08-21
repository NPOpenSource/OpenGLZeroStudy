//
//  DepthTestIsOpenViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestIsOpenViewController.h"
#import "DepthTestIsOpenBindObject.h"
#import "CubeManager.h"

@interface DepthTestIsOpenViewController ()
@property (nonatomic ,strong) Vertex * vertex;
@property (nonatomic ,strong) VertexElement * vertexElement ;

@end

@implementation DepthTestIsOpenViewController
-(void)initSubObject{
    self.bindObject = [DepthTestIsOpenBindObject new];
    self.glDrawConfig = ^{
        glClear(GL_COLOR_BUFFER_BIT);
    };
}

-(void)loadVertex{
    self.vertex= [Vertex new];
    int vertexNum =[CubeManager getVertexNum];
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:6];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[6];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getCubeVerts][i*3+j];
        }
        for (int j=0; j<3; j++) {
            onevertex[j+3]=[CubeManager cubeColors][i*3+j];
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:DTIO_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:DTIO_aColor numberOfCoordinates:3 attribOffset:sizeof(float)*3];

    self.vertexElement = [VertexElement new];
    [self.vertexElement allocWithIndexNum:[CubeManager getVertexElementsNum] indexArr:[CubeManager getVertexElements]];    
}



-(void)createTextureUnit{
   
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(1.0,1.0,1.0, 1);
    self.glDrawConfig();
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(self.bindObject->uniforms[DTIO_uniform_view], 1, 0,viewMatrix.m);
    
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(self.bindObject->uniforms[DTIO_uniform_projection], 1, 0,projectionMatrix.m);
    
    GLKMatrix4 mode = GLKMatrix4Identity;
    static GLfloat angle=30;
    angle +=3;
    mode =  GLKMatrix4Rotate(mode,angle*M_PI/180, 0, 1, 0);

    glUniformMatrix4fv(self.bindObject->uniforms[DTIO_uniform_model], 1, 0,mode.m);
    [self.vertexElement drawElementIndexWithMode:GL_TRIANGLES];

}


@end
