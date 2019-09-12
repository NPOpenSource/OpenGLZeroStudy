//
//  DefaultViewController.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DefaultViewController.h"
#import "DefaultBindObject.h"
#import "SphereManager.h"
@interface DefaultViewController ()

@end

@implementation DefaultViewController

-(void)initSubObject{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    self.bindObject = [DefaultBindObject new];
}


-(void)loadVertex{
    self.vertexPostion= [Vertex new];
    int vertexNum =[SphereManager getVertexNum];
    [self.vertexPostion allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[SphereManager getSphereVerts][i*3+j];
        }
        [self.vertexPostion setVertex:onevertex index:i];
    }
    [self.vertexPostion bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexPostion enableVertexInVertexAttrib:DF_aPos numberOfCoordinates:3 attribOffset:0];
    
    self.vertexTexture = [Vertex new];
    [self.vertexTexture allocVertexNum:vertexNum andEachVertexNum:2];
    
    for (int i=0; i<vertexNum; i++) {
        float onevertex[2];
        for (int j=0; j<2; j++) {
            onevertex[j]=[SphereManager getSphereTexCoords][i*2+j];
        }
        [self.vertexTexture setVertex:onevertex index:i];
    }
    [self.vertexTexture bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexTexture enableVertexInVertexAttrib:DF_aTexCoords numberOfCoordinates:2 attribOffset:0];
}


-(void)createTextureUnit{
    UIImage *  image = [UIImage imageNamed:@"Earth512x256.jpg"];
    self.textureUnit0 = [TextureUnit new];
    [self.textureUnit0 setImage:image IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil];
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
                         0.0, 0.0, 2.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    return GLKMatrix4Multiply(projectionMatrix,modelviewMatrix);
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

    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[SphereManager getVertexNum]];
    
}


@end
