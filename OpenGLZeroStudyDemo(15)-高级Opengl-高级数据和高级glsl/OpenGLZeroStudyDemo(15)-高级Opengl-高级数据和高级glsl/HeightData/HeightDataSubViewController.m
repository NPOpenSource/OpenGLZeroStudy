//
//  HeightDataSubViewController.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "HeightDataSubViewController.h"
#import "SphereManager.h"
#import "DefaultBindObject.h"
@interface HeightDataSubViewController ()
@property (nonatomic ,strong) Vertex * heightVertex ;
@end

@implementation HeightDataSubViewController

-(void)loadVertex{
    self.heightVertex = [Vertex new];
    int vertexNum =[SphereManager getVertexNum];
    [self.heightVertex allocVertexNum:vertexNum andEachVertexNum:5];
    [self.heightVertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.heightVertex writeBufferInOffset:0 dataSize:sizeof(GL_FLOAT)* 3*vertexNum Data:[SphereManager getSphereVerts]];
    [self.heightVertex writeBufferInOffset:sizeof(GL_FLOAT)*3*vertexNum dataSize:sizeof(GL_FLOAT)*2*vertexNum Data:[SphereManager getSphereTexCoords]];
    [self.heightVertex enableVertexInVertexAttrib:DF_aPos numberOfCoordinates:3 attribOffset:0 vertexWidth:3*sizeof(GL_FLOAT)];
    [self.heightVertex enableVertexInVertexAttrib:DF_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(GL_FLOAT)*3*vertexNum vertexWidth:2*sizeof(GLfloat)];
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glClearColor(1, 1, 1, 1);
    GLKMatrix4  mvp= [self getMVP];
    static GLfloat angle=0;
    angle++;
    GLKMatrix4 mode =GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0);
    GLKMatrix4 result=  GLKMatrix4Multiply(mvp,mode);
    glUniformMatrix4fv(self.bindObject->uniforms[DF_uniform_MVPMatrix], 1, 0,result.m);
    GLKVector4 ambientLight = GLKVector4Make(1.0, 1, 1, 1.0);
    glUniform4fv(self.bindObject->uniforms[DF_uniform_AmbientLight], 1,ambientLight.v);
    [self.textureUnit0 bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DF_uniform_Samplers2D]];

    [self.heightVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[SphereManager getVertexNum]];
}


@end
