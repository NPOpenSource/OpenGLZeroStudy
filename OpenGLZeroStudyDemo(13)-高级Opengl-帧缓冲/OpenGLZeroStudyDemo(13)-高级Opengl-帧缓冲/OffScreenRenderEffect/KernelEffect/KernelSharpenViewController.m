//
//  KernelSharpenViewController.m
//  OpenGLZeroStudyDemo(13)-高级Opengl-帧缓冲
//
//  Created by glodon on 2019/8/30.
//  Copyright © 2019 openSource. All rights reserved.
//

#import "KernelSharpenViewController.h"

@interface KernelSharpenViewController ()

@end

@implementation KernelSharpenViewController
-(void)createShader{
    [super createShader];
    self.frameShader = [Shader new];
    [self.frameShader compileLinkSuccessShaderName:@"KernelSharpen" completeBlock:^(GLuint program) {
        [self.frameBufferBinder BindAttribLocation:program];
    }];
    [self.frameBufferBinder setUniformLocation:self.frameShader.program];
}


@end
