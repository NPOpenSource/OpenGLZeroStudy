//
//  MaterialViewController.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "MaterialViewController.h"
#import "GLMaterialBindObject.h"
#import "CubeManager.h"

@interface MaterialViewController ()

@property (nonatomic ,strong) Vertex * vertexPostion ;
@property (nonatomic ,strong) Vertex * vertexColor ;
@property (nonatomic ,strong) Vertex * vertexNormal ;
@end

@implementation MaterialViewController

-(void)initSubObject{
    //生命周期三秒钟
    __weakSelf
    self.bindObject = [GLMaterialBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[MVPMatrix] = glGetUniformLocation(self.shader.program, "u_mvpMatrix");
        weakSelf.bindObject->uniforms[MaterialUniformLocationModel] = glGetUniformLocation(self.shader.program, "u_model");
        weakSelf.bindObject->uniforms[MaterialUniformLocationInvermodel] = glGetUniformLocation(self.shader.program, "u_inverModel");
        weakSelf.bindObject->uniforms[MaterialUniformLocationDiffusePositon] = glGetUniformLocation(self.shader.program, "lightPos");
        weakSelf.bindObject->uniforms[MaterialUniformLocationDiffuseLightColor] = glGetUniformLocation(self.shader.program, "lightColor");
        weakSelf.bindObject->uniforms[MaterialUniformLocationviewPos] = glGetUniformLocation(self.shader.program, "viewPos");
        weakSelf.bindObject->uniforms[MaterialUniformLocationMaterialAmbient] = glGetUniformLocation(self.shader.program, "material.ambient");
        weakSelf.bindObject->uniforms[MaterialUniformLocationMaterialDiffuse] = glGetUniformLocation(self.shader.program, "material.diffuse");
        weakSelf.bindObject->uniforms[MaterialUniformLocationMaterialsSpecular] = glGetUniformLocation(self.shader.program, "material.specular");
        weakSelf.bindObject->uniforms[MaterialUniformLocationMaterialShininess] = glGetUniformLocation(self.shader.program, "material.shininess");

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
}///消除0x502 操作
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
    
//    self.vertexColor = [Vertex new];
//    [self.vertexColor allocVertexNum:vertexNum andEachVertexNum:3];
//    for (int i=0; i<vertexNum; i++) {
//        float onevertex[3];
//        for (int j=0; j<3; j++) {
//            onevertex[j]=[CubeManager getNormalVertexs][i*9+j+6];
//        }
//        [self.vertexColor setVertex:onevertex index:i];
//    }
//    [self.vertexColor bindBufferWithUsage:GL_STATIC_DRAW];
//    [self.vertexColor enableVertexInVertexAttrib:MaterialBindAttribLocationVertexColor numberOfCoordinates:3 attribOffset:0];
    
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
    [self.vertexNormal enableVertexInVertexAttrib:MaterialBindAttribLocationNormal numberOfCoordinates:3 attribOffset:0];
    
    GLKVector3 diffColor = GLKVector3Make(1.0, 1.0, 1.0);
    glUniform3fv(self.bindObject->uniforms[MaterialUniformLocationDiffuseLightColor], 1,diffColor.v);
    
    GLKVector3 ambientLigh = GLKVector3Make(1.0, 1.0, 1.0);
//    emerald    0.0215    0.1745    0.0215    0.07568    0.61424    0.07568    0.633    0.727811    0.633    0.6

    Material material;
    material.ambient = GLKVector3Make(0.0215, 0.1745, 0.0215);
    material.diffuse =GLKVector3Make(0.07568, 0.61424, 0.07568);
    material.specular =GLKVector3Make(0.633, 0.727811, 0.633);
    material.shininess =0.6;
    glUniform1fv(self.bindObject->uniforms[MaterialUniformLocationMaterialShininess],1,&material.shininess);
    glUniform3fv(self.bindObject->uniforms[MaterialUniformLocationMaterialDiffuse], 1, &material.diffuse);
    glUniform3fv(self.bindObject->uniforms[MaterialUniformLocationMaterialsSpecular], 1, &material.specular);
    glUniform3fv(self.bindObject->uniforms[MaterialUniformLocationMaterialAmbient], 1, &material.ambient);

    
    //    glUniform3fv(self.bindObject->uniforms[MaterialUniformLocationMaterial], 1,ambientLigh.v);
    
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
    angle ++ ;
    //        angle = 45;
    GLKMatrix4 mode =GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0);
    
    glUniformMatrix4fv(self.bindObject->uniforms[MVPMatrix], 1, 0,mvp.m);
    glUniformMatrix4fv(self.bindObject->uniforms[MaterialUniformLocationModel], 1, 0,mode.m);
    bool isSuccess = YES;
    mode = GLKMatrix4InvertAndTranspose(mode,&isSuccess);
    glUniformMatrix4fv(self.bindObject->uniforms[MaterialUniformLocationInvermodel], 1, 0,mode.m);
    
    GLKVector3 diffPostion = GLKVector3Make(5.0, 0.0,0);
    glUniform3fv(self.bindObject->uniforms[MaterialUniformLocationDiffusePositon], 1,diffPostion.v);
    GLKVector3 viewPos = GLKVector3Make(.0, 0.0,2.0);
    glUniform3fv(self.bindObject->uniforms[MaterialUniformLocationviewPos], 1,viewPos.v);
    
    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getNormalVertexNum]];
    //    [VertexElement drawElementIndexWithMode:GL_TRIANGLES indexNum:[CubeManager getVertexElementsNum] indexArr:[CubeManager getVertexElements]];
}



@end

