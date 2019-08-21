//
//  DepthTestFuncViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/20.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestFuncViewController.h"
#import "DepthTestFuncBindObject.h"
@interface DepthTestFuncViewController ()
@property (nonatomic ,strong) Vertex * vertex;
@property (nonatomic ,strong) TextureUnit * unitFront ;
@property (nonatomic ,strong) TextureUnit * unitMiddle;
@property (nonatomic ,strong) TextureUnit * unitBack;
@end

@implementation DepthTestFuncViewController
-(void)initSubObject{
    //生命周期三秒钟
    self.bindObject = [DepthTestFuncBindObject new];
    glEnable(GL_DEPTH_TEST);
    self.glDrawConfig = ^{
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    };
    self.glDrawMaskEndConfig = ^{
        
    };
    self.glDrawMaskBeginConfig = ^{
        
    };
    
}

#define DTF_VertexNum 4
#define DTF_eachVertexNum 4

static GLfloat dtf_s_vertex[4*4] = {
    0.5,0.5, 0,1, //1
    -0.5,0.5,1,1,//0
    -0.5,-0.5,1,0, //2
    0.5,-0.5,0,0//3
};

-(void)loadVertex{
    
    self.vertex = [Vertex new];
    [self.vertex allocVertexNum:DTF_VertexNum andEachVertexNum:DTF_eachVertexNum];
    for (int i =0; i<DTF_VertexNum; i++) {
        GLfloat vertex[4];
        vertex[0] = dtf_s_vertex[i*DTF_VertexNum];
        vertex[1] = dtf_s_vertex[i*DTF_VertexNum+1];
        vertex[2] = dtf_s_vertex[i*DTF_VertexNum+2];
        vertex[3] = dtf_s_vertex[i*DTF_VertexNum+3];
        [self.vertex setVertex:vertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:DTF_aPos  numberOfCoordinates:2 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:DTF_aTexture numberOfCoordinates:2 attribOffset:2*sizeof(GLfloat)];
}




-(void)createTextureUnit{
    self.unitFront = [TextureUnit new];
    [self.unitFront setImage:[UIImage imageNamed:@"green.png"] IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil];
    self.unitBack = [TextureUnit new];
    [self.unitBack setImage:[UIImage imageNamed:@"red.png"] IntoTextureUnit:GL_TEXTURE1 andConfigTextureUnit:nil];
    self.unitMiddle = [TextureUnit new];
    [self.unitMiddle setImage:[UIImage imageNamed:@"texture.jpg"] IntoTextureUnit:GL_TEXTURE2 andConfigTextureUnit:nil];
    
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(1,1,1, 1);
    self.glDrawConfig();
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(self.bindObject->uniforms[DTF_uniform_view], 1, 0,viewMatrix.m);
    
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              10.0);
    glUniformMatrix4fv(self.bindObject->uniforms[DTF_uniform_projection], 1, 0,projectionMatrix.m);
     self.glDrawMaskBeginConfig();
    //front
    {
        GLKMatrix4  mode = GLKMatrix4Identity;
        glUniformMatrix4fv(self.bindObject->uniforms[DTF_uniform_model], 1, 0,mode.m);
        [self.unitFront bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DTF_uniform_sam2D]];
        [self.vertex enableVertexInVertexAttrib:DTF_aPos numberOfCoordinates:2 attribOffset:0];
        [self.vertex enableVertexInVertexAttrib:DTF_aTexture numberOfCoordinates:2 attribOffset:sizeof(float)*2];
        
        [self.vertex drawVertexWithMode:GL_TRIANGLE_FAN startVertexIndex:0 numberOfVertices:DTF_eachVertexNum];
    }
    // middle
    {
        GLKMatrix4  mode = GLKMatrix4Identity;
        mode = GLKMatrix4Translate(mode, 0.25, 0, 0);
        glUniformMatrix4fv(self.bindObject->uniforms[DTF_uniform_model], 1, 0,mode.m);
        [self.unitMiddle bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DTF_uniform_sam2D]];
        [self.vertex enableVertexInVertexAttrib:DTF_aPos numberOfCoordinates:2 attribOffset:0];
        [self.vertex enableVertexInVertexAttrib:DTF_aTexture numberOfCoordinates:2 attribOffset:sizeof(float)*2];
        
        [self.vertex drawVertexWithMode:GL_TRIANGLE_FAN startVertexIndex:0 numberOfVertices:DTF_eachVertexNum];
    }
     self.glDrawMaskEndConfig();
    //back
    {
        GLKMatrix4  mode = GLKMatrix4Identity;
        mode = GLKMatrix4Translate(mode, 0.5, 0, 0);
        glUniformMatrix4fv(self.bindObject->uniforms[DTF_uniform_model], 1, 0,mode.m);
        [self.unitBack bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DTF_uniform_sam2D]];
        [self.vertex enableVertexInVertexAttrib:DTF_aPos numberOfCoordinates:2 attribOffset:0];
        [self.vertex enableVertexInVertexAttrib:DTF_aTexture numberOfCoordinates:2 attribOffset:sizeof(float)*2];
        
        [self.vertex drawVertexWithMode:GL_TRIANGLE_FAN startVertexIndex:0 numberOfVertices:DTF_eachVertexNum];
    }
  
}


@end
