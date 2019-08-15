//
//  MoreLightSourceViewController.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/8.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "MoreLightSourceViewController.h"
#import "MoreLightSourceBindObject.h"
#import "CubeManager.h"

@interface MoreLightSourceViewController ()

@property (nonatomic ,strong) Vertex * vertexPostion ;
@property (nonatomic ,strong) Vertex * vertexTexture ;
@property (nonatomic ,strong) Vertex * vertexNormal ;
@property (nonatomic ,strong) TextureUnit * textureDiffuse ;
@property (nonatomic ,strong) TextureUnit * textureSpecular ;
@end

@implementation MoreLightSourceViewController


-(void)initSubObject{
    //生命周期三秒钟
    __weakSelf
    self.bindObject = [MoreLightSourceBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[MVPMatrix] = glGetUniformLocation(self.shader.program, "u_mvpMatrix");
        weakSelf.bindObject->uniforms[MLS_UniformLocationModel] = glGetUniformLocation(self.shader.program, "u_model");
        weakSelf.bindObject->uniforms[MLS_UniformLocationInvermodel] = glGetUniformLocation(self.shader.program, "u_inverModel");
        weakSelf.bindObject->uniforms[MLS_UniformLocationviewPos] = glGetUniformLocation(self.shader.program, "viewPos");
        //材质
        weakSelf.bindObject->uniforms[MLS_UniformLocationMaterialTextureSpecular]= glGetUniformLocation(self.shader.program, "material.specular");
        weakSelf.bindObject->uniforms[MLS_UniformLocationMaterialTextureDiffuse] = glGetUniformLocation(self.shader.program, "material.diffuse");
        weakSelf.bindObject->uniforms[MLS_UniformLocationMaterialTextureshininess] = glGetUniformLocation(self.shader.program, "material.shininess");
        ///平行光
        weakSelf.bindObject->uniforms[MLS_UniformLocationDirLightDirection] = glGetUniformLocation(self.shader.program, "dirLight.direction");
        weakSelf.bindObject->uniforms[MLS_UniformLocationDirLightAmbient] = glGetUniformLocation(self.shader.program, "dirLight.ambient");
        weakSelf.bindObject->uniforms[MLS_UniformLocationDirLightDiffuse] = glGetUniformLocation(self.shader.program, "dirLight.diffuse");
        weakSelf.bindObject->uniforms[MLS_UniformLocationDirLightSpecular] = glGetUniformLocation(self.shader.program, "dirLight.specular");
        ///点光 0
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroPos] = glGetUniformLocation(self.shader.program, "pointLights[0].position");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroAmbient] = glGetUniformLocation(self.shader.program, "pointLights[0].ambient");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroDiffuse] = glGetUniformLocation(self.shader.program, "pointLights[0].diffuse");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroSpecular] = glGetUniformLocation(self.shader.program, "pointLights[0].specular");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroConstant] = glGetUniformLocation(self.shader.program, "pointLights[0].constant");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroLinear] = glGetUniformLocation(self.shader.program, "pointLights[0].linear");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroQuadratic] = glGetUniformLocation(self.shader.program, "pointLights[0].quadratic");
        ///点光 1
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightOnePos] = glGetUniformLocation(self.shader.program, "pointLights[1].position");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightOneAmbient] = glGetUniformLocation(self.shader.program, "pointLights[1].ambient");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightOneDiffuse] = glGetUniformLocation(self.shader.program, "pointLights[1].diffuse");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightOneSpecular] = glGetUniformLocation(self.shader.program, "pointLights[1].specular");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightOneConstant] = glGetUniformLocation(self.shader.program, "pointLights[1].constant");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightZeroLinear] = glGetUniformLocation(self.shader.program, "pointLights[1].linear");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightOneQuadratic] = glGetUniformLocation(self.shader.program, "pointLights[1].quadratic");
        ///点光 2
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightTwoPos] = glGetUniformLocation(self.shader.program, "pointLights[2].position");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightTwoAmbient] = glGetUniformLocation(self.shader.program, "pointLights[2].ambient");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightTwoDiffuse] = glGetUniformLocation(self.shader.program, "pointLights[2].diffuse");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightTwoSpecular] = glGetUniformLocation(self.shader.program, "pointLights[2].specular");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightTwoConstant] = glGetUniformLocation(self.shader.program, "pointLights[2].constant");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightTwoLinear] = glGetUniformLocation(self.shader.program, "pointLights[2].linear");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightTwoQuadratic] = glGetUniformLocation(self.shader.program, "pointLights[2].quadratic");
        ///点光 3
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightThreePos] = glGetUniformLocation(self.shader.program, "pointLights[3].position");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightThreeAmbient] = glGetUniformLocation(self.shader.program, "pointLights[3].ambient");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightThreeDiffuse] = glGetUniformLocation(self.shader.program, "pointLights[3].diffuse");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightThreeSpecular] = glGetUniformLocation(self.shader.program, "pointLights[3].specular");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightThreeConstant] = glGetUniformLocation(self.shader.program, "pointLights[3].constant");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightThreeLinear] = glGetUniformLocation(self.shader.program, "pointLights[3].linear");
        weakSelf.bindObject->uniforms[MLS_UniformLocationPointLightThreeQuadratic] = glGetUniformLocation(self.shader.program, "pointLights[3].quadratic");
        ///聚光
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightPos] = glGetUniformLocation(self.shader.program, "spotLight.position");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightDirection] = glGetUniformLocation(self.shader.program, "spotLight.direction");
        
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightAmbient] = glGetUniformLocation(self.shader.program, "spotLight.ambient");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightDiffuse] = glGetUniformLocation(self.shader.program, "spotLight.diffuse");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightSpecular] = glGetUniformLocation(self.shader.program, "spotLight.specular");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightConstant] = glGetUniformLocation(self.shader.program, "spotLight.constant");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightLinear] = glGetUniformLocation(self.shader.program, "spotLight.linear");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightQuadratic] = glGetUniformLocation(self.shader.program, "spotLight.specular");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightcutOff] = glGetUniformLocation(self.shader.program, "spotLight.cutOff");
        weakSelf.bindObject->uniforms[MLS_UniformLocationSpotLightouterCutOff] = glGetUniformLocation(self.shader.program, "spotLight.outerCutOff");
        
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

