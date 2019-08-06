//
//  LightTestViewController.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "LightTestViewController.h"
#import "GLLightBindObject.h"
#import "CubeManager.h"

@interface LightTestViewController ()

@property (nonatomic ,strong) Vertex * vertexPostion ;
@property (nonatomic ,strong) Vertex * vertexColor ;
@property (nonatomic ,strong) Vertex * vertexNormal ;
@end

@implementation LightTestViewController

-(void)initSubObject{
    //生命周期三秒钟
    __weakSelf
    self.bindObject = [GLLightBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[MVPMatrix] = glGetUniformLocation(self.shader.program, "u_mvpMatrix");
        weakSelf.bindObject->uniforms[LightUniformLocationModel] = glGetUniformLocation(self.shader.program, "u_model");
        weakSelf.bindObject->uniforms[LightUniformLocationInvermodel] = glGetUniformLocation(self.shader.program, "u_inverModel");
        weakSelf.bindObject->uniforms[LightUniformLocationviewPos] = glGetUniformLocation(self.shader.program, "viewPos");
        weakSelf.bindObject->uniforms[MaterialObjectUniformLocationMaterialAmbient] = glGetUniformLocation(self.shader.program, "material.ambient");
        weakSelf.bindObject->uniforms[MaterialObjectUniformLocationMaterialDiffuse] = glGetUniformLocation(self.shader.program, "material.diffuse");
        weakSelf.bindObject->uniforms[MaterialObjectUniformLocationMaterialsSpecular] = glGetUniformLocation(self.shader.program, "material.specular");
        weakSelf.bindObject->uniforms[MaterialObjectUniformLocationMaterialShininess] = glGetUniformLocation(self.shader.program, "material.shininess");
        
        weakSelf.bindObject->uniforms[LightUniformLocationLightPos] = glGetUniformLocation(self.shader.program, "light.lightPos");
        weakSelf.bindObject->uniforms[LightUniformLocationLightAmbient] = glGetUniformLocation(self.shader.program, "light.ambient");
        weakSelf.bindObject->uniforms[LightUniformLocationLightsSpecular] = glGetUniformLocation(self.shader.program, "light.specular");
        weakSelf.bindObject->uniforms[LightUniformLocationLightDiffuse] = glGetUniformLocation(self.shader.program, "light.diffuse");
        
        
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
    //    [self.vertexColor enableVertexInVertexAttrib:LightBindAttribLocationVertexColor numberOfCoordinates:3 attribOffset:0];
    
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
    [self.vertexNormal enableVertexInVertexAttrib:LightBindAttribLocationNormal numberOfCoordinates:3 attribOffset:0];
    
    GLKVector3 ambientLigh = GLKVector3Make(1.0, 1.0, 1.0);
    //    emerald    0.0215    0.1745    0.0215    0.07568    0.61424    0.07568    0.633    0.727811    0.633    0.6
    
    MaterialObject material;
    material.ambient = GLKVector3Make(1.0f, 0.5f, 0.31f);
    material.diffuse =GLKVector3Make(1.0f, 0.5f, 0.31f);
    material.specular =GLKVector3Make(0.5f, 0.5f, 0.5f);
    material.shininess =0.08988;
    glUniform1fv(self.bindObject->uniforms[MaterialObjectUniformLocationMaterialShininess],1,&material.shininess);
    glUniform3fv(self.bindObject->uniforms[MaterialObjectUniformLocationMaterialDiffuse], 1, &material.diffuse);
    glUniform3fv(self.bindObject->uniforms[MaterialObjectUniformLocationMaterialsSpecular], 1, &material.specular);
    glUniform3fv(self.bindObject->uniforms[MaterialObjectUniformLocationMaterialAmbient], 1, &material.ambient);
    
    
    Light light;
    light.lightPos =  GLKVector3Make(2.0, 0.0,0);
    light.ambient  =GLKVector3Make(0.2,0.2,0.2);
    light.diffuse  =GLKVector3Make(0.5,0.5,0.5);
    light.specular  =GLKVector3Make(1.0,1.0,1.0);

    glUniform3fv(self.bindObject->uniforms[LightUniformLocationLightPos], 1, &light.lightPos);
    glUniform3fv(self.bindObject->uniforms[LightUniformLocationLightsSpecular], 1, &light.specular);
    
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
//            angle = 45;
    GLKMatrix4 mode =GLKMatrix4MakeRotation(45*M_PI/180, 0, 1, 0);
    
    glUniformMatrix4fv(self.bindObject->uniforms[MVPMatrix], 1, 0,mvp.m);
    glUniformMatrix4fv(self.bindObject->uniforms[LightUniformLocationModel], 1, 0,mode.m);
    bool isSuccess = YES;
    mode = GLKMatrix4InvertAndTranspose(mode,&isSuccess);
    glUniformMatrix4fv(self.bindObject->uniforms[LightUniformLocationInvermodel], 1, 0,mode.m);
    
    GLKVector3 viewPos = GLKVector3Make(.0, 0.0,5.0);
    glUniform3fv(self.bindObject->uniforms[LightUniformLocationviewPos], 1,viewPos.v);
    
    GLfloat timer = angle/10.0;
    GLKVector3 light = GLKVector3Make(sin(timer*2.0),sin( timer*0.7), sin(timer*1.3));
    GLKVector3 diffuseColor = GLKVector3Multiply(light, GLKVector3Make(0.5, 0.5, 0.5));
    GLKVector3 ambientColor = GLKVector3Multiply(light, GLKVector3Make(0.2, 0.2, 0.2));

    glUniform3fv(self.bindObject->uniforms[LightUniformLocationLightDiffuse], 1, &diffuseColor);
    glUniform3fv(self.bindObject->uniforms[LightUniformLocationLightAmbient], 1, &ambientColor);

    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getNormalVertexNum]];
}



@end

