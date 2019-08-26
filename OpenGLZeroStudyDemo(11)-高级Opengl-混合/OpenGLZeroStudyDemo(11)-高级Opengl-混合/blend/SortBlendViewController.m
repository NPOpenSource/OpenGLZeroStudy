//
//  SortBlendViewController.m
//  OpenGLZeroStudyDemo(11)-高级Opengl-混合
//
//  Created by glodon on 2019/8/22.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "SortBlendViewController.h"

@interface SortBlendViewController ()

@end

@implementation SortBlendViewController

-(GLKVector3 *)_getWindowsLocation{
    
        GLKVector3 vegetation[5]={
            GLKVector3Make(-0.3f, 0.0f, -2.3f),
            GLKVector3Make(0.5f, 0.0f, -0.6f),
            GLKVector3Make(-1.5f, 0.0f, -0.48f),
            GLKVector3Make( 1.5f, 0.0f, 0.51f),
            GLKVector3Make(0.0f, 0.0f, 0.7f),
    
        };
    
    return vegetation;
}

@end