-(void)createTextureUnit{
    UIImage *  image = [UIImage imageNamed:@"container2.png"];
    self.textureDiffuse = [TextureUnit new];
    [self.textureDiffuse setImage:image IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil];
    
    image = [UIImage imageNamed:@"container2_specular.png"];
    self.textureSpecular =[TextureUnit new];
    [self.textureSpecular setImage:image IntoTextureUnit:GL_TEXTURE1 andConfigTextureUnit:nil];
    
}

double MLS_radians(int angle){
    return angle*M_PI/180;
}

-(void)loadVertex{
    //顶点数据缓存
    self.vertexPostion= [Vertex new];
    int vertexNum =[CubeManager getTextureNormalVertexNum];
    [self.vertexPostion allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getTextureNormalVertexs][i*8+j];
        }
        [self.vertexPostion setVertex:onevertex index:i];
    }
    [self.vertexPostion bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexPostion enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:3 attribOffset:0];
    
    self.vertexTexture = [Vertex new];
    [self.vertexTexture allocVertexNum:vertexNum andEachVertexNum:2];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[2];
        for (int j=0; j<2; j++) {
            onevertex[j]=[CubeManager getTextureNormalVertexs][i*8+j+6];
        }
        [self.vertexTexture setVertex:onevertex index:i];
    }
    [self.vertexTexture bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexTexture enableVertexInVertexAttrib:MLS_BindAttribLocationTexture numberOfCoordinates:2 attribOffset:0];
    
    self.vertexNormal= [Vertex new];
    [self.vertexNormal allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getTextureNormalVertexs][i*8+j+3];
        }
        [self.vertexNormal setVertex:onevertex index:i];
    }
    [self.vertexNormal bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexNormal enableVertexInVertexAttrib:MLS_BindAttribLocationNormal numberOfCoordinates:3 attribOffset:0];
    
    GLKVector3 ambientLigh = GLKVector3Make(1.0, 1.0, 1.0);
    
    
    MLS_Material material;
    
    material.shininess =0.6;
    [self.textureDiffuse bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[MLS_UniformLocationMaterialTextureDiffuse]];
    [self.textureSpecular bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[MLS_UniformLocationMaterialTextureSpecular]];
    glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationMaterialTextureshininess], 1, &material.shininess);
    
    MLS_DirLight dirlight ;

    dirlight.direction = GLKVector3Make(-0.2f, -1.0f, -0.3f);
    dirlight.ambient =GLKVector3Make(0.3f, 0.24f, 0.14f);
    dirlight.diffuse =GLKVector3Make( 0.7f, 0.42f, 0.26f);
    dirlight.specular =GLKVector3Make(0.5f, 0.5f, 0.5f);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationDirLightDirection], 1, &dirlight.direction);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationDirLightAmbient], 1, &dirlight.ambient);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationDirLightSpecular], 1, &dirlight.specular);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationDirLightDiffuse], 1, &dirlight.diffuse);

    GLKVector3 pointLightPositions[] = {
       GLKVector3Make( 0.7f,  0.2f,  2.0f),
        GLKVector3Make( 2.3f, -3.3f, -4.0f),
       GLKVector3Make(-4.0f,  2.0f, -12.0f),
        GLKVector3Make( 0.0f,  0.0f, -3.0f)
    };
    MLS_PointLight pointLight[4];
    for (int i=0; i<4; i++) {
        pointLight[i].position= pointLightPositions[i];
        pointLight[i].ambient = GLKVector3Make(0.05f, 0.05f, 0.05f);;
        pointLight[i].diffuse = GLKVector3Make(0.8f, 0.8f, 0.8f);
        pointLight[i].specular = GLKVector3Make( 1.0f, 1.0f, 1.0f);
        pointLight[i].constant = 1.0;
        pointLight[i].linear = 0.09;
        pointLight[i].quadratic = 0.032;
    }
 
    for (int i=0; i<4; i++) {
        glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationPointLightZeroPos+i*7], 1, &pointLight[i].position);
        glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationPointLightZeroAmbient+i*7], 1, &pointLight[i].ambient);

        glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationPointLightZeroDiffuse+i*7], 1, &pointLight[i].diffuse);

        glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationPointLightZeroSpecular+i*7], 1, &pointLight[i].specular);

        glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationPointLightZeroConstant+i*7], 1, &pointLight[i].constant);

        glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationPointLightZeroLinear+i*7], 1, &pointLight[i].linear);
        glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationPointLightZeroQuadratic+i*7], 1, &pointLight[i].quadratic);
    }
    
    
    MLS_SpotLight spotLight;
    spotLight.position =  GLKVector3Make(0.0f, 0.0f, 3.0f);
    spotLight.ambient  =GLKVector3Make( 0.0f, 0.0f, 0.0f);
    spotLight.diffuse  =GLKVector3Make(1.0f, 1.0f, 1.0f);
    spotLight.specular  =GLKVector3Make(1.0,1.0,1.0);
    spotLight.constant = 1.0;
    spotLight.linear = 0.09f    ;
    spotLight.quadratic = 0.032f;
    //     0.0f, 0.0f, 3.0f
    const float YAW         = -90.0f;
    const float PITCH       =  0.0f;
    GLKVector3 front;
    front.x = cos(MLS_radians(YAW)) * cos(MLS_radians(PITCH));
    front.y = sin(MLS_radians(PITCH));
    front.z = sin(MLS_radians(YAW)) * cos(MLS_radians(PITCH));
    front = GLKVector3Normalize(front);
    spotLight.direction = front;
    spotLight.cutOff = cos(MLS_radians(12.5));
    spotLight.outerCutOff =cos(MLS_radians(15.0));
    
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightPos], 1, &spotLight.position);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightDirection], 1, &spotLight.direction);

    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightAmbient], 1, &spotLight.ambient);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightSpecular], 1, &spotLight.specular);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightDiffuse], 1, &spotLight.diffuse);
    glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightConstant], 1, &spotLight.constant);
    glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightLinear], 1, &spotLight.linear);
    glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightQuadratic], 1, &spotLight.quadratic);
    glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightcutOff], 1, &spotLight.cutOff);
    glUniform1fv(self.bindObject->uniforms[MLS_UniformLocationSpotLightouterCutOff], 1, &spotLight.outerCutOff);

}


