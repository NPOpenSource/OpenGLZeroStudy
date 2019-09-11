//
//  OffScreenRenderViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OffScreenRenderViewController.h"
#import "OffScreenRenderBindObject.h"
#import "CubeManager.h"

float OSR_planeVertices[] = {
    // positions          // texture Coords (note we set these higher than 1 (together with GL_REPEAT as texture wrapping mode). this will cause the floor texture to repeat)
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f,  5.0f,  0.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    5.0f, -0.5f, -5.0f,  2.0f, 2.0f
};

float OSR_quadVertices[] = { // vertex attributes for a quad that fills the entire screen in Normalized Device Coordinates.
    // positions   // texCoords
    -1.0f,  1.0f,  0.0f, 1.0f,
    -1.0f, -1.0f,  0.0f, 0.0f,
    1.0f, -1.0f,  1.0f, 0.0f,
    
    -1.0f,  1.0f,  0.0f, 1.0f,
    1.0f, -1.0f,  1.0f, 0.0f,
    1.0f,  1.0f,  1.0f, 1.0f
};

@interface OffScreenRenderViewController ()
@property (nonatomic ,strong) Vertex * vertex;
@property (nonatomic ,strong) Vertex * planeVertex ;
@property (nonatomic ,strong) TextureUnit * cubeUnit ;
@property (nonatomic ,strong) TextureUnit * floorUnit ;

@property (nonatomic ,strong) Vertex * quadVertex ;
@property (nonatomic ,strong) FrameBuffer * framebuffer ;
@property (nonatomic ,strong) RenderBuffer * renderBuffer ;
@property (nonatomic ,strong) TextureUnit * spaceUnit ;


@property (nonatomic , assign) GLint mDefaultFBO;

@end

@implementation OffScreenRenderViewController

-(void)initSubObject{
    self.bindObject = [OffScreenRenderBindObject new];
    self.frameBufferBinder = [FrameBufferBindObject new];
    
    ///颜色组件
    self.spaceUnit = [TextureUnit new];
    [self.spaceUnit createSpaceTextureUnit];

    self.renderBuffer = [RenderBuffer new];
    [self.renderBuffer bindRenderBuffer:^(RenderBuffer * _Nonnull buffer) {
        [buffer setRenderStorageWithInternalformat:GL_DEPTH_COMPONENT16];
    }];
    
    
    self.framebuffer = [FrameBuffer new];
    [self.framebuffer bindOffScreenBufferAndSettingBlock:^(FrameBuffer * _Nonnull buffer) {
        [buffer bindColorAttachmentInTexture:self.spaceUnit.textureBuffer];
        [buffer bingDepthAttachmentInRenderBuffer:self.renderBuffer.rbo];
        [buffer check];
    }];

}

-(void)loadVertex{
    self.vertex= [Vertex new];
    int vertexNum =[CubeManager getTextureNormalVertexNum];
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:5];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[5];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getTextureNormalVertexs][i*8+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+3]=[CubeManager getTextureNormalVertexs][i*8+6+j];
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
  
    
    self.planeVertex= [Vertex new];
     vertexNum =6;
    [self.planeVertex allocVertexNum:vertexNum andEachVertexNum:5];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[5];
        for (int j=0; j<3; j++) {
            onevertex[j]=OSR_planeVertices[i*5+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+3]=OSR_planeVertices[i*5+3+j];
        }
        [self.planeVertex setVertex:onevertex index:i];
    }
    [self.planeVertex bindBufferWithUsage:GL_STATIC_DRAW];
    
    self.quadVertex = [Vertex new];
    vertexNum =6;
    [self.quadVertex allocVertexNum:vertexNum andEachVertexNum:4];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[4];
        for (int j=0; j<2; j++) {
            onevertex[j]=OSR_quadVertices[i*4+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+2]=OSR_quadVertices[i*4+2+j];
        }
        [self.quadVertex setVertex:onevertex index:i];
    }
    [self.quadVertex bindBufferWithUsage:GL_STATIC_DRAW];
}

