//
//  DefaultRenderViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DefaultRenderViewController.h"
#import "DefaultRenderBindObject.h"
#import "CubeManager.h"
#import "SkyBindObject.h"
float DR_planeVertices[] = {
    // positions          // texture Coords (note we set these higher than 1 (together with GL_REPEAT as texture wrapping mode). this will cause the floor texture to repeat)
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f,  5.0f,  0.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    
    5.0f, -0.5f,  5.0f,  2.0f, 0.0f,
    -5.0f, -0.5f, -5.0f,  0.0f, 2.0f,
    5.0f, -0.5f, -5.0f,  2.0f, 2.0f
};
float skyboxVertices[] = {


    //right
    1.0f, -1.0f, -1.0f,
    1.0f, -1.0f,  1.0f,
    1.0f,  1.0f,  1.0f,
    1.0f,  1.0f,  1.0f,
    1.0f,  1.0f, -1.0f,
    1.0f, -1.0f, -1.0f,
    //    left
    -1.0f, -1.0f,  1.0f,
    -1.0f, -1.0f, -1.0f,
    -1.0f,  1.0f, -1.0f,
    -1.0f,  1.0f, -1.0f,
    -1.0f,  1.0f,  1.0f,
    -1.0f, -1.0f,  1.0f,
  
    //top
    -1.0f,  1.0f, -1.0f,
    1.0f,  1.0f, -1.0f,
    1.0f,  1.0f,  1.0f,
    1.0f,  1.0f,  1.0f,
    -1.0f,  1.0f,  1.0f,
    -1.0f,  1.0f, -1.0f,
    //bottom
    -1.0f, -1.0f, -1.0f,
    -1.0f, -1.0f,  1.0f,
    1.0f, -1.0f, -1.0f,
    1.0f, -1.0f, -1.0f,
    -1.0f, -1.0f,  1.0f,
    1.0f, -1.0f,  1.0f,
    //front
    -1.0f, -1.0f,  1.0f,
    -1.0f,  1.0f,  1.0f,
    1.0f,  1.0f,  1.0f,
    1.0f,  1.0f,  1.0f,
    1.0f, -1.0f,  1.0f,
    -1.0f, -1.0f,  1.0f,
    // positions  back
    -1.0f,  1.0f, -1.0f,
    -1.0f, -1.0f, -1.0f,
    1.0f, -1.0f, -1.0f,
    1.0f, -1.0f, -1.0f,
    1.0f,  1.0f, -1.0f,
    -1.0f,  1.0f, -1.0f,
};
@interface DefaultRenderViewController ()
@property (nonatomic ,strong) Vertex * cubeVBO;
@property (nonatomic ,strong) Vertex * skyboxVBO ;
@property (nonatomic ,strong) TextureUnit * cubeUnit ;
@property (nonatomic ,strong) CubeTextureUnit * cubemapTexture ;
@property (nonatomic ,strong) Shader * skyboxShader ;
@property (nonatomic ,strong) GLBaseBindObject * skyBindObject ;
@end

@implementation DefaultRenderViewController

-(void)initSubObject{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    self.bindObject = [DefaultRenderBindObject new];
    self.skyBindObject = [SkyBindObject new];
}


-(void)loadVertex{
    self.cubeVBO= [Vertex new];
    int vertexNum =[CubeManager getTextureNormalVertexNum];
    [self.cubeVBO allocVertexNum:vertexNum andEachVertexNum:5];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[5];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getTextureNormalVertexs][i*8+j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+3]=[CubeManager getTextureNormalVertexs][i*8+6+j];
        }
        [self.cubeVBO setVertex:onevertex index:i];
    }
    [self.cubeVBO bindBufferWithUsage:GL_STATIC_DRAW];
  
    
    self.skyboxVBO= [Vertex new];
     vertexNum =36;
    [self.skyboxVBO allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=skyboxVertices[i*3+j];
        }
        [self.skyboxVBO setVertex:onevertex index:i];
    }
    [self.skyboxVBO bindBufferWithUsage:GL_STATIC_DRAW];
   
}

