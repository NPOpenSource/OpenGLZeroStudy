//
//  NotBlendViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "NotBlendViewController.h"
#import "NotBlendBindObject.h"
#import "CubeManager.h"
float NST_planeVertices[] = {
    // positions          // texture Coords (note we set these higher than 1 (together with GL_REPEAT as texture wrapping mode). this will cause the floor texture to repeat)
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f,  5.0f,  0.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    5.0f, -0.5f, -5.0f,  2.0f, 2.0f
};

float NST_transparentVertices[] = {
    // positions         // texture Coords (swapped y coordinates because texture is flipped upside down)
    0.0f,  0.5f,  0.0f,  1.0f,  1.0f,
    0.0f, -0.5f,  0.0f,  1.0f,  0.0f,
    1.0f, -0.5f,  0.0f,  0.0f,  0.0f,
    
    0.0f,  0.5f,  0.0f,  1.0f,  1.0f,
    1.0f, -0.5f,  0.0f,  0.0f,  0.0f,
    1.0f,  0.5f,  0.0f,  0.0f,  1.0f
};

@interface NotBlendViewController ()
@property (nonatomic ,strong) Vertex * vertex;
@property (nonatomic ,strong) Vertex * planeVertex ;
@property (nonatomic ,strong) Vertex * transparentVertex ;
@property (nonatomic ,strong) TextureUnit * cubeUnit ;
@property (nonatomic ,strong) TextureUnit * floorUnit ;
@property (nonatomic ,strong) TextureUnit * transparentUnit ;
@end

@implementation NotBlendViewController

-(void)initSubObject{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    self.bindObject = [NotBlendBindObject new];
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
            onevertex[j]=NST_planeVertices[i*5+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+3]=NST_planeVertices[i*5+3+j];
        }
        [self.planeVertex setVertex:onevertex index:i];
    }
    [self.planeVertex bindBufferWithUsage:GL_STATIC_DRAW];
   
    self.transparentVertex= [Vertex new];
    vertexNum =6;
    [self.transparentVertex allocVertexNum:vertexNum andEachVertexNum:5];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[5];
        for (int j=0; j<3; j++) {
            onevertex[j]=NST_transparentVertices[i*5+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+3]=NST_transparentVertices[i*5+3+j];
        }
        [self.transparentVertex setVertex:onevertex index:i];
    }
    [self.transparentVertex bindBufferWithUsage:GL_STATIC_DRAW];
}

//-(void)createShader{
//    [super createShader];
//    self.stencilShader = [Shader new];
//    [self.stencilShader compileLinkSuccessShaderName:@"BlendColor" completeBlock:^(GLuint program) {
//        [self.bindObjectColor BindAttribLocation:program];
//    }];
//    [self.bindObjectColor setUniformLocation:self.stencilShader.program];
//}

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
    self.transparentUnit = [TextureUnit new];
    [self.transparentUnit setImage:[UIImage imageNamed:@"grass.png"] IntoTextureUnit:GL_TEXTURE2 andConfigTextureUnit:nil] ;

}

-(void)_bindViewMatrix4:(GLBaseBindObject*)bindObject{
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(bindObject->uniforms[NST_uniform_view], 1, 0,viewMatrix.m);
}
-(void)_bindProjectionMatrix4:(GLBaseBindObject*)bindObject{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(100.0f),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(bindObject->uniforms[NST_uniform_projection], 1, 0,projectionMatrix.m);
}

    
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    /// 模板测试虽然开启了. 但是不起作用. 
    
    glClearStencil(0);
    glClearColor(1,0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // don't forget to clear the stencil buffer!
 
    GLKMatrix4 cubeMode1 =[self _getModeMatrix4Location:GLKVector3Make(-1.0f, 0.0f, -1.0f)];
    GLKMatrix4 cubeMode2 = [self _getModeMatrix4Location:GLKVector3Make(2.0f, 0.0f,0.0f)];
    
    [self.shader use];
    [self _bindViewMatrix4:self.bindObject];
    [self _bindProjectionMatrix4:self.bindObject];
    [self _drawFloor:self.bindObject];
    [self _drawCubeMode:cubeMode1 bindObject:self.bindObject];
    [self _drawCubeMode:cubeMode2 bindObject:self.bindObject];
    GLKVector3 vegetation[5]={
        GLKVector3Make(-1.5f, 0.0f, -0.48f),
         GLKVector3Make( 1.5f, 0.0f, 0.51f),
         GLKVector3Make(0.0f, 0.0f, 0.7f),
         GLKVector3Make(-0.3f, 0.0f, -2.3f),
        GLKVector3Make(0.5f, 0.0f, -0.6f),
    };
    
    for (GLuint i = 0; i < 5; i++)
    {
        GLKMatrix4 model =[self _getModeMatrix4Location:vegetation[i]];
        glUniformMatrix4fv(self.bindObject->uniforms[NST_uniform_model], 1, 0,model.m);

        [self.transparentUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[NST_uniform_Texture]];
        [self.transparentVertex enableVertexInVertexAttrib:NST_aPos numberOfCoordinates:3 attribOffset:0];
        [self.transparentVertex enableVertexInVertexAttrib:NST_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
        
        [self.transparentVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
//        shader.setMat4("model", model);
//        glDrawArrays(GL_TRIANGLES, 0, 6);
    }
    
    
}

-(GLKMatrix4)_getModeMatrix4Location:(GLKVector3)location{
    GLKMatrix4  mode = GLKMatrix4Identity;
    mode =  GLKMatrix4TranslateWithVector3(mode, location);
//    mode = GLKMatrix4Rotate(mode, 30*M_PI/180.0, 0, 1, 0);
    return mode;
}

-(void)_drawCubeMode:(GLKMatrix4)mode bindObject:(GLBaseBindObject*)bindObject{
  
    glUniformMatrix4fv(bindObject->uniforms[NST_uniform_model], 1, 0,mode.m);
    
    [self.cubeUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[NST_uniform_Texture]];
    [self.vertex enableVertexInVertexAttrib:NST_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:NST_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];
}

-(void)_drawFloor:(GLBaseBindObject*)bindObject{
    
    GLKMatrix4 mode = GLKMatrix4Identity;
    glUniformMatrix4fv(bindObject->uniforms[NST_uniform_model], 1, 0,mode.m);
     [self.floorUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[NST_uniform_Texture]];
    [self.planeVertex enableVertexInVertexAttrib:NST_aPos numberOfCoordinates:3 attribOffset:0];
    [self.planeVertex enableVertexInVertexAttrib:NST_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.planeVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
}

@end
