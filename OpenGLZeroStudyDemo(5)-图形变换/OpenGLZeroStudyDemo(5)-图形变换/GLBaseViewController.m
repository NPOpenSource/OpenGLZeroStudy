//
//  GLBaseViewController.m
//  OpenGLZeroStudyDemo(5)-图形变换
//
//  Created by glodon on 2019/7/24.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseViewController.h"

@interface GLBaseViewController ()

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
}

-(void)createShader{
    
}


-(void)loadVertex{
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{

    
}




-(void)viewDidLoad{
    [super viewDidLoad];
    [self createEagContext];
    [self configure];
    [self createShader];
    [self loadVertex];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