-(void)createShader{
    [super createShader];
    self.skyboxShader = [Shader new];
    [self.skyboxShader compileLinkSuccessShaderName:@"skybox" completeBlock:^(GLuint program) {
        [self.skyBindObject BindAttribLocation:program];
    }];
    [self.skyBindObject setUniformLocation:self.skyboxShader.program];
}

-(void)createTextureUnit{
    self.cubeUnit = [TextureUnit new];
    [self.cubeUnit setImage:[UIImage imageNamed:@"marble.jpg"] IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil];
    self.cubemapTexture =[CubeTextureUnit new];
    NSArray  * imageArrStr = @[@"right.jpg",@"left.jpg",@"bottom.jpg",@"top.jpg",@"front.jpg",@"back.jpg"];
   
    NSMutableArray * imageArr = [NSMutableArray new];
    for (int i=0; i<imageArrStr.count; i++) {
        [imageArr addObject:[UIImage imageNamed:imageArrStr[i]]];
    }
    [self.cubemapTexture bindCubeTextureInImageArray:imageArr];
}

-(void)_bindViewMatrix4:(GLBaseBindObject*)bindObject{
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(bindObject->uniforms[DR_uniform_view], 1, 0,viewMatrix.m);
}
-(void)_bindProjectionMatrix4:(GLBaseBindObject*)bindObject{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(bindObject->uniforms[DR_uniform_projection], 1, 0,projectionMatrix.m);
}

    
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    glClearColor(1,0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    GLKMatrix4 cubeMode1 =[self _getModeMatrix4Location:GLKVector3Make(0.0f, 0.0f, 0.0f)];
    static int mm = 30;
//    mm++;
    cubeMode1 = GLKMatrix4Rotate(cubeMode1, mm*M_PI/180.0, 0, 1, 0);
//    static float tran = 0;
//    tran +=0.1;
//    cubeMode1 = GLKMatrix4Translate(cubeMode1, 0, 0,tran );
//
    
    [self.shader use];
    [self _bindViewMatrix4:self.bindObject];
    [self _bindProjectionMatrix4:self.bindObject];
    [self _drawCubeMode:cubeMode1 bindObject:self.bindObject];
    glDepthFunc(GL_LEQUAL);  // change depth function so depth test passes when values are equal to depth buffer's content
    glDepthMask(GL_FALSE);
    [self.skyboxShader use];
    GLfloat aspectRatio=1;
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(self.skyBindObject->uniforms[SKB_uniform_projection], 1, 0,projectionMatrix.m);
    
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    // remove translation from the view matrix
    
    glUniformMatrix4fv(self.skyBindObject->uniforms[SKB_uniform_view], 1, 0,viewMatrix.m);
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_CUBE_MAP, self.cubemapTexture.textureID);
    glUniform1i(self.skyBindObject->uniforms[SKB_uniform_Texture], 1);
    
    [self.skyboxVBO enableVertexInVertexAttrib:SKB_aPos numberOfCoordinates:3 attribOffset:0];
    [self.skyboxVBO drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:36];
     glDepthFunc(GL_LESS);
    glDepthMask(GL_TRUE);
}

-(GLKMatrix4)_getModeMatrix4Location:(GLKVector3)location{
    GLKMatrix4  mode = GLKMatrix4Identity;
    mode =  GLKMatrix4TranslateWithVector3(mode, location);
//    mode = GLKMatrix4Rotate(mode, 30*M_PI/180.0, 0, 1, 0);
    return mode;
}

-(void)_drawCubeMode:(GLKMatrix4)mode bindObject:(GLBaseBindObject*)bindObject{

    glUniformMatrix4fv(bindObject->uniforms[DR_uniform_model], 1, 0,mode.m);

    [self.cubeUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[DR_uniform_Texture]];
    [self.cubeVBO enableVertexInVertexAttrib:DR_aPos numberOfCoordinates:3 attribOffset:0];
    [self.cubeVBO enableVertexInVertexAttrib:DR_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];

    [self.cubeVBO drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];
    
    
}



@end
