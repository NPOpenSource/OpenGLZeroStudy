//
//  CubeMixLightingViewController.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "CubeMixLightingViewController.h"
#import "CubeMixBindObject.h"
#import "CubeManager.h"
@interface CubeMixLightingViewController ()
@property (nonatomic ,strong) Vertex * vertexPostion ;
@property (nonatomic ,strong) Vertex * vertexColor ;
@property (nonatomic ,strong) Vertex * vertexNormal ;
@end

@implementation CubeMixLightingViewController

-(void)initSubObject{
    //生命周期三秒钟
    __weakSelf
    self.bindObject = [CubeMixBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[MVPMatrix] = glGetUniformLocation(self.shader.program, "u_mvpMatrix");
        weakSelf.bindObject->uniforms[CubeMixUniformLocationModel] = glGetUniformLocation(self.shader.program, "u_model");
        weakSelf.bindObject->uniforms[CubeMixUniformLocationInvermodel] = glGetUniformLocation(self.shader.program, "u_inverModel");
        weakSelf.bindObject->uniforms[CubeMixUniformLocationDiffusePositon] = glGetUniformLocation(self.shader.program, "lightPos");
        weakSelf.bindObject->uniforms[CubeMixUniformLocationDiffuseLightColor] = glGetUniformLocation(self.shader.program, "lightColor");
        weakSelf.bindObject->uniforms[CubeMixUniformLocationviewPos] = glGetUniformLocation(self.shader.program, "viewPos");
            weakSelf.bindObject->uniforms[CubeMixUniformLocationAmbientLight] = glGetUniformLocation(self.shader.program, "ambientLight");
        
    };
}

-(void)createShader{
    __weakSelf
    self.shader = [Shader new];
    [self.shader compileLinkSuccessShaderName:self.bindObject.getShaderName completeBlock:^(GLuint program) {
        [self.bindObject BindAttribLocation:program];
    }];
    if (self.bindObject.uniformSetterBlock) {
        self.bindObject.uniformSetterBlock(self.shader.program);
    }
}
///消除0x502 操作
-(void)createTextureUnit{
    
}
-(void)loadVertex{
    //顶点数据缓存
    self.vertexPostion= [Vertex new];
    int vertexNum =[CubeManager getNormalVertexNum];
    [self.vertexPostion allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getNormalVertexs][i*9+j];
        }
        [self.vertexPostion setVertex:onevertex index:i];
    }
    [self.vertexPostion bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexPostion enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:3 attribOffset:0];
    
    self.vertexColor = [Vertex new];
    [self.vertexColor allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getNormalVertexs][i*9+j+6];
        }
        [self.vertexColor setVertex:onevertex index:i];
    }
    [self.vertexColor bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexColor enableVertexInVertexAttrib:CubeMixBindAttribLocationVertexColor numberOfCoordinates:3 attribOffset:0];
    
    self.vertexNormal= [Vertex new];
    [self.vertexNormal allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getNormalVertexs][i*9+j+3];
        }
        [self.vertexNormal setVertex:onevertex index:i];
    }
    [self.vertexNormal bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexNormal enableVertexInVertexAttrib:CubeMixBindAttribLocationNormal numberOfCoordinates:3 attribOffset:0];
    
    GLKVector3 diffColor = GLKVector3Make(1.0, 1.0, 1.0);
    glUniform3fv(self.bindObject->uniforms[CubeMixUniformLocationDiffuseLightColor], 1,diffColor.v);
   
    GLKVector3 ambientLigh = GLKVector3Make(1.0, 1.0, 1.0);

    glUniform3fv(self.bindObject->uniforms[CubeMixUniformLocationAmbientLight], 1,ambientLigh.v);

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
                         0.0, 0.0, 5.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    return GLKMatrix4Multiply(projectionMatrix,modelviewMatrix);
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glClearColor(1, 1, 1, 1);
    GLKMatrix4  mvp= [self getMVP];
    static GLfloat angle=0;
    angle ++ ;
    //        angle = 45;
    GLKMatrix4 mode =GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0);
    
    glUniformMatrix4fv(self.bindObject->uniforms[MVPMatrix], 1, 0,mvp.m);
    glUniformMatrix4fv(self.bindObject->uniforms[CubeMixUniformLocationModel], 1, 0,mode.m);
    bool isSuccess = YES;
    mode = GLKMatrix4InvertAndTranspose(mode,&isSuccess);
    glUniformMatrix4fv(self.bindObject->uniforms[CubeMixUniformLocationInvermodel], 1, 0,mode.m);
    
    GLKVector3 diffPostion = GLKVector3Make(5.0, 0.0,0);
    glUniform3fv(self.bindObject->uniforms[CubeMixUniformLocationDiffusePositon], 1,diffPostion.v);
    GLKVector3 viewPos = GLKVector3Make(.0, 0.0,2.0);
    glUniform3fv(self.bindObject->uniforms[CubeMixUniformLocationviewPos], 1,viewPos.v);
    
    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getNormalVertexNum]];
    //    [VertexElement drawElementIndexWithMode:GL_TRIANGLES indexNum:[CubeManager getVertexElementsNum] indexArr:[CubeManager getVertexElements]];
}



@end
