//
//  DepthTestMaskViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/19.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestMaskViewController.h"
#import "DepthTestMaskBindObject.h"

@interface DepthTestMaskViewController ()
@property (nonatomic ,strong) Vertex * vertex;
@property (nonatomic ,strong) TextureUnit * unitFront ;
@property (nonatomic ,strong) TextureUnit * unitMiddle;
@property (nonatomic ,strong) TextureUnit * unitBack;
@end

@implementation DepthTestMaskViewController
-(void)initSubObject{
    //生命周期三秒钟
    self.bindObject = [DepthTestMaskBindObject new];
    self.glDrawConfig = ^{
        glClear(GL_COLOR_BUFFER_BIT);
    };
    self.glDrawMaskEndConfig = ^{
        
    };
    self.glDrawMaskBeginConfig = ^{
        
    };
    
}

#define VertexNum 4
#define eachVertexNum 4

static GLfloat s_vertex[4*4] = {
    0.5,0.5, 0,1, //1
    -0.5,0.5,1,1,//0
    -0.5,-0.5,1,0, //2
    0.5,-0.5,0,0//3
};

-(void)loadVertex{
    
    self.vertex = [Vertex new];
    [self.vertex allocVertexNum:VertexNum andEachVertexNum:eachVertexNum];
    for (int i =0; i<VertexNum; i++) {
        GLfloat vertex[4];
        vertex[0] = s_vertex[i*VertexNum];
        vertex[1] = s_vertex[i*VertexNum+1];
        vertex[2] = s_vertex[i*VertexNum+2];
        vertex[3] = s_vertex[i*VertexNum+3];
        [self.vertex setVertex:vertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:DTM_aPos  numberOfCoordinates:2 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:DTM_aTexture numberOfCoordinates:2 attribOffset:2*sizeof(GLfloat)];
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
    glUniformMatrix4fv(self.bindObject->uniforms[DTM_uniform_view], 1, 0,viewMatrix.m);

    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              10.0);
    glUniformMatrix4fv(self.bindObject->uniforms[DTM_uniform_projection], 1, 0,projectionMatrix.m);
  
   
    
    //front
    {
        GLKMatrix4  mode = GLKMatrix4Identity;
        glUniformMatrix4fv(self.bindObject->uniforms[DTM_uniform_model], 1, 0,mode.m);
        [self.unitFront bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DTM_uniform_sam2D]];
        [self.vertex enableVertexInVertexAttrib:DTM_aPos numberOfCoordinates:2 attribOffset:0];
        [self.vertex enableVertexInVertexAttrib:DTM_aTexture numberOfCoordinates:2 attribOffset:sizeof(float)*2];
        
        [self.vertex drawVertexWithMode:GL_TRIANGLE_FAN startVertexIndex:0 numberOfVertices:VertexNum];
    }
    // middle
     self.glDrawMaskBeginConfig();
    {
        GLKMatrix4  mode = GLKMatrix4Identity;
        mode = GLKMatrix4Translate(mode, 0.25, 0, 0);
        glUniformMatrix4fv(self.bindObject->uniforms[DTM_uniform_model], 1, 0,mode.m);
        [self.unitMiddle bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DTM_uniform_sam2D]];
        [self.vertex enableVertexInVertexAttrib:DTM_aPos numberOfCoordinates:2 attribOffset:0];
        [self.vertex enableVertexInVertexAttrib:DTM_aTexture numberOfCoordinates:2 attribOffset:sizeof(float)*2];
        
        [self.vertex drawVertexWithMode:GL_TRIANGLE_FAN startVertexIndex:0 numberOfVertices:VertexNum];
    }
 
    //back
    {
        GLKMatrix4  mode = GLKMatrix4Identity;
        mode = GLKMatrix4Translate(mode, 0.5, 0, 0);
        glUniformMatrix4fv(self.bindObject->uniforms[DTM_uniform_model], 1, 0,mode.m);
        [self.unitBack bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DTM_uniform_sam2D]];
        [self.vertex enableVertexInVertexAttrib:DTM_aPos numberOfCoordinates:2 attribOffset:0];
        [self.vertex enableVertexInVertexAttrib:DTM_aTexture numberOfCoordinates:2 attribOffset:sizeof(float)*2];
        
        [self.vertex drawVertexWithMode:GL_TRIANGLE_FAN startVertexIndex:0 numberOfVertices:VertexNum];
    }
    self.glDrawMaskEndConfig();
    
}


@end
