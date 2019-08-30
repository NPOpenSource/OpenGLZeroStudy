//
//  KernelBlurViewController.m
//  OpenGLZeroStudyDemo(13)-高级Opengl-帧缓冲
//
//  Created by glodon on 2019/8/30.
//  Copyright © 2019 openSource. All rights reserved.
//

#import "KernelBlurViewController.h"

@interface KernelBlurViewController ()

@end

@implementation KernelBlurViewController
-(void)createShader{
    [super createShader];
    self.frameShader = [Shader new];
    [self.frameShader compileLinkSuccessShaderName:@"KernelBlur" completeBlock:^(GLuint program) {
        [self.frameBufferBinder BindAttribLocation:program];
    }];
    [self.frameBufferBinder setUniformLocation:self.frameShader.program];
}

@end
