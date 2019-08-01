//
//  SunViewController.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/31.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "SunViewController.h"
#import "SunBindObject.h"
#import "sphere.h"

@interface SunViewController ()
@property(nonatomic,strong)TextureUnit * sun;
@property (nonatomic ,strong) TextureUnit * earth ;
@property (nonatomic ,strong) TextureUnit * moon;
@property (nonatomic ,strong) Vertex * vertexPostion ;
@property (nonatomic ,strong) Vertex * vertexTexture ;

@end

@implementation SunViewController
-(void)initSubObject{
    //生命周期三秒钟
    __weakSelf
    self.bindObject = [SunBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[WorldMVPMatrix] =  glGetUniformLocation(program, "mvp");
        weakSelf.bindObject->uniforms[WorldSample] =  glGetUniformLocation(self.shader.program, "u_samplers2D");
    };
}
-(void)createShader{
    __weakSelf
    self.shader = [Shader new];
    [self.shader compileLinkSuccessShaderName:self.bindObject.getShaderName completeBlock:^(GLuint program) {
        [weakSelf.bindObject BindAttribLocation:program];
    }];
    if (self.bindObject.uniformSetterBlock) {
        self.bindObject.uniformSetterBlock(self.shader.program);
    }
}

-(void)createTextureUnit{
    UIImage *  image = [UIImage imageNamed:@"sun.png"];
    self.sun = [TextureUnit new];
    [self.sun setImage:image IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil];
     image = [UIImage imageNamed:@"Earth512x256.jpg"];
    self.earth = [TextureUnit new];
    [self.earth setImage:image IntoTextureUnit:GL_TEXTURE1 andConfigTextureUnit:nil];
     image = [UIImage imageNamed:@"sun.png"];
    self.moon = [TextureUnit new];
    [self.moon setImage:image IntoTextureUnit:GL_TEXTURE2 andConfigTextureUnit:nil];
}

-(void)loadVertex{
    //顶点数据缓存
    self.vertexPostion= [Vertex new];
    int vertexNum =sizeof(sphereVerts) /(3 * sizeof(GLfloat));
    [self.vertexPostion allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=sphereVerts[i*3+j];
        }
        [self.vertexPostion setVertex:onevertex index:i];
    }
    [self.vertexPostion bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexPostion enableVertexInVertexAttrib:WorldStartPosition numberOfCoordinates:3 attribOffset:0];

    self.vertexTexture = [Vertex new];
    int vertexTextureNum  = sizeof(sphereTexCoords)/(2*sizeof(GLfloat));
    [self.vertexTexture allocVertexNum:vertexTextureNum andEachVertexNum:2];

    for (int i=0; i<vertexTextureNum; i++) {
        float onevertex[2];
        for (int j=0; j<2; j++) {
            onevertex[j]=sphereTexCoords[i*2+j];
        }
        [self.vertexTexture setVertex:onevertex index:i];
    }
    [self.vertexTexture bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexTexture enableVertexInVertexAttrib:WorldTexture numberOfCoordinates:2 attribOffset:0];

}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glClearColor(0, 0, 0, 1);
    [self drawSun];
    [self drawEarth];
    [self drawMoon];
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

-(void)drawSun{
    [self.sun bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[WorldSample]];
    static GLfloat angle=0;
    angle++;
   
    GLKMatrix4  mvp= [self getMVP];
    GLKMatrix4 mode =GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0);
    GLKMatrix4 result=  GLKMatrix4Multiply(mvp,mode);
    glUniformMatrix4fv(self.bindObject->uniforms[WorldMVPMatrix], 1, 0,result.m);
    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:sphereNumVerts];
}
-(void)drawEarth{
    
    [self.earth bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[WorldSample]];
    static GLfloat angle=0;
    angle++;
    
    GLKMatrix4  mvp= [self getMVP];
    
    GLKMatrix4 mode =GLKMatrix4MakeScale(0.5, 0.5, 0.5);
    mode = GLKMatrix4Multiply(GLKMatrix4MakeRotation(2*angle*M_PI/180, 0, 1, 0),mode);
    mode = GLKMatrix4Multiply(GLKMatrix4MakeTranslation(1.5, 0, 0),mode);
    mode = GLKMatrix4Multiply(GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0),mode);

    GLKMatrix4 result=  GLKMatrix4Multiply(mvp,mode);
    
    glUniformMatrix4fv(self.bindObject->uniforms[WorldMVPMatrix], 1, 0,result.m);
    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:sphereNumVerts];

}

-(void)drawMoon{
    [self.moon bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[WorldSample]];
    static GLfloat angle=0;
    angle++;
    
    GLKMatrix4  mvp= [self getMVP];
    
    GLKMatrix4 mode =GLKMatrix4MakeScale(0.25, 0.25, 0.25);
    mode = GLKMatrix4Multiply(GLKMatrix4MakeRotation(10*angle*M_PI/180, 0, 1, 0),mode);
    mode = GLKMatrix4Multiply(GLKMatrix4MakeTranslation(1.5, 0, 0),mode);
    mode = GLKMatrix4Multiply(GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0),mode);
    mode = GLKMatrix4Translate(mode, 2.0, 0, 0);
    mode = GLKMatrix4Rotate(mode,2*angle*M_PI/180, 0, 1, 0);

    GLKMatrix4 result=  GLKMatrix4Multiply(mvp,mode);
    
    glUniformMatrix4fv(self.bindObject->uniforms[WorldMVPMatrix], 1, 0,result.m);
    [self.vertexPostion drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:sphereNumVerts];
}


@end
