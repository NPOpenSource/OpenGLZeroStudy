//
//  DiffuseLightingViewController.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DiffuseLightingViewController.h"
#import "DiffuseLightingBindObject.h"
#import "SphereManager.h"

@interface DiffuseLightingViewController ()
@property (nonatomic ,strong) Vertex * vertexPostion ;
@property (nonatomic ,strong) Vertex * vertexTexture ;
@property (nonatomic ,strong) Vertex * aNormal ;

@end

@implementation DiffuseLightingViewController
-(void)initSubObject{
    //生命周期三秒钟
    __weakSelf
    self.bindObject = [DiffuseLightingBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[DiffuseLightingUniformLocationModel] =  glGetUniformLocation(program, "u_model");
        weakSelf.bindObject->uniforms[DiffuseLightingUniformLocationInverModel] =  glGetUniformLocation(program, "u_inverModel");
        weakSelf.bindObject->uniforms[DiffuseLightingUniformLocationDiffusePositon] =  glGetUniformLocation(program, "lightPos");
        weakSelf.bindObject->uniforms[DiffuseLightingUniformLocationDiffuseLightColor] =  glGetUniformLocation(program, "lightColor");
        weakSelf.bindObject->uniforms[DiffuseLightingUniformLocationAmbientLight] =  glGetUniformLocation(program, "ambientLight");


    };
}

-(void)loadVertex{
    //顶点数据缓存
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
    [self.vertexPostion enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:3 attribOffset:0];

    self.aNormal = [Vertex new];
    [self.aNormal   allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[SphereManager getSphereNormals][i*3+j];
        }
        [self.aNormal setVertex:onevertex index:i];
    }
    [self.aNormal bindBufferWithUsage:GL_STATIC_DRAW];
    [self.aNormal enableVertexInVertexAttrib:DiffuseLightingBindAttribLocationNormal numberOfCoordinates:3 attribOffset:0];
    
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
    [self.vertexTexture enableVertexInVertexAttrib:DiffuseLightingBindAttribLocationTexture numberOfCoordinates:2 attribOffset:0];
    GLKVector3 diffPostion = GLKVector3Make(5.0, 5.0, 5.0);
    glUniform3fv(self.bindObject->uniforms[DiffuseLightingUniformLocationDiffusePositon], 1,diffPostion.v);
    GLKVector3 diffColor = GLKVector3Make(1.0, 1.0, 1.0);
    glUniform3fv(self.bindObject->uniforms[DiffuseLightingUniformLocationDiffuseLightColor], 1,diffColor.v);
    GLKVector4 ambientLight = GLKVector4Make(1.0, 0.5, 0.5, 1.0);
    glUniform4fv(self.bindObject->uniforms[DiffuseLightingUniformLocationAmbientLight], 1,ambientLight.v);

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
    angle+=3;
    GLKMatrix4 mode =GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0);
    glUniformMatrix4fv(self.bindObject->uniforms[MVPMatrix], 1, 0,mvp.m);
    glUniformMatrix4fv(self.bindObject->uniforms[DiffuseLightingUniformLocationModel], 1, 0,mode.m);
 
    glUniformMatrix4fv(self.bindObject->uniforms[DiffuseLightingUniformLocationModel], 1, 0,mode.m);

    bool isSuccess = YES;
    mode = GLKMatrix4InvertAndTranspose(mode,&isSuccess);
    glUniformMatrix4fv(self.bindObject->uniforms[DiffuseLightingUniformLocationInverModel], 1, 0,mode.m);

    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[SphereManager getVertexNum]];
}


@end
