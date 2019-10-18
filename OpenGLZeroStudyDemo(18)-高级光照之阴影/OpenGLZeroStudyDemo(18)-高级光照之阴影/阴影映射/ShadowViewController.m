//
//  ShadowViewController.m
//  OpenGLZeroStudyDemo(18)-高级光照之阴影
//
//  Created by glodon on 2019/10/17.
//  Copyright © 2019 persion. All rights reserved.
//

#import "ShadowViewController.h"
#import "ShadowBindObject.h"
#import "ShadowDepthBindObject.h"
#import "CubeManager.h"

GLfloat SD_planeVertices[] = {
       // Positions          // Normals         // Texture Coords
       25.0f, -0.5f, 25.0f, 0.0f, 1.0f, 0.0f, 25.0f, 0.0f,
       -25.0f, -0.5f, -25.0f, 0.0f, 1.0f, 0.0f, 0.0f, 25.0f,
       -25.0f, -0.5f, 25.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f,

       25.0f, -0.5f, 25.0f, 0.0f, 1.0f, 0.0f, 25.0f, 0.0f,
       25.0f, -0.5f, -25.0f, 0.0f, 1.0f, 0.0f, 25.0f, 25.0f,
       - 25.0f, -0.5f, -25.0f, 0.0f, 1.0f, 0.0f, 0.0f, 25.0f
   };

float SD_quadVertices[] = {
    // positions        // texture Coords
    -1.0f,  1.0f, 0.0f, 0.0f, 1.0f,
    -1.0f, -1.0f, 0.0f, 0.0f, 0.0f,
     1.0f,  1.0f, 0.0f, 1.0f, 1.0f,
     1.0f, -1.0f, 0.0f, 1.0f, 0.0f,
};


@interface ShadowViewController ()
@property (nonatomic ,strong) Vertex * vertex ;
@property (nonatomic ,strong) TextureUnit * planeUnit ;
@property (nonatomic ,strong) FrameBuffer * depthMap ;
@property (nonatomic ,strong) RenderBuffer * renderBuffer ;
@property (nonatomic ,strong) TextureUnit * spaceUnit ;
@property (nonatomic ,strong) GLBaseBindObject * shadowDepthBindObject ;
@property (nonatomic ,strong) Shader * shadowShader ;
@property (nonatomic ,strong) Vertex * cubeVertex ;
@property (nonatomic ,strong) Vertex * quadVAO ;
@property (nonatomic ,strong) TextureUnit * depthUnit;
@property (nonatomic , assign) GLint mDefaultFBO;

@end

@implementation ShadowViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}


-(void)initSubObject{
    glEnable(GL_DEPTH_TEST);
    self.bindObject = [ShadowBindObject new];
    self.shadowDepthBindObject = [ShadowDepthBindObject new];

    self.spaceUnit = [TextureUnit new];
    [self.spaceUnit createSpaceTextureUnit];

//      self.renderBuffer = [RenderBuffer new];
//      [self.renderBuffer bindRenderBuffer:^(RenderBuffer * _Nonnull buffer) {
//          [buffer setRenderStorageWithInternalformat:GL_DEPTH_COMPONENT16];
//      }];
    
    self.depthUnit = [TextureUnit new];
    [self.spaceUnit createDepthTextureUnit];

    
    //depthMap
    self.depthMap = [FrameBuffer new];
    [self.depthMap bindOffScreenBufferAndSettingBlock:^(FrameBuffer * _Nonnull buffer) {
          [buffer bindColorAttachmentInTexture:self.spaceUnit.textureBuffer];
          [buffer bindDepthAttachmentInTexture:self.depthUnit.textureBuffer];
//          [buffer bingDepthAttachmentInRenderBuffer:self.renderBuffer.rbo];
//          glDrawBuffer(GL_NONE);
//          glReadBuffer(GL_NONE);
          [buffer check];
      }];
}

-(void)loadVertex{
    //simpleshader  渲染
    self.vertex= [Vertex new];
    int vertexNum =6;
    int vertexWidth = 8;
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:vertexWidth];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[vertexWidth];
        for (int j=0; j<vertexWidth; j++) {
            onevertex[j]=SD_planeVertices[i*vertexWidth+j];
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
//    [self.vertex enableVertexInVertexAttrib:SD_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*6];
    
    //shadowdepth  渲染
    self.cubeVertex = [Vertex new];
     vertexNum =[CubeManager getTextureNormalVertexNum];
    [self.cubeVertex allocVertexNum:vertexNum andEachVertexNum:8];
    //可以整体赋值的
    for (int i=0; i<vertexNum; i++) {
        float onevertex[8];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getTextureNormalVertexs][i*8+j];
        }
        for (int j=0; j<3; j++) {
            onevertex[j+3]=[CubeManager getTextureNormalVertexs][i*8+3+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+6]=[CubeManager getTextureNormalVertexs][i*8+6+j];
        }
        [self.cubeVertex setVertex:onevertex index:i];
    }
    [self.cubeVertex bindBufferWithUsage:GL_STATIC_DRAW];
