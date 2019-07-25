//
//  CubeViewController.m
//  OpenGLZeroStudyDemo(5)-图形变换
//
//  Created by glodon on 2019/7/24.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "CubeViewController.h"
#import "os_cube.h"

@interface CubeViewController ()
@property (nonatomic ,strong) Vertex * vertexColor ;
@property (nonatomic ,strong) VertexElement * vertexElement ;
@property (nonatomic ,assign) GLuint modelMat4 ;
@property (nonatomic ,assign) GLuint eyeMat4 ;
@property (nonatomic ,assign) GLuint projectMat4;

@end

@implementation CubeViewController

#define CubeVertexNum 8

-(void)createShader{
     glEnable(GL_DEPTH_TEST);
    self.shader = [Shader new];
    [self.shader compileLinkSuccessShaderName:@"Shader" completeBlock:^(GLuint program) {
        glBindAttribLocation(program, GLKVertexAttribPosition, "position");  // 0代表枚举位置
        glBindAttribLocation(program, GLKVertexAttribColor, "vertexColor");
    }];

    self.modelMat4 = glGetUniformLocation(self.shader.program, "modelMat4");
    self.eyeMat4 = glGetUniformLocation(self.shader.program, "eyeMat4");
    self.projectMat4 = glGetUniformLocation(self.shader.program, "projectMat4");
}

-(void)loadVertex{
//    glEnable(GL_DEPTH_TEST);
    self.vertex = [Vertex new];
    int vertexNum =sizeof(cubeVertices)/(3 * sizeof(GLfloat));
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:3];
    GLfloat tempVertex[3];
    for (int i =0; i<vertexNum; i++) {
        for (int j=0; j<3; j++) {
            tempVertex[j]=cubeVertices[i*3+j];
        }
        [self.vertex setVertex:tempVertex index:i];
    }
    
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:GLKVertexAttribPosition numberOfCoordinates:3 attribOffset:0];
    self.vertexColor = [Vertex new];
    vertexNum =sizeof(cubeColors)/(3 * sizeof(GLfloat));
    [self.vertexColor allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i =0; i<vertexNum; i++) {
        for (int j=0; j<3; j++) {
            tempVertex[j]=cubeColors[i*3+j];
        }
        [self.vertexColor setVertex:tempVertex index:i];
    }
    [self.vertexColor bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertexColor enableVertexInVertexAttrib:GLKVertexAttribColor numberOfCoordinates:3 attribOffset:0];
    self.vertexElement = [VertexElement new];
    [self.vertexElement allocWithIndexNum:sizeof(tfan1)/sizeof(tfan1[0]) indexArr:tfan1];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    // 清除颜色缓冲区
    glClearColor(1,1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    // 使用着色器程序
    glUseProgram(self.shader.program);
    GLKMatrix4  mat= GLKMatrix4Identity;
    mat =  GLKMatrix4MakeScale(0.5,0.5,0.5);
    mat =  GLKMatrix4Rotate(mat, M_PI/180.0*45, 1.0, 1.0, 0.0);

    glUniformMatrix4fv(self.modelMat4, 1, GL_FALSE,&mat);
     mat= GLKMatrix4Identity;
     mat =  GLKMatrix4MakeLookAt(0,0,-1,0,0,1,0,1,0);
    glUniformMatrix4fv(self.eyeMat4, 1, GL_FALSE,&mat);

    float aspect = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(90), aspect, 0.1f, 2);
    glUniformMatrix4fv(self.projectMat4, 1, GL_FALSE,&projectionMatrix);
    
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:sizeof(cubeVertices)/(3 * sizeof(GLfloat))];
    [self.vertexColor drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:sizeof(cubeColors)/(3 * sizeof(GLfloat))];
    [self.vertexElement drawElementIndexWithMode:GL_TRIANGLES];
}

@end