-(void)createShader{
    [super createShader];
    self.frameShader = [Shader new];
    [self.frameShader compileLinkSuccessShaderName:@"FrameBuffer" completeBlock:^(GLuint program) {
        [self.frameBufferBinder BindAttribLocation:program];
    }];
    [self.frameBufferBinder setUniformLocation:self.frameShader.program];
}

-(void)createTextureUnit{
    self.cubeUnit = [TextureUnit new];
    [self.cubeUnit setImage:[UIImage imageNamed:@"marble.jpg"] IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil];
    self.floorUnit = [TextureUnit new];
    [self.floorUnit setImage:[UIImage imageNamed:@"metal.png"] IntoTextureUnit:GL_TEXTURE1 andConfigTextureUnit:^{
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    }];
}

-(void)_bindViewMatrix4:(GLBaseBindObject*)bindObject{
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(bindObject->uniforms[OSR_uniform_view], 1, 0,viewMatrix.m);
}
-(void)_bindProjectionMatrix4:(GLBaseBindObject*)bindObject{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(100.0f),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(bindObject->uniforms[OSR_uniform_projection], 1, 0,projectionMatrix.m);
}

    
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
     glGetIntegerv(GL_FRAMEBUFFER_BINDING, &_mDefaultFBO);
    [self.framebuffer bindOffScreenBuffer];
    glEnable(GL_DEPTH_TEST);
    glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    GLKMatrix4 cubeMode1 =[self _getModeMatrix4Location:GLKVector3Make(0.0f, 0.0f, 1.0f)];
    cubeMode1 = GLKMatrix4Rotate(cubeMode1, 30*M_PI/180.0,1, 1, 0);
    [self.shader use];
    [self _bindViewMatrix4:self.bindObject];
    [self _bindProjectionMatrix4:self.bindObject];
    [self _drawFloor:self.bindObject];
    [self _drawCubeMode:cubeMode1 bindObject:self.bindObject];
    glBindFramebuffer(GL_FRAMEBUFFER, self.mDefaultFBO);
    glDisable(GL_DEPTH_TEST);
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    [self.frameShader use];
    
    [self.spaceUnit activeTextureUnit:GL_TEXTURE2];
    [self.spaceUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:self.frameBufferBinder->uniforms[FB_uniform_Texture]];
    [self.quadVertex enableVertexInVertexAttrib:OSR_aPos numberOfCoordinates:2 attribOffset:0];
    [self.quadVertex enableVertexInVertexAttrib:OSR_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*2];
    [self.quadVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
}

-(GLKMatrix4)_getModeMatrix4Location:(GLKVector3)location{
    GLKMatrix4  mode = GLKMatrix4Identity;
    mode =  GLKMatrix4TranslateWithVector3(mode, location);
//    mode = GLKMatrix4Rotate(mode, 30*M_PI/180.0, 0, 1, 0);
    return mode;
}

-(void)_drawCubeMode:(GLKMatrix4)mode bindObject:(GLBaseBindObject*)bindObject{
  
    glUniformMatrix4fv(bindObject->uniforms[OSR_uniform_model], 1, 0,mode.m);
    [self.cubeUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[OSR_uniform_Texture]];
    [self.vertex enableVertexInVertexAttrib:OSR_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:OSR_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];
}

-(void)_drawFloor:(GLBaseBindObject*)bindObject{
    
    GLKMatrix4 mode = GLKMatrix4Identity;
    glUniformMatrix4fv(bindObject->uniforms[OSR_uniform_model], 1, 0,mode.m);
    [self.floorUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[OSR_uniform_Texture]];
    [self.planeVertex enableVertexInVertexAttrib:OSR_aPos numberOfCoordinates:3 attribOffset:0];
    [self.planeVertex enableVertexInVertexAttrib:OSR_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.planeVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
}

@end
