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
    
}

-(void)initSubObject{
    
}
-(void)createTextureUnit{
  
}

-(void)createShader{
    __weakSelf
    self.shader = [Shader new];
    [self.shader compileLinkSuccessShaderName:self.bindObject.getShaderName completeBlock:^(GLuint program) {
        [weakSelf.bindObject BindAttribLocation:program];
    }];
    [self.bindObject setUniformLocation:self.shader.program];
    
 
}

-(void)loadVertex{
    
    
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
  
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
