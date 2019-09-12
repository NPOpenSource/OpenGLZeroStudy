//
//  GLBaseViewController.m
//  OpenGLZeroStudyDemo(5)-图形变换
//
//  Created by glodon on 2019/7/24.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseViewController.h"

@interface GLBaseViewController ()
@property (nonatomic ,strong) TextureUnit * textureUnit0 ;

@end

@implementation GLBaseViewController

-(void)createEagContext{
    self.eagcontext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.eagcontext];
}

-(void)configure{
    GLKView *view = (GLKView*)self.view;
    view.context = self.eagcontext;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
   
    
}
-(void)initCustom{
    self.vertexArr = [NSMutableArray array];
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}

-(void)initSubObject{
    
}
-(void)createTextureUnit{
    UIImage *  image = [UIImage imageNamed:@"ball.png"];
    self.textureUnit0 = [TextureUnit new];
    [self.textureUnit0 setImage:image IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil];
    [self.textureUnit0 bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[Samplers2D]];
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
    self.bindObject->uniforms[Samplers2D] =  glGetUniformLocation(self.shader.program, "u_samplers2D");
    self.bindObject->uniforms[MVPMatrix] = glGetUniformLocation(self.shader.program, "u_mvpMatrix");
}

-(void)loadVertex{
  
   
}

-(GLKMatrix4 )mvp{
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              20.0f);
   GLKMatrix4 modelviewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 1.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    return GLKMatrix4Multiply(
                              projectionMatrix,
                              modelviewMatrix);;
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
//    [super glkView:view drawInRect:rect];
       glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glClearColor(0.3, 0.0, 0.0, 1);
    glUniformMatrix4fv(self.bindObject->uniforms[MVPMatrix], 1, 0,self.mvp.m);
}
                        
-(void)viewDidLoad{
    [super viewDidLoad];
    [self createEagContext];
    [self initSubObject];
    [self configure];
    [self initCustom];
    [self createShader];
    [self createTextureUnit];
    [self loadVertex];
}


@end
