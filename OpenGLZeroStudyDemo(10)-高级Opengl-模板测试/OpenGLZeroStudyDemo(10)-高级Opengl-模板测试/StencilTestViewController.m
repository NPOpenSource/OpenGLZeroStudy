//
//  StencilTestViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "StencilTestViewController.h"
#import "StencilTestBindObject.h"
#import "CubeManager.h"
float planeVertices[] = {
    // positions          // texture Coords (note we set these higher than 1 (together with GL_REPEAT as texture wrapping mode). this will cause the floor texture to repeat)
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f,  5.0f,  0.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    5.0f, -0.5f, -5.0f,  2.0f, 2.0f
};

@interface StencilTestViewController ()
@property (nonatomic ,strong) Vertex * vertex;
@property (nonatomic ,strong) Vertex * planeVertex ;
@property (nonatomic ,strong) TextureUnit * cubeUnit ;
@property (nonatomic ,strong) TextureUnit * floorUnit ;
@property (nonatomic ,strong) Shader * stencilShader ;
@property (nonatomic ,strong) GLBaseBindObject * bindObjectColor ;

@end

@implementation StencilTestViewController

-(void)initSubObject{
    NSLog(@"GL_STENCIL_TEST %d", glIsEnabled(GL_STENCIL_TEST));

    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    glEnable(GL_STENCIL_TEST);
    glStencilFunc(GL_NOTEQUAL, 1, 0xFF);
    glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
   ;
    NSLog(@"GL_STENCIL_TEST %d", glIsEnabled(GL_STENCIL_TEST));
    self.bindObject = [StencilTestBindObject new];
    self.bindObjectColor =[StencilTestBindObject new];
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
            onevertex[j]=planeVertices[i*5+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+3]=planeVertices[i*5+3+j];
        }
        [self.planeVertex setVertex:onevertex index:i];
    }
    [self.planeVertex bindBufferWithUsage:GL_STATIC_DRAW];
   
}

-(void)createShader{
    [super createShader];
    self.stencilShader = [Shader new];
    [self.stencilShader compileLinkSuccessShaderName:@"StencilTestColor" completeBlock:^(GLuint program) {
        [self.bindObjectColor BindAttribLocation:program];
    }];
    [self.bindObjectColor setUniformLocation:self.stencilShader.program];
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
    glUniformMatrix4fv(bindObject->uniforms[ST_uniform_view], 1, 0,viewMatrix.m);
}
-(void)_bindProjectionMatrix4:(GLBaseBindObject*)bindObject{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(bindObject->uniforms[ST_uniform_projection], 1, 0,projectionMatrix.m);
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    /// 模板测试虽然开启了. 但是不起作用. 
    
    glClearStencil(0);
    glClearColor(1,0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT); // don't forget to clear the stencil buffer!
 
    GLKMatrix4 cubeMode1 =[self _getModeMatrix4Location:GLKVector3Make(-1.0f, 0.0f, -1.0f)];
    GLKMatrix4 cubeMode2 = [self _getModeMatrix4Location:GLKVector3Make(0.0f, 0.0f,0.0f)];
    [self.stencilShader use];
    [self _bindViewMatrix4:self.bindObjectColor];
    [self _bindProjectionMatrix4:self.bindObjectColor];
    [self.shader use];
    [self _bindViewMatrix4:self.bindObject];
    [self _bindProjectionMatrix4:self.bindObject];
    glStencilMask(0x00);
    [self _drawFloor:self.bindObject];
    glStencilFunc(GL_NEVER, 1, 0xFF);

    glStencilMask(0xFF);
    [self _drawCubeMode:cubeMode1 bindObject:self.bindObject];
    [self _drawCubeMode:cubeMode2 bindObject:self.bindObject];
    glStencilFunc(GL_NEVER, 1, 0xFF);
    glStencilMask(0x00);
    glDisable(GL_DEPTH_TEST);
    [self.stencilShader use];
    float scale = 1.1;
    cubeMode1 = GLKMatrix4Scale(cubeMode1, scale, scale, scale);
    cubeMode2 = GLKMatrix4Scale(cubeMode2, scale, scale, scale);
    [self _drawCubeMode:cubeMode1 bindObject:self.bindObjectColor];
    [self _drawCubeMode:cubeMode2 bindObject:self.bindObjectColor];
    glStencilMask(0xFF);
    glEnable(GL_DEPTH_TEST);
   
}

-(GLKMatrix4)_getModeMatrix4Location:(GLKVector3)location{
    GLKMatrix4  mode = GLKMatrix4Identity;
    mode =  GLKMatrix4TranslateWithVector3(mode, location);
    mode = GLKMatrix4Rotate(mode, 30*M_PI/180.0, 0, 1, 0);
    return mode;
}

-(void)_drawCubeMode:(GLKMatrix4)mode bindObject:(GLBaseBindObject*)bindObject{
  
    glUniformMatrix4fv(bindObject->uniforms[ST_uniform_model], 1, 0,mode.m);
    
    [self.cubeUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[ST_uniform_Texture]];
    [self.vertex enableVertexInVertexAttrib:ST_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:ST_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];
}

-(void)_drawFloor:(GLBaseBindObject*)bindObject{
    
    GLKMatrix4 mode = GLKMatrix4Identity;
    glUniformMatrix4fv(bindObject->uniforms[ST_uniform_model], 1, 0,mode.m);
     [self.floorUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[ST_uniform_Texture]];
    [self.planeVertex enableVertexInVertexAttrib:ST_aPos numberOfCoordinates:3 attribOffset:0];
    [self.planeVertex enableVertexInVertexAttrib:ST_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.planeVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
}

@end
