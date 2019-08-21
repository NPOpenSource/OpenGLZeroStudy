//
//  DepthTestViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestViewController.h"
#import "DepthTestBindObject.h"
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

@interface DepthTestViewController ()
@property (nonatomic ,strong) Vertex * vertex;
@property (nonatomic ,strong) Vertex * planeVertex ;
@property (nonatomic ,strong) TextureUnit * cubeUnit ;
@property (nonatomic ,strong) TextureUnit * floorUnit ;
@end

@implementation DepthTestViewController

-(void)initSubObject{
    //生命周期三秒钟
    glEnable(GL_DEPTH_TEST);
    self.bindObject = [DepthTestBindObject new];
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

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0,0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(self.bindObject->uniforms[DT_uniform_view], 1, 0,viewMatrix.m);
    
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                             1.0f,
                              20.0f);
    glUniformMatrix4fv(self.bindObject->uniforms[DT_uniform_projection], 1, 0,projectionMatrix.m);
    [self drawFloor];
    [self drawCubeLocation:GLKVector3Make(-1.0f, 0.0f, -1.0f)];
    [self drawCubeLocation:GLKVector3Make(0.0f, 0.0f, 1.0f)];

}

-(void)drawCubeLocation:(GLKVector3)location{
    GLKMatrix4  mode = GLKMatrix4Identity;
    mode =  GLKMatrix4TranslateWithVector3(mode, location);
    mode = GLKMatrix4Rotate(mode, 30*M_PI/180.0, 0, 1, 0);
    glUniformMatrix4fv(self.bindObject->uniforms[DT_uniform_model], 1, 0,mode.m);
    
    [self.cubeUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DT_uniform_Texture]];
    [self.vertex enableVertexInVertexAttrib:DT_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:DT_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];
}

-(void)drawFloor{
    
    GLKMatrix4 mode = GLKMatrix4Identity;
    glUniformMatrix4fv(self.bindObject->uniforms[DT_uniform_model], 1, 0,mode.m);
    
     [self.floorUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[DT_uniform_Texture]];
    [self.planeVertex enableVertexInVertexAttrib:DT_aPos numberOfCoordinates:3 attribOffset:0];
    [self.planeVertex enableVertexInVertexAttrib:DT_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    
    [self.planeVertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
}

@end