-(GLKMatrix4)getMVP{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              100.0f);
    GLKMatrix4 modelviewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0f, 0.0f, 3.0f,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    return GLKMatrix4Multiply(projectionMatrix,modelviewMatrix);
}




-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
   glClearColor(0.75f, 0.52f, 0.3f, 1.0f);
    GLKMatrix4  mvp= [self getMVP];
    
    glUniformMatrix4fv(self.bindObject->uniforms[MVPMatrix], 1, 0,mvp.m);
    
    GLKVector3 viewPos = GLKVector3Make(.0, 0.0,2.0);
    glUniform3fv(self.bindObject->uniforms[MLS_UniformLocationviewPos], 1,viewPos.v);
    
    GLKVector3 cubePositions[] = {
        GLKVector3Make( 0.0f,  0.0f,  0.0f),
        GLKVector3Make( 2.0f,  5.0f, -15.0f),
        GLKVector3Make(-1.5f, -2.2f, -2.5f),
        GLKVector3Make(-3.8f, -2.0f, -12.3f),
        GLKVector3Make( 2.4f, -0.4f, -3.5f),
        GLKVector3Make(-1.7f,  3.0f, -7.5f),
        GLKVector3Make( 1.3f, -2.0f, -2.5f),
        GLKVector3Make( 1.5f,  2.0f, -2.5f),
        GLKVector3Make( 1.5f,  0.2f, -1.5f),
        GLKVector3Make(-1.3f,  1.0f, -1.5f)
    };
    
    static GLfloat angleTimer=0;
    angleTimer +=5;
    for (int i=0; i<10; i++) {
        GLKMatrix4 mode =GLKMatrix4Identity;
        
        GLKVector3 temp =cubePositions[i];
        mode = GLKMatrix4TranslateWithVector3(mode, temp);
        float angle = 20.0f * i+angleTimer;
        mode = GLKMatrix4RotateWithVector3(mode, angle*M_PI/180, GLKVector3Make(1.0, 0.3, 0.5));
        glUniformMatrix4fv(self.bindObject->uniforms[MLS_UniformLocationModel], 1, 0,mode.m);
        bool isSuccess = YES;
        mode = GLKMatrix4InvertAndTranspose(mode,&isSuccess);
        glUniformMatrix4fv(self.bindObject->uniforms[MLS_UniformLocationInvermodel], 1, 0,mode.m);
        
        [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getNormalVertexNum]];
    }
    
    
}



@end