//    [self.cubeVertex enableVertexInVertexAttrib:SD_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*6];


    self.quadVAO = [Vertex new];
      vertexNum =4;
    vertexWidth = 5;
     [self.quadVAO allocVertexNum:vertexNum andEachVertexNum:vertexWidth];
    for (int i=0; i<vertexNum; i++) {
           float onevertex[vertexWidth];
           for (int j=0; j<vertexWidth; j++) {
               onevertex[j]=SD_quadVertices[i*vertexWidth+j];
           }
           [self.quadVAO setVertex:onevertex index:i];
       }
    
    [self.quadVAO bindBufferWithUsage:GL_STATIC_DRAW];

}

-(void)createShader{
//    debug-depthque
    self.shader = [Shader new];
    [self.shader compileLinkSuccessShaderName:self.bindObject.getShaderName completeBlock:^(GLuint program) {
        [self.bindObject BindAttribLocation:program];
    }];
    [self.bindObject setUniformLocation:self.shader.program];

    //simpledepth
    self.shadowShader = [Shader new];
    [self.shadowShader compileLinkSuccessShaderName:self.shadowDepthBindObject.getShaderName completeBlock:^(GLuint program) {
        [self.shadowDepthBindObject BindAttribLocation:program];
    }];
    
    [self.shadowDepthBindObject setUniformLocation:self.shadowShader.program];

}

- (void)createTextureUnit{
//    self.planeUnit = [TextureUnit new];
//    [self.planeUnit setImage:[UIImage imageNamed:@"wood.png"] IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:^{
//        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
//        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
//        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
//    }];
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    CGFloat scale = UIScreen.mainScreen.scale;
       GLsizei fbo_width = [UIScreen mainScreen].bounds.size.width*scale;
       GLsizei fbo_height =  [UIScreen mainScreen].bounds.size.height*scale;
    glViewport(0,0,fbo_width,fbo_height);
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &_mDefaultFBO);
//    [self.shader use];
//    [self.planeUnit bindtextureUnitLocationAndShaderUniformSamplerLocation: self.bindObject->uniforms[SD_uniform_depthMap]];
//    glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
//       glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
//
    
    GLKMatrix4 lightProjection,lightView,lightSpaceMatrix;
     GLfloat near_plane = 1.0f, far_plane = 7.5f;
     GLKVector3  lightPos = GLKVector3Make(-2.0f, 4.0f, -1.0f);
    
    lightProjection = GLKMatrix4MakeOrtho(-10, 10, -10, 10, near_plane, far_plane);
    lightView = GLKMatrix4MakeLookAt(lightPos.x, lightPos.y, lightPos.z, 0, 0, 0, 0, 1, 0);
    lightSpaceMatrix = GLKMatrix4Multiply(lightProjection,lightView);
 
    [self.depthMap bindOffScreenBuffer];
    glClearColor(1.0f, 0.1f, 0.1f, 1.0f);
    glClear(GL_DEPTH_BUFFER_BIT);
    [self.shadowShader use];
     glUniformMatrix4fv(self.shadowDepthBindObject->uniforms[SDD_uniform_lightSpaceMatrix], 1, 0,lightSpaceMatrix.m);
    GLKMatrix4 model;
       glUniformMatrix4fv(self.shadowDepthBindObject->uniforms[SDD_uniform_model], 1, 0,model.m);
    [self.vertex enableVertexInVertexAttrib:SDD_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
//       // Cubes
    model = GLKMatrix4Identity;
    model = GLKMatrix4Translate(model, 0, 1.5, 0);
    glUniformMatrix4fv(self.shadowDepthBindObject->uniforms[SDD_uniform_model], 1, 0,model.m);
  [self.cubeVertex enableVertexInVertexAttrib:SDD_aPos numberOfCoordinates:3 attribOffset:0];
    [self.cubeVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];
    model = GLKMatrix4Identity;
      model = GLKMatrix4Translate(model, 1.0, 0.0, 1.0);
      glUniformMatrix4fv(self.shadowDepthBindObject->uniforms[SDD_uniform_model], 1, 0,model.m);
  [self.cubeVertex enableVertexInVertexAttrib:SDD_aPos numberOfCoordinates:3 attribOffset:0];
    [self.cubeVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];

    model = GLKMatrix4Identity;
      model = GLKMatrix4Translate(model, -1.0,  0.0, 2.0);
      glUniformMatrix4fv(self.shadowDepthBindObject->uniforms[SDD_uniform_model], 1, 0,model.m);
    [self.cubeVertex enableVertexInVertexAttrib:SDD_aPos numberOfCoordinates:3 attribOffset:0];
    [self.cubeVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];

    glBindFramebuffer(GL_FRAMEBUFFER, self.mDefaultFBO);
    glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [self.shader use];
    glUniform1f(self.bindObject->uniforms[SD_uniform_nearPlane], near_plane);
    glUniform1f(self.bindObject->uniforms[SD_uniform_farPlane], far_plane);
    [self.depthUnit activeTextureUnit:GL_TEXTURE1];
    [self.depthUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[SD_uniform_depthMap]];
    
    //教程搞不下去了.暂时放弃  
    //离屏渲染  这里肯定是不对的
//    glUniformMatrix4fv(self.shader->uniforms[SDD_uniform_model], 1, 0,model.m);
    [self.quadVAO enableVertexInVertexAttrib:SD_aPos numberOfCoordinates:3 attribOffset:0];
    [self.quadVAO enableVertexInVertexAttrib:SD_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    [self.quadVAO drawVertexWithMode:GL_TRIANGLE_STRIP startVertexIndex:0 numberOfVertices:4];
}


@end

