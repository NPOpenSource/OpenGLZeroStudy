//
//  DepthTestCloseMaskOpenDTViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/20.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestCloseMaskOpenDTViewController.h"

@implementation DepthTestCloseMaskOpenDTViewController
-(void)initSubObject{
    //生命周期三秒钟
    [super initSubObject];
    glEnable(GL_DEPTH_TEST);
    self.glDrawConfig = ^{
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    };
    self.glDrawMaskBeginConfig = ^{
        ///清除深度值.要不下一次还是会进行深度比较的
        glDepthMask(GL_FALSE);
    };
    self.glDrawMaskEndConfig = ^{
        glDepthMask(GL_TRUE);
    };
    
}
@end
