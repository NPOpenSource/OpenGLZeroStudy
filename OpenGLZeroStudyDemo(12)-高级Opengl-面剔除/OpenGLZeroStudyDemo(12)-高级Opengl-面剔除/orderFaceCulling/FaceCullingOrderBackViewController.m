//
//  FaceCullingOrderBackViewController.m
//  OpenGLZeroStudyDemo(12)-高级Opengl-面剔除
//
//  Created by glodon on 2019/8/27.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FaceCullingOrderBackViewController.h"
#import "FaceCullingOrderFrontBindObject.h"
@interface FaceCullingOrderBackViewController ()

@end

@implementation FaceCullingOrderBackViewController

-(void)initSubObject{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    glEnable(GL_CULL_FACE);
    self.bindObject = [FaceCullingOrderFrontBindObject new];
    glCullFace(GL_BACK);
}

@end
