//
//  GLFragCoordViewController.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLFragCoordViewController.h"
#import "GLFragCoordBindObject.h"
#import "CubeManager.h"

@interface GLFragCoordViewController ()
@property (nonatomic ,strong) Vertex * vertex;

@end

@implementation GLFragCoordViewController
-(void)initSubObject{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    self.bindObject = [GLFragCoordBindObject new];
}


-(void)loadVertex{
    self.vertex= [Vertex new];
    int vertexNum =[CubeManager getTextureNormalVertexNum];
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:3];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[3];
        for (int j=0; j<3; j++) {
            onevertex[j]=[CubeManager getTextureNormalVertexs][i*8+j];
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
}

-(void)_bindViewMatrix4:(GLBaseBindObject*)bindObject{
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(bindObject->uniforms[FC_uniform_view], 1, 0,viewMatrix.m);
}
-(void)_bindProjectionMatrix4:(GLBaseBindObject*)bindObject{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(100.0f),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(bindObject->uniforms[FC_uniform_projection], 1, 0,projectionMatrix.m);
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    /// 模板测试虽然开启了. 但是不起作用.
    
    glClearStencil(0);
    glClearColor(1,1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    GLKMatrix4 cubeMode1 =[self _getModeMatrix4Location:GLKVector3Make(0.0f, 0.0f, 1.0f)];
    static CGFloat angle = 0;
    angle++;
    cubeMode1 = GLKMatrix4Rotate(cubeMode1, angle*M_PI/180.0, 0, 1, 0);
    [self.shader use];
    [self _bindViewMatrix4:self.bindObject];
    [self _bindProjectionMatrix4:self.bindObject];

    [self _drawCubeMode:cubeMode1 bindObject:self.bindObject];
    
}

-(GLKMatrix4)_getModeMatrix4Location:(GLKVector3)location{
    GLKMatrix4  mode = GLKMatrix4Identity;
    mode =  GLKMatrix4TranslateWithVector3(mode, location);
    //    mode = GLKMatrix4Rotate(mode, 30*M_PI/180.0, 0, 1, 0);
    return mode;
}

-(void)_drawCubeMode:(GLKMatrix4)mode bindObject:(GLBaseBindObject*)bindObject{
    
    glUniformMatrix4fv(bindObject->uniforms[FC_uniform_model], 1, 0,mode.m);
    glUniform1f(bindObject->uniforms[FC_uniform_screenWidth], UIScreen.mainScreen.bounds.size.width*UIScreen.mainScreen.scale);
    [self.vertex enableVertexInVertexAttrib:FC_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:[CubeManager getTextureNormalVertexNum]];
}

@end
